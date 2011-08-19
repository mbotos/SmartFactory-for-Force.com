/*
   Copyright 2011 Mavens Consulting, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/   

public with sharing class SmartFactory {
	// Key : SobjectAPIName  For ex. Account 
	// Value : Map<String, Schema.SObjectField>, field map (k:fieldname, v:Schema.Sobjectfield)
	private static final Map<String, Map<String, Schema.SObjectField>> FIELDMAP_CACHE = new Map<String, Map<String, Schema.SObjectField>>();
	
	private static final Map<String, Schema.SObjectType> GlobalDescribe = Schema.getGlobalDescribe();
	
	// can't map by Schema.sObjectType, use object name string instead
	static map<string, set<string>> excludedFields = new map<string, set<string>>{
		'All' => new set<string>{'OwnerId', 'LastModifiedById'},
		'Account' => new set<string>{'FirstName', 'LastName'}
	};
	
	public static SObject createSObject(string objectType) {
		return createSObject(objectType, false);
	}
	
	public static SObject createSObject(string objectType, boolean cascade) {
		Schema.sObjectType token = GlobalDescribe.get(objectType);
		if (token == null) {
			throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + objectType);
		}
		
		SObject obj = token.newSObject();		
		Map<String, Schema.SObjectField> fieldMap = fieldMapFor(objectType);
		
		for (Schema.SObjectField field : fieldMap.values()) {
			setFieldValue(obj, field, cascade);
		}
		
		return obj;
	}
	
	/**
		Returns a field map for a given sobject. 
		
		Note : this method is kept public for Test cases to share the same field map info, without requiring a field desribe.
		
		@param objectType sobject api name for ex. Account
		@returns FieldMap [Key:FieldName,Value:Schema.SObjectField]
	*/
	public static  Map<String, Schema.SObjectField> fieldMapFor(String objectType) {
		Map<String, Schema.SObjectField> fieldMap = null;
		String normalizedObjectType = objectType.toLowerCase();
		if (FIELDMAP_CACHE.containsKey(normalizedObjectType)) {
			fieldMap = FIELDMAP_CACHE.get(normalizedObjectType);
		} else {
			fieldMap = Schema.getGlobalDescribe().get(objectType).getDescribe().fields.getMap();
			// cache it for next use
			FIELDMAP_CACHE.put(normalizedObjectType, fieldMap);
		}
		return fieldMap;
	}
	
	static boolean isExcludedField(Schema.DescribeFieldResult fieldDescribe) {
		return excludedFields.get('All').contains(fieldDescribe.getName());
	}
	
	static boolean isExcludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		set<string> fields = excludedFields.get(obj.getSObjectType().getDescribe().getName());
		return fields == null ? false : fields.contains(fieldDescribe.getName());
	}
	
	static boolean isPersonAccountField(Schema.DescribeFieldResult fieldDescribe) {
                Boolean CustomPerson = fieldDescribe.getName().substring(fieldDescribe.getName().length()-2,fieldDescribe.getName().length()) == 'pc' && fieldDescribe.isCustom();
                Boolean StandardPerson = fieldDescribe.getName().startsWith('Person') && !fieldDescribe.isCustom();
		return (CustomPerson || StandardPerson);
	}
	
	static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade) {
		Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
		
		if (fieldDescribe.isCreateable() && 
			!fieldDescribe.getName().endsWith('pc') && // lookup fields
			!isExcludedField(fieldDescribe) &&
			!isExcludedField(obj, fieldDescribe) &&
			!isPersonAccountField(fieldDescribe)) {
				
			if (fieldDescribe.getType() == Schema.DisplayType.String) {
				//System.debug('Setting field ' + fieldDescribe.getName());
				obj.put(field, 'a'); 
			} else if (fieldDescribe.getType() == Schema.DisplayType.Reference) {
				string referenceObjectType = fieldDescribe.getReferenceTo()[0].getDescribe().getName();
				
				if (referenceObjectType == 'RecordType') {
					setRecordType(obj);
				} else if (cascade && referenceObjectType != obj.getSObjectType().getDescribe().getName()) {
					// TODO avoid infinite loop for same-type references
					//System.debug('Creating reference to ' + referenceObjectType);
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
			//System.debug('RecordTypes ' + recordTypes);
			for (Schema.RecordTypeInfo recordType : recordTypes) {
				if (recordType.isAvailable() && recordType.isDefaultRecordTypeMapping()) {
					obj.put('RecordTypeId', recordType.getRecordTypeId());
				}
			}
		}
		
	}
}