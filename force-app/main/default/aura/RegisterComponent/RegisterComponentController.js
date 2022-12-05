({
    handleSaveContact : function(component, event, helper) {
        console.log("Inside handle save!!");
        
        var action = component.get("c.createContact");
        action.setParams({
            "fName": component.get("v.fName"),
            "lName": component.get("v.lName"),
            "eMail": component.get("v.eMail")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            console.log('state is :'+ state);
            if(state === "SUCCESS")
            {	 
                console.log('before setting values: '); 
                var contactId = response.getReturnValue();
                console.log(response.getReturnValue()); 
                component.set("v.newContactId",contactId); 
                component.set("v.showFirstPage",false);
            }
            else
            {  
                var errors = response.getError();
                if (errors)
                {
                    if (errors[0] && errors[0].message)
                    {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})