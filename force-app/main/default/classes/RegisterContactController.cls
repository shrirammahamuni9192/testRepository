public class RegisterContactController {
    @AuraEnabled
    Public Static Id createContact(String fName,String lName,String eMail){
        Contact objContact = new Contact();
        objContact.FirstName = fName;
        objContact.LastName = lName;
        objContact.Email = eMail;
        objContact.accountId = '0015g00000xerxAAAQ';
        // create contact
        system.debug('objContact: '+objContact);
        
        try{
            insert objContact;             
        }catch(Exception e){
            system.debug('exception: '+e.getStackTraceString());
        }
        
        return objContact.id;
    }
    
}