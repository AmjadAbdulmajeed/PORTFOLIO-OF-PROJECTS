public class CourseStudentTriggerHandler {
    public static void sendConfirmationEmail(List < Course_Student__c > newRecordList) {

        //Get the id from course and student
        Set < Id > studentsIdsSet = new Set < Id > ();
        Set < Id > coursesIdsSet = new Set < Id > ();

        for (Course_Student__c cs: newRecordList) {
            studentsIdsSet.add(cs.student__c);
            coursesIdsSet.add(cs.Course__c);
        }

        Map < Id, Student__c > studentMap = new Map < Id, student__C > (
                                            [SELECT Id, Email__c, Name
                                             FROM Student__c
                                             WHERE Id IN: studentsIdsSet]);

        //Get inforamtion from template
        Map < id, Course__c > courseMap = new Map < Id, Course__c > (
                                        [SELECT Id, Name__c, Start_DateTime__c, Courses_Organizer__c, Courses_Organizer__r.Name, Location1__c,
                                                Location1__r.Name, Location1__r.City__c, Location1__r.Street__c, Location1__r.postal_Code__c
                                        FROM Course__c
                                        WHERE Id IN: coursesIdsSet ]);

        List < Messaging.SingleEmailMessage > eamilList = new List < Messaging.SingleEmailMessage > ();

        for (Course_Student__c cs: newRecordList) {
            
            student__c st = studentMap.get(cs.Student__c);
            course__c co = courseMap.get(cs.Course__c);

            //Class Messaging
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            //Prepare Email Template
            mail.setSubject('Padd for the ' + co.Name__c);
            List < String > toAddress = new List < String > ();
            toAddress.add(st.Email__c);
            mail.setToAddresses(toAddress);
            mail.setSenderDisplayName(co.Courses_Organizer__r.Name);

            //prepare a location
            String location = 'https://www.google.com/maps/place/' + co.Location1__r.Street__c +
                ' ' + co.Location1__r.City__c + ' ' + co.Location1__r.postal_Code__c;

            //Prepare hyperlink
            String herfForLocation = '<a href="' + location + '"' + 'target="_blank">Here</a>';

            //Prepare a Email body
            String emailBody = 'Dear ' + st.Name + ',<br/><br/>' +
                'Thank you for regidtering for ' + co.Name__c + ' which will be organized on ' +
                +co.start_DateTime__c + ' & will be held in ' + co.Location1__r.Name +
                '.<br/> we are excited to have you, ' +
                'see you in the event. <br/>' +
                'Find the Google maplocation fot the course ' +
                herfForLocation + '.<br/><br/><br/>' +
                'Thanks,<br/>' + co.Courses_Organizer__r.Name;

            mail.setHtmlBody(emailBody);
            eamilList.add(mail);
        }
    }
}