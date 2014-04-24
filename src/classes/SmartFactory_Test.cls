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
}