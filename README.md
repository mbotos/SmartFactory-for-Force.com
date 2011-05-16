SmartFactory for Force.com
======================================

SmartFactory aims to provide test data objects with all required fields and object lookups pre-populated.

The initial version won the [Mavens Consulting](http://mavens.force.com/) 2011 hackathon. As a 1-day project, the current state is more a proof of concept; please see Future Work if you'd like to contribute to developing into a fully functional solution.

Installation
------------

For an easy, 1-click installation: [SmartFactory for Force.com on Code Share](http://developer.force.com/codeshare/project/smartfactory-for-forcecom).

To use the source code with a Salesforce org: [How To Use Github and the Force.com IDE](http://blog.sforce.com/sforce/2011/04/how-to-use-git-github-force-com-ide-open-source-labs-apps.html)

Usage
-----  

To use with standard objects, no setup is required. Just use SmartFactory in your tests to create objects:

`Account account = (Account)SmartFactory.createSObject('Account');` 

To cascade and create lookup objects:

`Contact contact = (Contact)SmartFactory.createSObject('Contact', true);`

To use with custom objects, you'll need to regenerate the SmartFactoryHelper class:

1. In System Log, run "SmartFactory.generateHelperClass();"
2. From the debug output, copy from "public with sharing class SmartFactoryHelper {" to "} // SmartFactoryHelper"   
3. Paste into the class SmartFactoryHelper in the Eclipse Force.com IDE or Setup > Develop > Apex Classes

SmartFactoryHelper now includes your custom objects, which can be used as follows:

`Custom_Object__c customObject = (Custom_Object__c)SmartFactory.createSObject('Custom_Object__c');`   

See SmartFactory_Test for additional examples.

Future Work
----------- 

TODO comments note areas for additional development. Key areas include:

1. Default field values for other Schema.DisplayTypes    
2. Create external service to dynamically generate SmartFactoryHelper class using Force.com Metadata API   
3. Create an app and setup tab to call the external service
4. Provide an field override map that allows callers to specify default values for specific objects and fields    
5. Provide a recursion limit for lookups to the same object type   

Also, please vote for [Dynamic Class Instantiation and Casting on Ideaexchange](https://sites.secure.force.com/success/ideaView?id=08730000000BpwmAAC), which would eliminate the need for a generated helper class.

Help and Discussion
-------------------

For help and discussion, please use the project's [Google Group](http://groups.google.com/group/smartfactory-for-forcecom).         

