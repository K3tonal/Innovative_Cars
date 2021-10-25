        //List<Case> caseList = [SELECT Id from Case WHERE Id = '5007R0000329qVeQAI'];

//        Case dealerCase = new Case(Origin='Web', Dealership__c ='a017R00003x4PgHQAU',Reason='renovation');
//        System.debug(dealerCase);


String cronExpr = '0 26 9 22 10 ? 2021';
 String jobId = 
            System.schedule('ClearTelemetryDataScheduler', cronExpr, new ClearTelemetryDataScheduler());
       