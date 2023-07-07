trigger CourseStudentTrigger on Course_Student__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        CourseStudentTriggerHandler.sendConfirmationEmail(Trigger.new);
    }

}