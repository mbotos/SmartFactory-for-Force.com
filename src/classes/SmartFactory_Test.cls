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

@isTest
private class SmartFactory_Test {
	static {
		SmartFactory.FillAllFields = true; // increase test coverage without creating custom objects
	}
	
	static testMethod void createsSingleObjectWithSingleRequiredStringField() {
		Account account = (Account)SmartFactory.createSObject('Account');
		insert account;
		System.assert(account.Id != null);
		System.assert(account.Name != null);
	}
	
	static testMethod void createsObjectWithCascadeSetsLookupField() {
		Contact contact = (Contact)SmartFactory.createSObject('Contact', true);
		insert contact;
		System.assert(contact.Id != null);
		System.assert(contact.AccountId != null);
	}
	
	static testMethod void createsObjectWithoutCascadeDoesNotSetLookupField() {
		Contact contact = (Contact)SmartFactory.createSObject('Contact', false);
		insert contact;
		System.assert(contact.AccountId == null);
	}
	
	static testMethod void createObjectWithUnsupportedTypeThrowsException() {
		try {
			SmartFactory.createSObject('Unsupported');
			System.assert(false);
		} catch (UnsupportedObjectTypeException ex) {
			System.assert(true);
		}
	}
	
	/**
		Reproduces this issue
		https://github.com/mbotos/SmartFactory-for-Force.com/issues/3
	*/
    static testMethod void loadTestWith100PlusAccountNContacts() {
    	for (Integer idx = 0; idx <= 101; idx++)
    		Account account = (Account)SmartFactory.createSObject('Account');
		for (Integer idx = 0; idx <= 101; idx++)
    		Contact cont = (Contact)SmartFactory.createSObject('Contact');    		
    }
    
    /**
    */
    static testMethod void testFieldValueOverride() {
    	Map<String, Object> accValues = new Map<String, Object> {
												'AnnualRevenue' => 20000.00,
												'Description' => 'My Account Description',
												 'Phone' => '123-234-2233'
											};
    	Account acc = (Account)SmartFactory.createSObject('Account', accValues);
		for (String fld: accValues.keySet()) {
			System.assertEquals(accValues.get(fld), acc.get(fld));
		}
		
		// it comes 454 here
		System.debug('Scripts Consumed:' + Limits.getScriptStatements());
				
		accValues = new Map<String, Object> {
												'NumberOfEmployees' => 2000,
												'Site' => 'www.tgerm.com',
												 'Fax' => '123-234-2233'
											};
		acc = (Account)SmartFactory.createSObject('Account', accValues);
		for (String fld: accValues.keySet()) {
			System.assertEquals(accValues.get(fld), acc.get(fld));
		}
		// Phone should be using the default value, instead of the one created previously
		// this will make sure fresh object from template is used.
		System.assertEquals(SmartFactory.FieldTypeValueMapping.get(Schema.DisplayType.Phone.name()), acc.Phone);
		
		// it comes 467, so we improved a lot with caching for the same operation
		System.debug('Scripts Consumed II:' + Limits.getScriptStatements());
    }
    
    /**
    	Changed the default picklist value to "Education" for Account>Industury.
    	Code before was picking up the wrong first value i.e. Agriculture
    	Note: commenting out this test case, as all SFDC orgs will not have the 
    	same default value
    static testMethod void testAccountPicklistDefaultValue() {
    	Account acc = (Account)SmartFactory.createSObject('Account');
    	System.assertEquals('Education',  acc.Industry);
    }
    */
    
}