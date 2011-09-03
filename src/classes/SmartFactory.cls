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
	public static boolean FillAllFields = false;
	
	// Key : SobjectAPIName  For ex. Account 
	// Value : Map<String, Schema.SObjectField>, field map (k:fieldname, v:Schema.Sobjectfield)
	public static final Map<String, Map<String, Schema.SObjectField>> FieldMapCache = new Map<String, Map<String, Schema.SObjectField>>();

	private static final Map<String, Schema.SObjectType> GlobalDescribe = Schema.getGlobalDescribe();
	
	// Key: sobject.field
	// Value: first picklist value
	private static final Map<String, String> DefaultPicklistValue = new Map<String, String>();
	
	// can't map by Schema.sObjectType, use object name string instead
	static map<string, set<string>> excludedFields = new map<string, set<string>>{
		'All' => new set<string>{'OwnerId', 'LastModifiedById'},
		'Account' => new set<string>{'FirstName', 'LastName'}
	};
	
	// kept public so that test cases can change this if required
	// Key : DisplayType name
	// Value : Object value for the field
	public static final Map<String, Object> FieldTypeValueMapping = 
										new Map<String, Object> {
												Schema.DisplayType.base64.name() => blob.valueOf('a'),
												Schema.DisplayType.Boolean.name() => false,
												Schema.DisplayType.Combobox.name() => 'a',
												Schema.DisplayType.Currency.name() => 0,
												Schema.DisplayType.Date.name() => System.today(),
												Schema.DisplayType.Datetime.name() => System.now(),
												Schema.DisplayType.Double.name() => 0.0,
												Schema.DisplayType.Email.name() => 'test@test.com',
												Schema.DisplayType.EncryptedString.name() => 's',
												Schema.DisplayType.Integer.name() => 0,
												Schema.DisplayType.Percent.name() => 0,
												Schema.DisplayType.Phone.name() => '123-456-7890',
												Schema.DisplayType.String.name() => 's',
												Schema.DisplayType.TextArea.name() => 's',
												Schema.DisplayType.Time.name() => Time.newInstance(0, 0, 0, 0),
												Schema.DisplayType.URL.name() => 'http:www.force.com'
											}; 	
	
	// Cache for Sobject Templates prepopulated with default values
	// This cache will be applicable for objects created with cascade option as false
	// Key : ObjectType Name
	// Value : The SObject instance										
	static final Map<String, Sobject> TemplateSobjectCache = new Map<String, Sobject>();
	
	public static SObject createSObject(string objectType) {
		// initialize with empty mapping
		return createSObject(objectType, new Map<String,Object>());
	}
	
	public static SObject createSObject(string objectType, Map<String, Object> fieldNameValueMapping) {
		return createSObject(objectType, false, fieldNameValueMapping);
	}	
	
	public static SObject createSObject(string objectType, boolean cascade) {
		// initialize with empty mapping
		return createSObject(objectType, cascade, new Map<String,Object>());
	}
	
	public static SObject createSObject(string objectType, boolean cascade, Map<String, Object> fieldNameValueMapping) {
		SObject obj = null;
		if (!cascade && TemplateSobjectCache.containsKey(objectType.toLowerCase())) {
			// if no cascading is there, we can easily cache the template object and override it as required.
			// no caching done for objects with references.
			obj = ((SObject)TemplateSobjectCache.get(objectType.toLowerCase())).clone();
		} else {
			Schema.sObjectType token = GlobalDescribe.get(objectType);
			if (token == null) {
				throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + objectType);
			}
					
			obj = token.newSObject();		
			
			for (Schema.SObjectField field : fieldMapFor(objectType).values()) {
				setFieldValue(obj, field, cascade);
			}			
			
			if (!cascade) {
				// If not cascading the references cache it.
				// Cache the cloned object, as later on user applied override 
				// might change it
				TemplateSobjectCache.put(objectType.toLowerCase(), obj.clone());
			}
		}
		
		for (String key : fieldNameValueMapping.keyset()) {
			obj.put(key, fieldNameValueMapping.get(key));
		}
		
		return obj;
	}
	
	/**
		Returns a field map for a given sobject. 
		
		Note : this method is kept public for Test cases to share the same field map info, without requiring a field desribe.
		
		@param objectType sobject api name for ex. Account
		@returns FieldMap [Key:FieldName,Value:Schema.SObjectField]
	*/
	public static Map<String, Schema.SObjectField> fieldMapFor(String objectType) {
		Map<String, Schema.SObjectField> fieldMap = null;
		String normalizedObjectType = objectType.toLowerCase();
		
		if (FieldMapCache.containsKey(normalizedObjectType)) {
			fieldMap = FieldMapCache.get(normalizedObjectType);
		} else {
			fieldMap = GlobalDescribe.get(objectType).getDescribe().fields.getMap();
			// cache it for next use
			FieldMapCache.put(normalizedObjectType, fieldMap);
		}
		
		return fieldMap;
	}	
	
	/**
		Sept 3, 2011 : Fixed the bug to fetch the associated default value, instead of value at index zero
	*/
	public static string getDefaultPicklistValue(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		string key = obj.getSObjectType() + '.' + fieldDescribe.getName();
		
		if (!DefaultPicklistValue.containsKey(key)) {
			List<Schema.PicklistEntry> entries = fieldDescribe.getPicklistValues();
			string value = null;
			for (Schema.Picklistentry entry : entries) {
				// TODO check for entry.isActive() here
				if (entry.isDefaultValue()) {
					value = entry.getValue();
					break;
				}
			}
			// if somehow no default value is there
			if (value == null)
				value = entries.size() > 0 ? entries[0].getValue() : null;
			
			DefaultPicklistValue.put(key, value);
		}
		
		return DefaultPicklistValue.get(key);
	}		
	
	static boolean isExcludedField(Schema.DescribeFieldResult fieldDescribe) {
		return excludedFields.get('All').contains(fieldDescribe.getName());
	}
	
	static boolean isExcludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		set<string> fields = excludedFields.get(obj.getSObjectType().getDescribe().getName());
		return fields == null ? false : fields.contains(fieldDescribe.getName());
	}
	
	static boolean isPersonAccountField(Schema.DescribeFieldResult fieldDescribe) {
        Boolean CustomPerson = fieldDescribe.isCustom() && fieldDescribe.getName().endsWith('pc');
        Boolean StandardPerson = !fieldDescribe.isCustom() && fieldDescribe.getName().startsWith('Person');
		return (CustomPerson || StandardPerson);
	} 
	
	static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade) {
		Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
		
		if (fieldDescribe.isCreateable() && 
			((!fieldDescribe.isNillable() || FillAllFields) || 
				(fieldDescribe.getType() == Schema.DisplayType.Reference && cascade)) && // always fill references with cascade
			!isExcludedField(fieldDescribe) &&
			!isExcludedField(obj, fieldDescribe) &&
			!isPersonAccountField(fieldDescribe)) {
			
			if (FieldTypeValueMapping.containsKey(fieldDescribe.getType().name())) {
				obj.put(field, FieldTypeValueMapping.get(fieldDescribe.getType().name()));
			} else if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
				obj.put(field, getDefaultPicklistValue(obj, fieldDescribe));
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
			}
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