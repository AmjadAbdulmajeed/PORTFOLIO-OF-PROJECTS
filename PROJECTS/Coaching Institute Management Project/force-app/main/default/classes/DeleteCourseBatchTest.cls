@isTest
public class DeleteCourseBatchTest {
    @testSetup
    public static void testSetupData() {
        Courses_Organizer__c org = new Courses_Organizer__c(
            Email__c = 'omar@gmail.com',
            Phone__c = '068543234');
        insert org;
        List < Course__c > courseList = new List < Course__c > ();

        Course__c Course = new Course__c(
            Name__c = 'Web Development',
            Courses_Organizer__c = org.Id,
            Course_Type__c = 'Virtual',
            Frequency__c = 'Weekly',
            Max_Seats__c = 22,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_Date_Time__c = System.now().addDays(3));
        courseList.add(Course);

        insert courseList;
    }
    @isTest
    static void sendDeleteCourseTest() {
        Test.startTest();
        String jobId = Database.executeBatch(new DeleteCourseBatch(), 200);
        Test.stopTest();
    }

}