public with sharing class accountHandler {
    
    
    public List<Account> accList{get;set;}
    public accountHandler() {
        
        List<Schema.FieldSetMember> fieldSetMemberList =  readFieldSet('SampleSet','Account');
        String queryString = getQueryString(fieldSetMemberList,'Account');
        acclist = Database.query(queryString);
        system.debug(accList);
    }

    //To form query string
    public String getQueryString(List<Schema.FieldSetMember> fieldSetMemberList,String objName){
        string query = 'select Id';
        for(Schema.FieldSetMember fld : fieldSetMemberList) {
         query += ', ' + fld.getFieldPath();
        }
        query += ' from '+objName;
        return query;
    }

     //to get the fields from fieldSet
    public List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
    {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));

        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
        return fieldSetObj.getFields(); 

        //SObjectType.ObjectName.FieldSets.fieldSetName.getFields()
    }  




    @AuraEnabled(cacheable= true)
    public static List<Account> getAccountList(){
        return [select id,name from account];
    }

    @AuraEnabled(cacheable= true)
    public static List<Contact> getContactList(){
        return [select id,name from Contact];
    }

    //reTrieving the Specific Account based on ID.
    @AuraEnabled(cacheable = true)
    public static Account getSpecificAccount(String accId){
        return [select id,Name from account where Id=:accId];
    }



    




   
}