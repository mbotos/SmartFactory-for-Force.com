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
	public static Profile userProfile = [Select Id from Profile where Name = 'System Administrator'];

	private static final Map<String, Map<String, Schema.SObjectField>> FieldMapCache = new Map<String, Map<String, Schema.SObjectField>>();

	private static final Map<String, Schema.SObjectType> GlobalDescribe = Schema.getGlobalDescribe();

	// Default Country and State
	// When Country and State Picklists are enabled, cannot dynamically resolve which States are within a Country
	public static string DefaultCountry = 'United States';
	public static string DefaultCountryCode = 'US';
	public static string DefaultState = 'Pennsylvania';
	public static string DefaultStateCode = 'PA';

	// Key: sobject.field
	// Value: first picklist value
	private static final Map<String, String> DefaultPicklistValue = new Map<String, String>();

	// can't map by Schema.sObjectType, use object name String instead
	public static map<String, set<String>> ExcludedFields = new map<String, set<String>>{
		'All' => new set<String>{'OwnerId', 'LastModifiedById', 'CreatedById', 'LastModifiedDate', 'CreatedDate'},
		'Account' => new set<String>{'FirstName', 'LastName'},
		'User' => new set<String>{'IsActive','DelegatedApproverId','CallCenterId','ContactId','DelegatedApproverId','ManagerId','UserRoleId','FederationIdentifier'}
	};

	// include nillable fields
	public static map<String, set<String>> IncludedFields = new map<String, set<String>>();

	public static SObject createSObject(String objectType) {
		return createSObject(objectType, false);
	}

	public static List<SObject> createSObjectList(String objectType, boolean cascade, Integer numberOfObjects) {

		List<SObject> sos = new List<SObject>();
		for( Integer i=0; i<numberOfObjects; i++ )
			sos.add(createSObject(objectType, cascade, i));
		return sos;  
	}

	public static SObject createSObject(String objectType, boolean cascade, Integer counter) {
		System.debug('Creating ' + objectType);
		Schema.sObjectType token = GlobalDescribe.get(objectType);
		if (token == null) {
			throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + objectType);
		}

		SObject obj = token.newSObject();		

		for (Schema.SObjectField field : fieldMapFor(objectType).values()) {
			setFieldValue(obj, field, cascade, counter);
		}

		return obj;
	}

	public static SObject createSObject(String objectType, boolean cascade) {
		return createSObject(objectType, cascade, 1);
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

		if (FieldMapCache.containsKey(normalizedObjectType)) {
			fieldMap = FieldMapCache.get(normalizedObjectType);
		} else {
			fieldMap = GlobalDescribe.get(objectType).getDescribe().fields.getMap();
			// cache it for next use
			FieldMapCache.put(normalizedObjectType, fieldMap);
		}

		return fieldMap;
	}

	static String getDefaultPicklistValue(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		String key = obj.getSObjectType() + '.' + fieldDescribe.getName();

		if (!DefaultPicklistValue.containsKey(key)) {
			List<Schema.PicklistEntry> entries = fieldDescribe.getPicklistValues();
			String value = entries.size() > 0 ? entries[0].getValue() : null;
			DefaultPicklistValue.put(key, value);
		}

		return DefaultPicklistValue.get(key);
	}

	static boolean isExcludedField(Schema.DescribeFieldResult fieldDescribe) {
		return ExcludedFields.get('All').contains(fieldDescribe.getName());
	}

	static boolean isExcludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		set<String> fields = ExcludedFields.get(obj.getSObjectType().getDescribe().getName());
		return fields == null ? false : fields.contains(fieldDescribe.getName());
	}

	static boolean isIncludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
		set<String> fields = includedFields.get(obj.getSObjectType().getDescribe().getName());
		return fields == null ? false : fields.contains(fieldDescribe.getName());
	}

	static boolean isPersonAccountField(Schema.DescribeFieldResult fieldDescribe) {
                Boolean isPersonAccountEnabled = fieldMapFor('Account').get('IsPersonAccount') != null;
                set<string> skipPersonAccountFields = new set<string>{ 'Salutation' };
            
                Boolean CustomPerson = fieldDescribe.isCustom() && fieldDescribe.getName().endsWith('pc');
                Boolean StandardPerson = !fieldDescribe.isCustom() && fieldDescribe.getName().startsWith('Person');

                return CustomPerson || StandardPerson || 
                    (isPersonAccountEnabled && skipPersonAccountFields.contains(fieldDescribe.getName()));
	}

	static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade) {
		setFieldValue(obj, field, cascade, 0);
	}

	static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade, Integer counter) {
		Schema.DescribeFieldResult fieldDescribe = field.getDescribe();

		if (fieldDescribe.isCreateable() && 
			(
				isIncludedField(obj, fieldDescribe) || 
				(
					(
						(!fieldDescribe.isNillable() || 
						FillAllFields) || 
						(fieldDescribe.getType() == Schema.DisplayType.Reference && cascade) // always fill references with cascade
					) && 
					!isExcludedField(fieldDescribe) &&
					!isExcludedField(obj, fieldDescribe) &&
					!isPersonAccountField(fieldDescribe)
				)
			 )
			) {

			if (fieldDescribe.getName().endsWith('Country')) {
				obj.put(field, DefaultCountry);
			} else if (fieldDescribe.getName().endsWith('State')) {
				obj.put(field, DefaultState);
			} else if (fieldDescribe.getName().endsWith('CountryCode')) {
				obj.put(field, DefaultCountryCode);
			} else if (fieldDescribe.getName().endsWith('StateCode')) {
				obj.put(field, DefaultStateCode);
			} else if (fieldDescribe.getType() == Schema.DisplayType.base64) {
				obj.put(field, blob.valueOf(counter.format()));
			} else if (fieldDescribe.getType() == Schema.DisplayType.Boolean) {
				obj.put(field, false);
			} else if (fieldDescribe.getType() == Schema.DisplayType.Combobox) {
				obj.put(field, counter.format());
			} else if (fieldDescribe.getType() == Schema.DisplayType.Currency) {
				obj.put(field, counter);
			} else if (fieldDescribe.getType() == Schema.DisplayType.Date) {
				obj.put(field, Date.today());
			} else if (fieldDescribe.getType() == Schema.DisplayType.DateTime) {
				obj.put(field, DateTime.now());
			} else if (fieldDescribe.getType() == Schema.DisplayType.Double) {
				obj.put(field, counter);
			} else if (fieldDescribe.getType() == Schema.DisplayType.Email) {
				obj.put(field, 'test' + counter.format() + '@test.com');
			} else if (fieldDescribe.getType() == Schema.DisplayType.EncryptedString) {
				obj.put(field, 's');
			} else if (fieldDescribe.getType() == Schema.DisplayType.Id) {
				//System.debug('Id field ' + fieldDescribe.getName());
			} else if (fieldDescribe.getType() == Schema.DisplayType.Integer) {
				obj.put(field, counter);
			} else if (fieldDescribe.getType() == Schema.DisplayType.MultiPicklist) {
				obj.put(field, getDefaultPicklistValue(obj, fieldDescribe));
			} else if (fieldDescribe.getType() == Schema.DisplayType.Percent) {
				obj.put(field, counter);
			} else if (fieldDescribe.getType() == Schema.DisplayType.Phone) {
				obj.put(field, '123-456-7890');
			} else if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
				obj.put(field, getDefaultPicklistValue(obj, fieldDescribe));
			} else if (fieldDescribe.getName() == 'CommunityNickname' && fieldDescribe.getType() == Schema.DisplayType.String) { 
				obj.put(field, 'test'+ string.valueof(math.roundtolong(math.random()*1000000)) ); 
			} else if (fieldDescribe.getName() == 'UserName' && fieldDescribe.getType() == Schema.DisplayType.String) { 
				obj.put(field, 'test'+ string.valueof(Userinfo.getOrganizationId())+ string.valueof(math.roundtolong(math.random()*1000000))+ string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','')+'@test.com'); // was a@a.com
			} else if (fieldDescribe.getType() == Schema.DisplayType.String) {
				obj.put(field, counter.format()); 
			} else if (fieldDescribe.getType() == Schema.DisplayType.Reference) {
				String referenceObjectType = fieldDescribe.getReferenceTo()[0].getDescribe().getName();

				if (referenceObjectType == 'RecordType') {
					setRecordType(obj);
                }else if (referenceObjectType == 'Profile') { 
					obj.put(field,userProfile.Id);
				} else if (cascade && referenceObjectType != obj.getSObjectType().getDescribe().getName() &&
                            referenceObjectType !='BusinessHours') {
                    // TODO avoid infinite loop for same-type references
					System.debug('Creating reference to ' + referenceObjectType + ' for field ' + obj.getSObjectType().getDescribe().getName() + '.' + fieldDescribe.getName());
					SObject reference = createSObject(referenceObjectType);
					System.debug('Inserting ' + reference);
					insert reference;
					obj.put(field, reference.Id);
				}
			} else if (fieldDescribe.getType() == Schema.DisplayType.TextArea) {
				obj.put(field, counter.format()); 
			} else if (fieldDescribe.getType() == Schema.DisplayType.Time) {
				obj.put(field, Time.newInstance(0, 0, 0, 0)); 
			} else if (fieldDescribe.getType() == Schema.DisplayType.URL) {
				obj.put(field, 'http://test' + counter + '.com'); 
			} else {
				System.debug('Unhandled field type ' + fieldDescribe.getType());
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