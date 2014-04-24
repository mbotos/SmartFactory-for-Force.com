SmartFactory for Force.com
======================================

SmartFactory aims to provide test data objects with all required fields and object lookups pre-populated. 

The idea came from writing unit tests for unfamiliar orgs, where setting up test data might mean digging through a large hierarchy of lookup relationships and
required fields. Instead, SmartFactory uses the Describe metadata to populate all fields with data of the right type. For lookup fields, it creates an appropriate object and then uses that object's id.

[The Evolution of Test Data](http://mavens.force.com/conversation/the-evolution-of-test-data) provides an introduction to the problem and SmartFactory's solution.

The initial version won the [Mavens Consulting](http://mavens.force.com/) 2011 hackathon. 

Installation
------------

For an easy, 1-click installation: [SmartFactory Unmanaged Package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000LGLn) ([sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000LGLn))

To use the source code with a Salesforce org: [GitHub Salesforce Deploy Tool](https://githubsfdeploy.herokuapp.com/?owner=mbotos&repo=SmartFactory-Testing-for-Force.com)

To prevent the large number of system calls from filling the debug log, you may also want to set logging filter overrides for the SmartFactory class. (Setup - Develop - Apex Classes - SmartFactory - Log Filters - System = NONE)

Usage
-----  

Just use SmartFactory in your tests to create objects:

`Account account = (Account)SmartFactory.createSObject('Account');` 

To cascade and create lookup objects:

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

