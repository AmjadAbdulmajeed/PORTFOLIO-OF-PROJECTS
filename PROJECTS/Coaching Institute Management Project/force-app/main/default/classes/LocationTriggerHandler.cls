public class LocationTriggerHandler {

    public static void verifyAddress(String recordId) {

        //Query all info from location
        Location1__c loc = [SELECT Id, City__c, Street__c, Postal_Code__c
                            FROM Location1__c
                           WHERE Id =: recordId ];
                           
        //Prepare URL
        String baseURL = 'https://smartystreets.com/products/apis/us-street-api';

        //Prepare a request
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        httpReq.setEndpoint(baseURL);
        httpReq.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HttpResponse httpRes = new HttpResponse();

        //Send a request
        httpRes = http.send(httpReq);

    }

}