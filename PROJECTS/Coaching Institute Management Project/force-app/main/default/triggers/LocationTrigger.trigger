trigger LocationTrigger on Location1__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        for(Location1__c loc : Trigger.New){
           LocationTriggerHandler.verifyAddress(loc.Id);  
        }
    }

}