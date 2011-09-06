SmartFactory for Force.com
======================================

SmartFactory aims to provide test data objects with all required fields and object lookups pre-populated. 

The idea came from writing unit tests for unfamiliar orgs, where setting up test data might mean digging through a large hierarchy of lookup relationships and
required fields. Instead, SmartFactory uses the Describe metadata to populate all fields with data of the right type. For lookup fields, it creates an appropriate object and then uses that object's id.

The initial version won the [Mavens Consulting](http://mavens.force.com/) 2011 hackathon. As a 1-day project, the current state is more a proof of concept; please
see Future Work if you'd like to contribute to developing into a fully functional solution.

Installation
------------

For an easy, 1-click installation: [SmartFactory for Force.com on Code Share](http://developer.force.com/codeshare/ProjectPage?id=a063000000Db0CSAAZ) 

To use the source code with a Salesforce org: [How To Use Github and the Force.com IDE](http://blog.sforce.com/sforce/2011/04/how-to-use-git-github-force-com-ide-open-source-labs-apps.html)

Usage
-----  

Just use SmartFactory in your tests to create objects:

`Account account = (Account)SmartFactory.createSObject('Account');` 

To cascade and create lookup objects:

`Contact contact = (Contact)SmartFactory.createSObject('Contact', true);`

The same syntax is used for custom objects:

`Custom_Object__c customObject = (Custom_Object__c)SmartFactory.createSObject('Custom_Object__c');`   

To create Sobject with your preferred values for specific fields, prepare a Map with following structure :

 * Key : Field API Name 
 * Value : Required Field Value
 
`Map<String, Object> accValues = new Map<String, Object> {'AnnualRevenue' => 20000.00, 'Description' => 'My Account Description', 'Phone' => '123-234-2233'};`

Once this is done, create sobject using SmartFactory as before, just pass this newly created map as second argument. Same is shown below :

`Account acc = (Account)SmartFactory.createSObject('Account', accValues);`


See SmartFactory_Test for additional examples.

Future Work
----------- 

TODO comments note areas for additional development. Key areas include:

1. Provide a recursion limit for lookups to the same object type   

Performance Tip
----------------
SmartFactory, transparently caches simple sobjects (without references) created from it. So if 500+ script lines are consumed in creating first instance of a SobjectType, second instance might take 15+ lines only.

Please note, if you are create Sobject using SmartFactory with "cascade" option true, as shown below. Then please make sure you 
are taking care of caching the created sobject if required. This caching is typically not required in your Apex Test case, unless you are creating many instances of a single sobjectype in the same test method. Creating many instances might put you in risk of running out 200,000 script lines governor limit. 

`Custom_Object__c customObject = (Custom_Object__c)SmartFactory.createSObject('Custom_Object__c', true);`

Help and Discussion
-------------------

For help and discussion, please use the project's [Google Group](http://groups.google.com/group/smartfactory-for-forcecom).         

