public class DeleteCourseBatch implements Database.Batchable < sObject > {

    // Collect the Course records to passed to execute
    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        String query = 'SELECT Id, Name FROM Course__c WHERE Live__c = true AND End_Date_Time__c < LAST_N_MONTHS:10';
        return Database.getQueryLocator(query);
    }
    
    // Process each batch of records
    public void execute(Database.BatchableContext batchContext, List < Course__c > courseList) {
        if (!courseList.isEmpty()) {
            List < Database.DeleteResult > deleteResult = Database.delete(courseList);
            for (Database.DeleteResult dr: deleteResult) {
                if (dr.isSuccess()) {
                    List < Database.Error > errors = dr.getErrors();
                    String errorInString = String.join(errors, ',');
                }
            }
        }
    }

    public void finish(Database.BatchableContext batchContext) {
        //Send Eamil
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setSubject('Batch Processing Completed');
        List < String > toAddress = new List < String > ();
        toAddress.add('amjad@gmail.com');
        mail.setToAddresses(toAddress);
        mail.setSenderDisplayName('Coaching Institute Management ');

        mail.setHtmlBody('The DeleteCourseBatch Batch Prcoessing has been Completed');
        List < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > {
            mail
        };
        Messaging.sendEmail(emails);
    }

}