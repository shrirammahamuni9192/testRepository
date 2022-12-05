public without sharing class GetLeaveDetailsController {
    public String URL { get;set; }
    public String RecordId { get;set; }
    public list<Opportunity> leaveRecList {get;set;}
    //Public string recIdLeave  {get;set;}
    
    
    public GetLeaveDetailsController(){
        // recIdLeave = 'a035i000002NKZBAA4';
        URL=Apexpages.currentPage().getUrl();
        system.debug('RECORDID:'+URL);
        RecordId=URL.substringAfter('=').trim();
        system.debug('======='+RecordId); 
        leaveRecList = [Select Id,Name,StageName,Description,Status__c FROM Opportunity LIMIT 10];
        
        system.debug('======='+leaveRecList);
    }
    
    public void save() {
        try {
            //upsert leaveRecList;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            //return null;
        }
        //  After successful Save, navigate to the default view page
        // PageReference redirectSuccess = new ApexPages.StandardController(leaveRecList).view();
        //return (redirectSuccess);
        //return new PageReference ('/' + RecordId);
       // PageReference LeaveVFPage = Page.LeaveStatusMessagePage;
        //LeaveVFPage.setRedirect(false);
       // return LeaveVFPage;
        
        //return Page.LeaveStatusMessagePage;
    }
    
    /*public void SendMailToEmployee(map<id,Leave_Detail__c>oldmap,map<id,Leave_Detail__c>newmap){
for(id key:oldmap.keyset()){
Leave_Detail__c old=oldmap.get(key);
Leave_Detail__c newmap1=newmap.get(key);
if(old.Status__c=='Pending For Approval' && Newmap1.Status__c=='Rejected' ||  Newmap1.Status__c=='Approved'){
Messaging.SingleEmailMessage msg=new Messaging.SingleEmailMessage();
String[] employeemail=new String[]{Newmap1.Employee_Email__c};
msg.SetToAddresses(employeemail);
String body='Hello' +' ' +Newmap1.EmployeeID__r.Name+'Your Leave Request is'+Newmap1.Status__c+'with reason'+Newmap1.Manager_Comments__c;
msg.setPlainTextBody(body);
msg.setsubject('Confiramtion Of Leave Request');
Messaging.Email[] emails=new Messaging.Email[]{msg};
Messaging.sendEmail(emails);
}
}

}*/
    
    
    public PageReference approveHandle(){
        // leaveRec.Status__c = 'Approved';
        // update leaveRec;
        return new PageReference ('/' + RecordId);
        
    }
    
    public PageReference rejectHandle(){
        // leaveRec.Status__c = 'Rejected';
        // update leaveRec;
        return new PageReference ('/' + RecordId);
        
    }
    
    /* 
@AuraEnabled
public static String URL { get;set; }  
@AuraEnabled
public static String RecordId { get;set; }  
@AuraEnabled
public static List<Leave__c> listEmp {get;set;}
@AuraEnabled
public static Id getLeaveDetailsMethod(){
URL=Apexpages.currentPage().getUrl();
system.debug('RECORDID:'+URL);
RecordId=URL.substringAfter('=').trim();
system.debug('======='+RecordId);

// Leave__c objLeave = [Select Id, EmployeeID__r.Name, Reason__c, Start_Date__c ,End_Date__c,Status__c from Leave__c where EmployeeID__r.Id=:RecordId];

return RecordId;

}
*/
    
}