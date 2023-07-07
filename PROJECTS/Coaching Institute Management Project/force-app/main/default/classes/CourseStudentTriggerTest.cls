@isTest
public class CourseStudentTriggerTest {
    @testSetup
    public static void setupDate() {

        //Insert test data
        Courses_Organizer__c org = new Courses_Organizer__c(
            Email__c = 'omar@gmail.com',
            Phone__c = '068543234');
        insert org;

        Course__c Course = new Course__c(
            Name__c = 'Web Development',
            Courses_Organizer__c = org.Id,
            Course_Type__c = 'Virtual',
            Frequency__c = 'Weekly',
            Max_Seats__c = 22,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_Date_Time__c = System.now().addDays(3));
        insert Course;

        Student__c st = new Student__c(
            Name = 'Ali',
            Email__c = 'ali@gmail.com',
            phone__c = '313456542432');
        insert st;

        Course_Student__c coStu = new Course_Student__c(
            Course__c = Course.Id,
            Student__c = st.Id);
        insert coStu;

    }

    @isTest
    static void sendEmailTest() {

    }

}