public with sharing class SmartFactory {
	// can't map by Schema.sObjectType, use object name string instead
	static map<string, set<string>> excludedFields = new map<string, set<string>>{
		'All' => new set<string>{'OwnerId', 'LastModifiedById'},
		'Account' => new set<string>{'FirstName', 'LastName'}
	};
	
	public static SObject createSObject(string objectType) {
		return createSObject(objectType, false);
	}
	
	public static SObject createSObject(string objectType, boolean cascade) {
		System.debug('objectType ' + objectType);
		
		Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe(); 
		
		Schema.sObjectType token = globalDescribe.get(objectType);
		if (token == null) {
			throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + objectType);
		}
		System.debug('token ' + token);
		SObject obj;		
		Map<String, Schema.SObjectField> fieldMap;
		
		// TODO create external service to dynamically generate SmartFactoryHelper class
		// Or Apex to Apex call using WSDL or REST API
		// Also vote for this idea for dynamic casting: https://sites.secure.force.com/success/ideaView?id=08730000000BpwmAAC
		obj = SmartFactoryHelper.newSObject(token);
		fieldMap = SmartFactoryHelper.getFieldMap(token);
		
		for (Schema.SObjectField field : fieldMap.values()) {
			setFieldValue(obj, field, cascade);
		}
		
		System.debug('SmartFactory object created: ' + obj);
		return obj;
	}
	
	public static string generateHelperClass() {
		Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
		
		string body = '\npublic with sharing class SmartFactoryHelper {\n';
		
		body += generateHelperNewSObject();
		body += generateHelperGetFieldMap();

		body += '} // SmartFactoryHelper\n';
		
		System.debug(body);
		return body;
	}
	
	static string generateHelperNewSObject() {
		string body = 'public static SObject newSObject(Schema.sObjectType token) {\n';
			
		for (string sObjectType : Schema.getGlobalDescribe().keySet()) {
			body += 'if (token.getDescribe().getName() == \'' + sObjectType + '\') { return (' + sObjectType + ')token.newSObject(); }\n';
		}
		
		body += 'throw new UnsupportedObjectTypeException(\'Unsupported ObjectType \' + token);\n' +
			'} // newSObject\n\n';
			
		return body;		
	}
	
	static string generateHelperGetFieldMap() {
		string body = 'public static Map<String, Schema.SObjectField> getFieldMap(Schema.sObjectType token) {\n';
			
		for (string sObjectType : Schema.getGlobalDescribe().keySet()) {
			body += 'if (token.getDescribe().getName() == \'' + sObjectType + '\') { return Schema.sObjectType.' + sObjectType + '.fields.getMap(); }\n';
		}
		
		body += 'throw new UnsupportedObjectTypeException(\'Unsupported ObjectType \' + token);\n' +
			'} // getFieldMap\n\n';
			
		return body;		
	}
	
	static boolean isExcludedField(Schema.DescribeFieldResult fieldDescribe) {
		return excludedFields.get('All').contains(fieldDescribe.getName());
	}
	
	static boolean isExcludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		set<string> fields = excludedFields.get(obj.getSObjectType().getDescribe().getName());
		return fields == null ? false : fields.contains(fieldDescribe.getName());
	}
	
	static boolean isPersonAccountField(Schema.DescribeFieldResult fieldDescribe) {
		return fieldDescribe.getName().startsWith('Person') && !fieldDescribe.isCustom();
	}
	
	static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade) {
		Schema.DescribeFieldResult fieldDescribe = field.getDescribe();

		if (fieldDescribe.isCreateable() && 
			!fieldDescribe.getName().endsWith('pc') && // lookup fields
			!isExcludedField(fieldDescribe) &&
			!isExcludedField(obj, fieldDescribe) &&
			!isPersonAccountField(fieldDescribe)) {
				
			if (fieldDescribe.getType() == Schema.DisplayType.String) {
				System.debug('Setting field ' + fieldDescribe.getName());
				obj.put(field, 'a'); 
			} else if (fieldDescribe.getType() == Schema.DisplayType.Reference) {
				string referenceObjectType = fieldDescribe.getReferenceTo()[0].getDescribe().getName();
				
				if (referenceObjectType == 'RecordType') {
					setRecordType(obj);
				} else if (cascade && referenceObjectType != obj.getSObjectType().getDescribe().getName()) {
					// TODO avoid infinite loop for same-type references
					System.debug('Creating reference to ' + referenceObjectType);
					SObject reference = createSObject(referenceObjectType);
					insert reference;
					obj.put(field, reference.Id);
				}
			} // TODO put field values for rest of Schema.DisplayTypes
		}	
	}
	
	static void setRecordType(SObject obj) {
		List<Schema.RecordTypeInfo> recordTypes = obj.getSObjectType().getDescribe().getRecordTypeInfos();
		
		if (recordTypes.size() > 1) { // all objects have default Master type
			System.debug('RecordTypes ' + recordTypes);
			for (Schema.RecordTypeInfo recordType : recordTypes) {
				if (recordType.isAvailable() && recordType.isDefaultRecordTypeMapping()) {
					obj.put('RecordTypeId', recordType.getRecordTypeId());
				}
			}
		}
		
	}
}