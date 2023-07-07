trigger CourseTrainerTrigger on CourseTrainers__c(before insert, before update) {

    // Get the course id &  trainer id
    Set < Id > courseIdsSet = new Set < Id > ();
    Set < Id > tranerIdsSet = new Set < Id > ();

    For(CourseTrainers__c ct: Trigger.New) {
        courseIdsSet.add(ct.course__c);
        tranerIdsSet.add(ct.Trainer__c);
    }

    //Get the start date time from course

    Map < Id, DateTime > requestedCourses = new Map < Id, DateTime > ();

    List < course__c > relatedCoursList = [SELECT Id, Start_DateTime__c
                                           FROM Course__c
                                           WHERE Id IN: courseIdsSet];

    for (course__c co: relatedCoursList) {
        requestedCourses.put(co.id, co.start_dateTime__c);
    }

    //Query on Course-Trainer to get the related trainer along with course start date.addDays(days)

    list < CourseTrainers__c > relatedCourseTrainerList = [SELECT Id, Course__c, course__r.Start_DateTime__c
                                                           FROM CourseTrainers__c
                                                           WHERE Trainer__c IN: tranerIdsSet];

    //Check the Conditions
    For(CourseTrainers__c ct: Trigger.New) {
        DateTime bookingTime = requestedCourses.get(ct.Course__c);

        for (CourseTrainers__c ct1: relatedCourseTrainerList) {
            if (ct1.Course__c == ct.Course__c && ct1.Course__r.Start_DateTime__c == bookingTime) {
                ct.Course__c.addError('The course is already booked at that time');
                ct.addError('The course is already booked at that time');
            }
        }

    }

}