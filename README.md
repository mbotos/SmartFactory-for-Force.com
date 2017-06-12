Salesforce Test Data Generator
==============================

Salesforce test data generator fills lookups, master-detail relationships, and required fields. 

Native Force.com Apex code using dynamic metadata.

Quickly Generate Lookups, Master-Detail Relationships, and Required Fields
--------------------------------------------------------------------------

How often have you wasted hours reverse-engineering a new schema just to create data for a unit test?

    Task__c testTask = new Task__c();
    ERROR: Field Desciption__c required on Task__c

    Task__c testTask = new Task__c(Description__c = 'Create unit test data');`
    ERROR: Lookup relationship Project__c required on Task__c`

    Project__c testProject = new Project__c();
    Task__c testTask = new Task__c(Project__c = testProject, Description__c = 'Create unit test data');
    ERROR: Field Status__c required on Project__c
    ...

Watch SmartFactory dynamically use the Describe metadata to populate all required fields with valid data and create any related objects: 

    Task__c testTask = (Task__c)SmartFactory.createSObject('Task__c');

Learn Salesforce Testing Best Practices
---------------------------------------

[3 Principles of Salesforce Testing](http://alvorden.com/salesforce-testing-best-practices?utm_source=github&utm_medium=social&utm_term=&utm_content=salesforce-testing-best-practices&utm_campaign=smartfactory) includes production code by Salesforce MVP Matthew Botos.

[The Evolution of Test Data](http://mavens.force.com/conversation/the-evolution-of-test-data) provides more background on the problem and SmartFactory's solution.

SmartFactory's first version won the [Mavens Consulting](http://mavens.force.com/) 2011 Hackathon in less than a single day of coding. 

Easy 1-Line Usage
-----  

Just use SmartFactory in your tests to create objects:

`Account account = (Account)SmartFactory.createSObject('Account');` 

To cascade and create objects for lookup and master-detail relationships:

`Contact contact = (Contact)SmartFactory.createSObject('Contact', true);`

The same syntax is used for custom objects:

`Custom_Object__c customObject = (Custom_Object__c)SmartFactory.createSObject('Custom_Object__c');`   

See [SmartFactory_Test](https://github.com/mbotos/SmartFactory-for-Force.com/blob/master/src/classes/SmartFactory_Test.cls) for additional examples.

Powerful Options
----------------

Include or Exclude Fields
-------------------------

To fill only required and included fields:

    SmartFactory.FillAllFields = false;
    SmartFactory.IncludedFields.put('Account', 'AccountNumber');
    
    Account account = (Account)SmartFactory.createSObject('Account');
    
To fill all fields but those excluded:

    SmartFactory.FillAllFields = true;
    SmartFactory.ExcludedFields.put('Account', 'AccountNumber');
    
    Account account = (Account)SmartFactory.createSObject('Account');


Validation Rules
----------------

To set specific values to pass your custom Validation Rules, wrap SmartFactory with your own class like this:
```java
public class TestObjectFactory {
  public static Account createAccount() {
    Account account = (Account)SmartFactory.createSObject('Account');
    account.Customer_Terms__c = 'Net 30';
    return account;
  }
}
```
You can then call that reusable method from your tests. If you have validation rules on Account or Contact, you may also need to modify SmartFactory_Test.

Logging
-------

To prevent the large number of system calls from filling your debug log, you can set logging filter overrides for the SmartFactory class: Setup - Develop - Apex Classes - SmartFactory - Log Filters - System = NONE.

Future Work
----------- 

TODO comments note areas for additional development. Key areas include:

1. Provide an field override map that allows callers to specify default values for specific objects and fields    
2. Provide a recursion limit for lookups to the same object type   

Help and Discussion
-------------------

For help and discussion, please use the project's [Google Group](http://groups.google.com/group/smartfactory-for-forcecom).         

