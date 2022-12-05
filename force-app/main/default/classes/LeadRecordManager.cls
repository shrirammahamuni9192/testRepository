/*
 * 
Class Name : LeadRecordManager
Use : To process the lead data received from third party according to request of user

Change Log 
Date				Description						User
17 May 2022			Initital Version				Shriram M

*/


global class LeadRecordManager {
    webservice static string createNewLead(String fName, String LName, String companyName){
        String returnValue = '';
        Lead newLead = new Lead();
        newLead.FirstName = fName;
        newLead.LastName = lName;
        newLead.Company = companyName;
        try{
            insert newLead;
            returnValue = newLead.Id;
        }catch(Exception ex){
            System.debug('Exception: '+ex.getMessage() + ' ' + ex.getLineNumber());
            returnValue = ex.getMessage();
        }
        return returnValue;
    }
    
    webservice static string getLeadData(String recordId){
		String dataToReturn = '';
        List<Lead> lList = [Select Id, Name,Company From Lead Where Id =: recordId];
        
        if(lList.size() >0 ){
            dataToReturn =  JSON.serialize(lList[0]);
        }else{
            dataToReturn = 'Data not Found';
        }
        return dataToReturn;
    }
    
    webservice static string deleteNewLead(String fName){
        String returnValue = '';
        String searchString = '%'+fName+'%';
        List<Lead> newLeadList = new List<Lead>();
        newLeadList = [Select Id, FirstName 
                   FROM Lead
                  WHERE FirstName LIKE : searchString
                  LIMIT 5];
        try{
            Delete newLeadList;
            returnValue = 'Record Deleted.';
        }catch(Exception ex){
            System.debug('Exception: '+ex.getMessage() + ' ' + ex.getLineNumber());
            returnValue = ex.getMessage();
        }
		return returnValue;
    }
}