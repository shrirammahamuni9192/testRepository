/*
Name : DynamicRecordSearcher
Use : to get the data from objects as per the search criteria
Owner : Shriram M
Update history : 
Sr No		Description				Date				Updated by
1			Initial version			31 May 2022			Shriram M
*/


public without sharing class DynamicRecordSearcher {
    
    public static SearchRecordWrapper searchRecords(String searchParam){
        
        Map<String,String> objNameVsFieldsToFetch = new Map<String,String>();
        for(Search_Configuration__mdt sConfig : [SELECT Object_Name__c,Fields_to_fetch__c  FROM Search_Configuration__mdt ORDER BY Object_Name__c ASC]){
            objNameVsFieldsToFetch.put(sConfig.Object_Name__c,sConfig.Fields_to_fetch__c);
        }
        
        String searchIn = '';
        for(String objName : objNameVsFieldsToFetch.keySet()){
            searchIn = searchIn + objName+'('+ objNameVsFieldsToFetch.get(objName)+'),';
            
            String type=objName;
            
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get(type);
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            
            
            for (String fieldName: fieldMap.keySet()) {
                String fields = objNameVsFieldsToFetch.get(objName);
                if(fields.contains(fieldName)){
                    System.debug('##Field API Name='+fieldName);// list of all field API name
                    fieldMap.get(fieldName).getDescribe().getLabel();//It provides to get the object fields label.
                } 
            }
            

            
        }
        searchIn = searchIn.removeEnd(',');
        String querystring = 'FIND \'' + searchParam + '\' IN Name FIELDS RETURNING '+searchIn+' WITH METADATA=\'LABELS\'';
        
        List<List<SObject>> result = Search.query(querystring);
        
        SearchRecordWrapper srw = new SearchRecordWrapper();
        
        for(List<SObject> sobjList : result){
            Id recordId = sobjList[0].Id;
            String objName = recordId.getSObjectType().getDescribe().getName();
            srw.objNameVsRecordsMap.put(objName, sobjList);
        }     
        system.debug('srw: ');
        system.debug(srw);
        return srw;
    }
    
    
    public class SearchRecordWrapper{
        Map<String,List<SObject>> objNameVsRecordsMap = new Map<String,List<SObject>>();
        Map<String,List<String>> objNameVsColumnsMap = new Map<String,List<String>>();
    }
}