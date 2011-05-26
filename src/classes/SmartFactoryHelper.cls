public with sharing class SmartFactoryHelper {
public static SObject newSObject(Schema.sObjectType token) {
if (token.getDescribe().getName() == 'account') { return (account)token.newSObject(); }
if (token.getDescribe().getName() == 'contact') { return (contact)token.newSObject(); }
throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + token);
} // newSObject

public static Map<String, Schema.SObjectField> getFieldMap(Schema.sObjectType token) {
if (token.getDescribe().getName() == 'account') { return Schema.sObjectType.account.fields.getMap(); }
if (token.getDescribe().getName() == 'contact') { return Schema.sObjectType.contact.fields.getMap(); }
throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + token);
} // getFieldMap

} // SmartFactoryHelper