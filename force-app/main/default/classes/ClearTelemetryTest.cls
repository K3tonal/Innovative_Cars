/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Test Class for ClearTelemetryData batch
* *  @Task: POX-1 
* */

@isTest
public with sharing class ClearTelemetryTest {
    
     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Setup method for creating test records            
     * *  @Task: POX-1 
     * *  @param 
     * */
    @TestSetup
    static void setup(){
        Datetime tenDaysOld = Datetime.now().addDays(-10);
        Vehicle__c vehicle = new Vehicle__c(Brand__c='TestBrand' , Model__c = 'TestModel' , Vin__c = 'TestVIN'); 
        insert vehicle;
        Telemetry__c tele = new Telemetry__c(Vehicle__c = vehicle.id);        
        insert tele;
        Test.setCreatedDate(tele.id, tenDaysOld);        
        
    }

     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description method to test batch job execution          
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest()
    static void testBatchJob(){
        System.assertNotEquals(0, [SELECT COUNT() FROM Telemetry__c WHERE CreatedDate != LAST_N_DAYS:7], 'Expecting ONE Telemetry record');
        test.startTest();
        ClearTelemetryData clearTele = new ClearTelemetryData();
        Database.executeBatch(clearTele);
        test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Telemetry__c WHERE CreatedDate != LAST_N_DAYS:7], 'Expecting NO Telemetry record'); 
    }
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description method to test batch job scheduler        
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest static void testScheduler () {
        
        String cronExpr = '0 0 0 15 3 ? 2022';

        List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
        System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');
    
        Test.startTest();
        
        String jobId = 
            System.schedule('ClearTelemetryDataScheduler', cronExpr, new ClearTelemetryDataScheduler());
        Test.stopTest();
    
        List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
        System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
        System.assertEquals('ClearTelemetryDataScheduler', jobsScheduled[0].ApexClass.Name, 'expecting specific scheduled job');
    
        // check apex batch is in the job list
        List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'BatchApex'];
        System.assertEquals(1, jobsApexBatch.size(), 'expecting one apex batch job');
        System.assertEquals('ClearTelemetryData', jobsApexBatch[0].ApexClass.Name, 'expecting specific batch job');
    
    
    }


}
