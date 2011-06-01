/* 
 * June 1, 2011 - SHH - Commented out objects related to Chatter (for non-Chatter-enabled orgs)
 * June 1, 2011 - SHH - sorted lines by alpha
 */
public with sharing class SmartFactoryHelper {
public static SObject newSObject(Schema.sObjectType token) {
// if (token.getDescribe().getName() == 'accountfeed') { return (accountfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'assetfeed') { return (assetfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'campaignfeed') { return (campaignfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'casefeed') { return (casefeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'collaborationgroup') { return (collaborationgroup)token.newSObject(); }
// if (token.getDescribe().getName() == 'collaborationgroupfeed') { return (collaborationgroupfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'collaborationgroupmember') { return (collaborationgroupmember)token.newSObject(); }
// if (token.getDescribe().getName() == 'collaborationinvitation') { return (collaborationinvitation)token.newSObject(); }
// if (token.getDescribe().getName() == 'contactfeed') { return (contactfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'contentdocumentfeed') { return (contentdocumentfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'contractfeed') { return (contractfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'dashboardfeed') { return (dashboardfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'entitysubscription') { return (entitysubscription)token.newSObject(); }
// if (token.getDescribe().getName() == 'eventfeed') { return (eventfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'feedcomment') { return (feedcomment)token.newSObject(); }
// if (token.getDescribe().getName() == 'feedpost') { return (feedpost)token.newSObject(); }
// if (token.getDescribe().getName() == 'feedtrackedchange') { return (feedtrackedchange)token.newSObject(); }
// if (token.getDescribe().getName() == 'leadfeed') { return (leadfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'newsfeed') { return (newsfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'opportunityfeed') { return (opportunityfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'product2feed') { return (product2feed)token.newSObject(); }
// if (token.getDescribe().getName() == 'reportfeed') { return (reportfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'sitefeed') { return (sitefeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'solutionfeed') { return (solutionfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'taskfeed') { return (taskfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'userfeed') { return (userfeed)token.newSObject(); }
// if (token.getDescribe().getName() == 'userprofilefeed') { return (userprofilefeed)token.newSObject(); }
if (token.getDescribe().getName() == 'account') { return (account)token.newSObject(); }
if (token.getDescribe().getName() == 'accountcontactrole') { return (accountcontactrole)token.newSObject(); }
if (token.getDescribe().getName() == 'accounthistory') { return (accounthistory)token.newSObject(); }
if (token.getDescribe().getName() == 'accountpartner') { return (accountpartner)token.newSObject(); }
if (token.getDescribe().getName() == 'accountshare') { return (accountshare)token.newSObject(); }
if (token.getDescribe().getName() == 'activityhistory') { return (activityhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'additionalnumber') { return (additionalnumber)token.newSObject(); }
if (token.getDescribe().getName() == 'aggregateresult') { return (aggregateresult)token.newSObject(); }
if (token.getDescribe().getName() == 'apexclass') { return (apexclass)token.newSObject(); }
if (token.getDescribe().getName() == 'apexcomponent') { return (apexcomponent)token.newSObject(); }
if (token.getDescribe().getName() == 'apexlog') { return (apexlog)token.newSObject(); }
if (token.getDescribe().getName() == 'apexpage') { return (apexpage)token.newSObject(); }
if (token.getDescribe().getName() == 'apextrigger') { return (apextrigger)token.newSObject(); }
if (token.getDescribe().getName() == 'approval') { return (approval)token.newSObject(); }
if (token.getDescribe().getName() == 'asset') { return (asset)token.newSObject(); }
if (token.getDescribe().getName() == 'assignmentrule') { return (assignmentrule)token.newSObject(); }
if (token.getDescribe().getName() == 'asyncapexjob') { return (asyncapexjob)token.newSObject(); }
if (token.getDescribe().getName() == 'attachment') { return (attachment)token.newSObject(); }
if (token.getDescribe().getName() == 'brandtemplate') { return (brandtemplate)token.newSObject(); }
if (token.getDescribe().getName() == 'businesshours') { return (businesshours)token.newSObject(); }
if (token.getDescribe().getName() == 'businessprocess') { return (businessprocess)token.newSObject(); }
if (token.getDescribe().getName() == 'callcenter') { return (callcenter)token.newSObject(); }
if (token.getDescribe().getName() == 'campaign') { return (campaign)token.newSObject(); }
if (token.getDescribe().getName() == 'campaignmember') { return (campaignmember)token.newSObject(); }
if (token.getDescribe().getName() == 'campaignmemberstatus') { return (campaignmemberstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'campaignshare') { return (campaignshare)token.newSObject(); }
if (token.getDescribe().getName() == 'case') { return (case)token.newSObject(); }
if (token.getDescribe().getName() == 'casecomment') { return (casecomment)token.newSObject(); }
if (token.getDescribe().getName() == 'casecontactrole') { return (casecontactrole)token.newSObject(); }
if (token.getDescribe().getName() == 'casehistory') { return (casehistory)token.newSObject(); }
if (token.getDescribe().getName() == 'caseshare') { return (caseshare)token.newSObject(); }
if (token.getDescribe().getName() == 'casesolution') { return (casesolution)token.newSObject(); }
if (token.getDescribe().getName() == 'casestatus') { return (casestatus)token.newSObject(); }
if (token.getDescribe().getName() == 'caseteammember') { return (caseteammember)token.newSObject(); }
if (token.getDescribe().getName() == 'caseteamrole') { return (caseteamrole)token.newSObject(); }
if (token.getDescribe().getName() == 'caseteamtemplate') { return (caseteamtemplate)token.newSObject(); }
if (token.getDescribe().getName() == 'caseteamtemplatemember') { return (caseteamtemplatemember)token.newSObject(); }
if (token.getDescribe().getName() == 'caseteamtemplaterecord') { return (caseteamtemplaterecord)token.newSObject(); }
if (token.getDescribe().getName() == 'categorydata') { return (categorydata)token.newSObject(); }
if (token.getDescribe().getName() == 'categorynode') { return (categorynode)token.newSObject(); }
if (token.getDescribe().getName() == 'community') { return (community)token.newSObject(); }
if (token.getDescribe().getName() == 'contact') { return (contact)token.newSObject(); }
if (token.getDescribe().getName() == 'contacthistory') { return (contacthistory)token.newSObject(); }
if (token.getDescribe().getName() == 'contactshare') { return (contactshare)token.newSObject(); }
if (token.getDescribe().getName() == 'contentdocument') { return (contentdocument)token.newSObject(); }
if (token.getDescribe().getName() == 'contentdocumenthistory') { return (contentdocumenthistory)token.newSObject(); }
if (token.getDescribe().getName() == 'contentversion') { return (contentversion)token.newSObject(); }
if (token.getDescribe().getName() == 'contentversionhistory') { return (contentversionhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'contract') { return (contract)token.newSObject(); }
if (token.getDescribe().getName() == 'contractcontactrole') { return (contractcontactrole)token.newSObject(); }
if (token.getDescribe().getName() == 'contracthistory') { return (contracthistory)token.newSObject(); }
if (token.getDescribe().getName() == 'contractstatus') { return (contractstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'crontrigger') { return (crontrigger)token.newSObject(); }
if (token.getDescribe().getName() == 'dashboard') { return (dashboard)token.newSObject(); }
if (token.getDescribe().getName() == 'document') { return (document)token.newSObject(); }
if (token.getDescribe().getName() == 'documentattachmentmap') { return (documentattachmentmap)token.newSObject(); }
if (token.getDescribe().getName() == 'emailservicesaddress') { return (emailservicesaddress)token.newSObject(); }
if (token.getDescribe().getName() == 'emailservicesfunction') { return (emailservicesfunction)token.newSObject(); }
if (token.getDescribe().getName() == 'emailstatus') { return (emailstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'emailtemplate') { return (emailtemplate)token.newSObject(); }
if (token.getDescribe().getName() == 'event') { return (event)token.newSObject(); }
if (token.getDescribe().getName() == 'eventattendee') { return (eventattendee)token.newSObject(); }
if (token.getDescribe().getName() == 'fiscalyearsettings') { return (fiscalyearsettings)token.newSObject(); }
if (token.getDescribe().getName() == 'folder') { return (folder)token.newSObject(); }
if (token.getDescribe().getName() == 'forecastshare') { return (forecastshare)token.newSObject(); }
if (token.getDescribe().getName() == 'group') { return (group)token.newSObject(); }
if (token.getDescribe().getName() == 'groupmember') { return (groupmember)token.newSObject(); }
if (token.getDescribe().getName() == 'holiday') { return (holiday)token.newSObject(); }
if (token.getDescribe().getName() == 'idea') { return (idea)token.newSObject(); }
if (token.getDescribe().getName() == 'ideacomment') { return (ideacomment)token.newSObject(); }
if (token.getDescribe().getName() == 'lead') { return (lead)token.newSObject(); }
if (token.getDescribe().getName() == 'leadhistory') { return (leadhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'leadshare') { return (leadshare)token.newSObject(); }
if (token.getDescribe().getName() == 'leadstatus') { return (leadstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'mailmergetemplate') { return (mailmergetemplate)token.newSObject(); }
if (token.getDescribe().getName() == 'name') { return (name)token.newSObject(); }
if (token.getDescribe().getName() == 'note') { return (note)token.newSObject(); }
if (token.getDescribe().getName() == 'noteandattachment') { return (noteandattachment)token.newSObject(); }
if (token.getDescribe().getName() == 'openactivity') { return (openactivity)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunity') { return (opportunity)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunitycompetitor') { return (opportunitycompetitor)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunitycontactrole') { return (opportunitycontactrole)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunityfieldhistory') { return (opportunityfieldhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunityhistory') { return (opportunityhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunitylineitem') { return (opportunitylineitem)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunitypartner') { return (opportunitypartner)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunityshare') { return (opportunityshare)token.newSObject(); }
if (token.getDescribe().getName() == 'opportunitystage') { return (opportunitystage)token.newSObject(); }
if (token.getDescribe().getName() == 'organization') { return (organization)token.newSObject(); }
if (token.getDescribe().getName() == 'orgwideemailaddress') { return (orgwideemailaddress)token.newSObject(); }
if (token.getDescribe().getName() == 'partner') { return (partner)token.newSObject(); }
if (token.getDescribe().getName() == 'partnerrole') { return (partnerrole)token.newSObject(); }
if (token.getDescribe().getName() == 'period') { return (period)token.newSObject(); }
if (token.getDescribe().getName() == 'pricebook2') { return (pricebook2)token.newSObject(); }
if (token.getDescribe().getName() == 'pricebookentry') { return (pricebookentry)token.newSObject(); }
if (token.getDescribe().getName() == 'processinstance') { return (processinstance)token.newSObject(); }
if (token.getDescribe().getName() == 'processinstancehistory') { return (processinstancehistory)token.newSObject(); }
if (token.getDescribe().getName() == 'processinstancestep') { return (processinstancestep)token.newSObject(); }
if (token.getDescribe().getName() == 'processinstanceworkitem') { return (processinstanceworkitem)token.newSObject(); }
if (token.getDescribe().getName() == 'product2') { return (product2)token.newSObject(); }
if (token.getDescribe().getName() == 'profile') { return (profile)token.newSObject(); }
if (token.getDescribe().getName() == 'queuesobject') { return (queuesobject)token.newSObject(); }
if (token.getDescribe().getName() == 'recordtype') { return (recordtype)token.newSObject(); }
if (token.getDescribe().getName() == 'report') { return (report)token.newSObject(); }
if (token.getDescribe().getName() == 'scontrol') { return (scontrol)token.newSObject(); }
if (token.getDescribe().getName() == 'selfserviceuser') { return (selfserviceuser)token.newSObject(); }
if (token.getDescribe().getName() == 'site') { return (site)token.newSObject(); }
if (token.getDescribe().getName() == 'sitehistory') { return (sitehistory)token.newSObject(); }
if (token.getDescribe().getName() == 'solution') { return (solution)token.newSObject(); }
if (token.getDescribe().getName() == 'solutionhistory') { return (solutionhistory)token.newSObject(); }
if (token.getDescribe().getName() == 'solutionstatus') { return (solutionstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'staticresource') { return (staticresource)token.newSObject(); }
if (token.getDescribe().getName() == 'task') { return (task)token.newSObject(); }
if (token.getDescribe().getName() == 'taskpriority') { return (taskpriority)token.newSObject(); }
if (token.getDescribe().getName() == 'taskstatus') { return (taskstatus)token.newSObject(); }
if (token.getDescribe().getName() == 'user') { return (user)token.newSObject(); }
if (token.getDescribe().getName() == 'userlicense') { return (userlicense)token.newSObject(); }
if (token.getDescribe().getName() == 'userpreference') { return (userpreference)token.newSObject(); }
if (token.getDescribe().getName() == 'userrole') { return (userrole)token.newSObject(); }
if (token.getDescribe().getName() == 'vote') { return (vote)token.newSObject(); }
if (token.getDescribe().getName() == 'weblink') { return (weblink)token.newSObject(); }
throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + token);
} // newSObject

public static Map<String, Schema.SObjectField> getFieldMap(Schema.sObjectType token) {
// if (token.getDescribe().getName() == 'accountfeed') { return Schema.sObjectType.accountfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'assetfeed') { return Schema.sObjectType.assetfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'campaignfeed') { return Schema.sObjectType.campaignfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'casefeed') { return Schema.sObjectType.casefeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'collaborationgroup') { return Schema.sObjectType.collaborationgroup.fields.getMap(); }
// if (token.getDescribe().getName() == 'collaborationgroupfeed') { return Schema.sObjectType.collaborationgroupfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'collaborationgroupmember') { return Schema.sObjectType.collaborationgroupmember.fields.getMap(); }
// if (token.getDescribe().getName() == 'collaborationinvitation') { return Schema.sObjectType.collaborationinvitation.fields.getMap(); }
// if (token.getDescribe().getName() == 'contactfeed') { return Schema.sObjectType.contactfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'contentdocumentfeed') { return Schema.sObjectType.contentdocumentfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'contractfeed') { return Schema.sObjectType.contractfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'dashboardfeed') { return Schema.sObjectType.dashboardfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'entitysubscription') { return Schema.sObjectType.entitysubscription.fields.getMap(); }
// if (token.getDescribe().getName() == 'eventfeed') { return Schema.sObjectType.eventfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'feedcomment') { return Schema.sObjectType.feedcomment.fields.getMap(); }
// if (token.getDescribe().getName() == 'feedpost') { return Schema.sObjectType.feedpost.fields.getMap(); }
// if (token.getDescribe().getName() == 'feedtrackedchange') { return Schema.sObjectType.feedtrackedchange.fields.getMap(); }
// if (token.getDescribe().getName() == 'leadfeed') { return Schema.sObjectType.leadfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'newsfeed') { return Schema.sObjectType.newsfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'opportunityfeed') { return Schema.sObjectType.opportunityfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'product2feed') { return Schema.sObjectType.product2feed.fields.getMap(); }
// if (token.getDescribe().getName() == 'reportfeed') { return Schema.sObjectType.reportfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'sitefeed') { return Schema.sObjectType.sitefeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'solutionfeed') { return Schema.sObjectType.solutionfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'taskfeed') { return Schema.sObjectType.taskfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'userfeed') { return Schema.sObjectType.userfeed.fields.getMap(); }
// if (token.getDescribe().getName() == 'userprofilefeed') { return Schema.sObjectType.userprofilefeed.fields.getMap(); }
if (token.getDescribe().getName() == 'account') { return Schema.sObjectType.account.fields.getMap(); }
if (token.getDescribe().getName() == 'accountcontactrole') { return Schema.sObjectType.accountcontactrole.fields.getMap(); }
if (token.getDescribe().getName() == 'accounthistory') { return Schema.sObjectType.accounthistory.fields.getMap(); }
if (token.getDescribe().getName() == 'accountpartner') { return Schema.sObjectType.accountpartner.fields.getMap(); }
if (token.getDescribe().getName() == 'accountshare') { return Schema.sObjectType.accountshare.fields.getMap(); }
if (token.getDescribe().getName() == 'activityhistory') { return Schema.sObjectType.activityhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'additionalnumber') { return Schema.sObjectType.additionalnumber.fields.getMap(); }
if (token.getDescribe().getName() == 'aggregateresult') { return Schema.sObjectType.aggregateresult.fields.getMap(); }
if (token.getDescribe().getName() == 'apexclass') { return Schema.sObjectType.apexclass.fields.getMap(); }
if (token.getDescribe().getName() == 'apexcomponent') { return Schema.sObjectType.apexcomponent.fields.getMap(); }
if (token.getDescribe().getName() == 'apexlog') { return Schema.sObjectType.apexlog.fields.getMap(); }
if (token.getDescribe().getName() == 'apexpage') { return Schema.sObjectType.apexpage.fields.getMap(); }
if (token.getDescribe().getName() == 'apextrigger') { return Schema.sObjectType.apextrigger.fields.getMap(); }
if (token.getDescribe().getName() == 'approval') { return Schema.sObjectType.approval.fields.getMap(); }
if (token.getDescribe().getName() == 'asset') { return Schema.sObjectType.asset.fields.getMap(); }
if (token.getDescribe().getName() == 'assignmentrule') { return Schema.sObjectType.assignmentrule.fields.getMap(); }
if (token.getDescribe().getName() == 'asyncapexjob') { return Schema.sObjectType.asyncapexjob.fields.getMap(); }
if (token.getDescribe().getName() == 'attachment') { return Schema.sObjectType.attachment.fields.getMap(); }
if (token.getDescribe().getName() == 'brandtemplate') { return Schema.sObjectType.brandtemplate.fields.getMap(); }
if (token.getDescribe().getName() == 'businesshours') { return Schema.sObjectType.businesshours.fields.getMap(); }
if (token.getDescribe().getName() == 'businessprocess') { return Schema.sObjectType.businessprocess.fields.getMap(); }
if (token.getDescribe().getName() == 'callcenter') { return Schema.sObjectType.callcenter.fields.getMap(); }
if (token.getDescribe().getName() == 'campaign') { return Schema.sObjectType.campaign.fields.getMap(); }
if (token.getDescribe().getName() == 'campaignmember') { return Schema.sObjectType.campaignmember.fields.getMap(); }
if (token.getDescribe().getName() == 'campaignmemberstatus') { return Schema.sObjectType.campaignmemberstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'campaignshare') { return Schema.sObjectType.campaignshare.fields.getMap(); }
if (token.getDescribe().getName() == 'case') { return Schema.sObjectType.case.fields.getMap(); }
if (token.getDescribe().getName() == 'casecomment') { return Schema.sObjectType.casecomment.fields.getMap(); }
if (token.getDescribe().getName() == 'casecontactrole') { return Schema.sObjectType.casecontactrole.fields.getMap(); }
if (token.getDescribe().getName() == 'casehistory') { return Schema.sObjectType.casehistory.fields.getMap(); }
if (token.getDescribe().getName() == 'caseshare') { return Schema.sObjectType.caseshare.fields.getMap(); }
if (token.getDescribe().getName() == 'casesolution') { return Schema.sObjectType.casesolution.fields.getMap(); }
if (token.getDescribe().getName() == 'casestatus') { return Schema.sObjectType.casestatus.fields.getMap(); }
if (token.getDescribe().getName() == 'caseteammember') { return Schema.sObjectType.caseteammember.fields.getMap(); }
if (token.getDescribe().getName() == 'caseteamrole') { return Schema.sObjectType.caseteamrole.fields.getMap(); }
if (token.getDescribe().getName() == 'caseteamtemplate') { return Schema.sObjectType.caseteamtemplate.fields.getMap(); }
if (token.getDescribe().getName() == 'caseteamtemplatemember') { return Schema.sObjectType.caseteamtemplatemember.fields.getMap(); }
if (token.getDescribe().getName() == 'caseteamtemplaterecord') { return Schema.sObjectType.caseteamtemplaterecord.fields.getMap(); }
if (token.getDescribe().getName() == 'categorydata') { return Schema.sObjectType.categorydata.fields.getMap(); }
if (token.getDescribe().getName() == 'categorynode') { return Schema.sObjectType.categorynode.fields.getMap(); }
if (token.getDescribe().getName() == 'community') { return Schema.sObjectType.community.fields.getMap(); }
if (token.getDescribe().getName() == 'contact') { return Schema.sObjectType.contact.fields.getMap(); }
if (token.getDescribe().getName() == 'contacthistory') { return Schema.sObjectType.contacthistory.fields.getMap(); }
if (token.getDescribe().getName() == 'contactshare') { return Schema.sObjectType.contactshare.fields.getMap(); }
if (token.getDescribe().getName() == 'contentdocument') { return Schema.sObjectType.contentdocument.fields.getMap(); }
if (token.getDescribe().getName() == 'contentdocumenthistory') { return Schema.sObjectType.contentdocumenthistory.fields.getMap(); }
if (token.getDescribe().getName() == 'contentversion') { return Schema.sObjectType.contentversion.fields.getMap(); }
if (token.getDescribe().getName() == 'contentversionhistory') { return Schema.sObjectType.contentversionhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'contract') { return Schema.sObjectType.contract.fields.getMap(); }
if (token.getDescribe().getName() == 'contractcontactrole') { return Schema.sObjectType.contractcontactrole.fields.getMap(); }
if (token.getDescribe().getName() == 'contracthistory') { return Schema.sObjectType.contracthistory.fields.getMap(); }
if (token.getDescribe().getName() == 'contractstatus') { return Schema.sObjectType.contractstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'crontrigger') { return Schema.sObjectType.crontrigger.fields.getMap(); }
if (token.getDescribe().getName() == 'dashboard') { return Schema.sObjectType.dashboard.fields.getMap(); }
if (token.getDescribe().getName() == 'document') { return Schema.sObjectType.document.fields.getMap(); }
if (token.getDescribe().getName() == 'documentattachmentmap') { return Schema.sObjectType.documentattachmentmap.fields.getMap(); }
if (token.getDescribe().getName() == 'emailservicesaddress') { return Schema.sObjectType.emailservicesaddress.fields.getMap(); }
if (token.getDescribe().getName() == 'emailservicesfunction') { return Schema.sObjectType.emailservicesfunction.fields.getMap(); }
if (token.getDescribe().getName() == 'emailstatus') { return Schema.sObjectType.emailstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'emailtemplate') { return Schema.sObjectType.emailtemplate.fields.getMap(); }
if (token.getDescribe().getName() == 'event') { return Schema.sObjectType.event.fields.getMap(); }
if (token.getDescribe().getName() == 'eventattendee') { return Schema.sObjectType.eventattendee.fields.getMap(); }
if (token.getDescribe().getName() == 'fiscalyearsettings') { return Schema.sObjectType.fiscalyearsettings.fields.getMap(); }
if (token.getDescribe().getName() == 'folder') { return Schema.sObjectType.folder.fields.getMap(); }
if (token.getDescribe().getName() == 'forecastshare') { return Schema.sObjectType.forecastshare.fields.getMap(); }
if (token.getDescribe().getName() == 'group') { return Schema.sObjectType.group.fields.getMap(); }
if (token.getDescribe().getName() == 'groupmember') { return Schema.sObjectType.groupmember.fields.getMap(); }
if (token.getDescribe().getName() == 'holiday') { return Schema.sObjectType.holiday.fields.getMap(); }
if (token.getDescribe().getName() == 'idea') { return Schema.sObjectType.idea.fields.getMap(); }
if (token.getDescribe().getName() == 'ideacomment') { return Schema.sObjectType.ideacomment.fields.getMap(); }
if (token.getDescribe().getName() == 'lead') { return Schema.sObjectType.lead.fields.getMap(); }
if (token.getDescribe().getName() == 'leadhistory') { return Schema.sObjectType.leadhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'leadshare') { return Schema.sObjectType.leadshare.fields.getMap(); }
if (token.getDescribe().getName() == 'leadstatus') { return Schema.sObjectType.leadstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'mailmergetemplate') { return Schema.sObjectType.mailmergetemplate.fields.getMap(); }
if (token.getDescribe().getName() == 'name') { return Schema.sObjectType.name.fields.getMap(); }
if (token.getDescribe().getName() == 'note') { return Schema.sObjectType.note.fields.getMap(); }
if (token.getDescribe().getName() == 'noteandattachment') { return Schema.sObjectType.noteandattachment.fields.getMap(); }
if (token.getDescribe().getName() == 'openactivity') { return Schema.sObjectType.openactivity.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunity') { return Schema.sObjectType.opportunity.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunitycompetitor') { return Schema.sObjectType.opportunitycompetitor.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunitycontactrole') { return Schema.sObjectType.opportunitycontactrole.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunityfieldhistory') { return Schema.sObjectType.opportunityfieldhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunityhistory') { return Schema.sObjectType.opportunityhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunitylineitem') { return Schema.sObjectType.opportunitylineitem.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunitypartner') { return Schema.sObjectType.opportunitypartner.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunityshare') { return Schema.sObjectType.opportunityshare.fields.getMap(); }
if (token.getDescribe().getName() == 'opportunitystage') { return Schema.sObjectType.opportunitystage.fields.getMap(); }
if (token.getDescribe().getName() == 'organization') { return Schema.sObjectType.organization.fields.getMap(); }
if (token.getDescribe().getName() == 'orgwideemailaddress') { return Schema.sObjectType.orgwideemailaddress.fields.getMap(); }
if (token.getDescribe().getName() == 'partner') { return Schema.sObjectType.partner.fields.getMap(); }
if (token.getDescribe().getName() == 'partnerrole') { return Schema.sObjectType.partnerrole.fields.getMap(); }
if (token.getDescribe().getName() == 'period') { return Schema.sObjectType.period.fields.getMap(); }
if (token.getDescribe().getName() == 'pricebook2') { return Schema.sObjectType.pricebook2.fields.getMap(); }
if (token.getDescribe().getName() == 'pricebookentry') { return Schema.sObjectType.pricebookentry.fields.getMap(); }
if (token.getDescribe().getName() == 'processinstance') { return Schema.sObjectType.processinstance.fields.getMap(); }
if (token.getDescribe().getName() == 'processinstancehistory') { return Schema.sObjectType.processinstancehistory.fields.getMap(); }
if (token.getDescribe().getName() == 'processinstancestep') { return Schema.sObjectType.processinstancestep.fields.getMap(); }
if (token.getDescribe().getName() == 'processinstanceworkitem') { return Schema.sObjectType.processinstanceworkitem.fields.getMap(); }
if (token.getDescribe().getName() == 'product2') { return Schema.sObjectType.product2.fields.getMap(); }
if (token.getDescribe().getName() == 'profile') { return Schema.sObjectType.profile.fields.getMap(); }
if (token.getDescribe().getName() == 'queuesobject') { return Schema.sObjectType.queuesobject.fields.getMap(); }
if (token.getDescribe().getName() == 'recordtype') { return Schema.sObjectType.recordtype.fields.getMap(); }
if (token.getDescribe().getName() == 'report') { return Schema.sObjectType.report.fields.getMap(); }
if (token.getDescribe().getName() == 'scontrol') { return Schema.sObjectType.scontrol.fields.getMap(); }
if (token.getDescribe().getName() == 'selfserviceuser') { return Schema.sObjectType.selfserviceuser.fields.getMap(); }
if (token.getDescribe().getName() == 'site') { return Schema.sObjectType.site.fields.getMap(); }
if (token.getDescribe().getName() == 'sitehistory') { return Schema.sObjectType.sitehistory.fields.getMap(); }
if (token.getDescribe().getName() == 'solution') { return Schema.sObjectType.solution.fields.getMap(); }
if (token.getDescribe().getName() == 'solutionhistory') { return Schema.sObjectType.solutionhistory.fields.getMap(); }
if (token.getDescribe().getName() == 'solutionstatus') { return Schema.sObjectType.solutionstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'staticresource') { return Schema.sObjectType.staticresource.fields.getMap(); }
if (token.getDescribe().getName() == 'task') { return Schema.sObjectType.task.fields.getMap(); }
if (token.getDescribe().getName() == 'taskpriority') { return Schema.sObjectType.taskpriority.fields.getMap(); }
if (token.getDescribe().getName() == 'taskstatus') { return Schema.sObjectType.taskstatus.fields.getMap(); }
if (token.getDescribe().getName() == 'user') { return Schema.sObjectType.user.fields.getMap(); }
if (token.getDescribe().getName() == 'userlicense') { return Schema.sObjectType.userlicense.fields.getMap(); }
if (token.getDescribe().getName() == 'userpreference') { return Schema.sObjectType.userpreference.fields.getMap(); }
if (token.getDescribe().getName() == 'userrole') { return Schema.sObjectType.userrole.fields.getMap(); }
if (token.getDescribe().getName() == 'vote') { return Schema.sObjectType.vote.fields.getMap(); }
if (token.getDescribe().getName() == 'weblink') { return Schema.sObjectType.weblink.fields.getMap(); }
throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + token);
} // getFieldMap

} // SmartFactoryHelper