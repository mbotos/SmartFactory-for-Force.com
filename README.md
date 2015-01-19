SmartFactory for Force.com
======================================

SmartFactory dynamically creates test data hierarchies with all required fields and relationships pre-populated for Salesforce.com. 

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

[The Evolution of Test Data](http://mavens.force.com/conversation/the-evolution-of-test-data) provides more background on the problem and SmartFactory's solution.

SmartFactory's first version won the [Mavens Consulting](http://mavens.force.com/) 2011 Hackathon in less than a single day of coding. 

Installation
------------

For easy, 1-click installation: [SmartFactory Unmanaged Package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000LGLn)  ([sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000LGLn))

To use the source code with a Salesforce org: [GitHub Salesforce Deploy Tool](https://githubsfdeploy.herokuapp.com/?owner=mbotos&repo=SmartFactory-Testing-for-Force.com)

To prevent the large number of system calls from filling your debug log, you can set logging filter overrides for the SmartFactory class: Setup - Develop - Apex Classes - SmartFactory - Log Filters - System = NONE.

Usage
-----  

Just use SmartFactory in your tests to create objects:

`Account account = (Account)SmartFactory.createSObject('Account');` 

To cascade and create objects for lookup and master-detail relationships:

`Contact contact = (Contact)SmartFactory.createSObject('Contact', true);`

The same syntax is used for custom objects:

`Custom_Object__c customObject = (Custom_Object__c)SmartFactory.createSObject('Custom_Object__c');`   

See SmartFactory_Test for additional examples.

Future Work
----------- 

TODO comments note areas for additional development. Key areas include:

1. Provide an field override map that allows callers to specify default values for specific objects and fields    
2. Provide a recursion limit for lookups to the same object type   

Help and Discussion
-------------------

For help and discussion, please use the project's [Google Group](http://groups.google.com/group/smartfactory-for-forcecom).         

