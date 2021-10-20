/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Vehicle Utility Class 
* *  @Task: POX-1 
* */
public with sharing class VehicleUtility {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
    * *  @description Method removes Telemetry records from Trigger
    * *  @Task: POX-1 
    * *  @param telemetryFromTrigger List of Vehicles from Trigger
    * */
   public void clearTelemetryData(List<Vehicle__c> telemetryFromTrigger){
       List<Telemetry__c> telemeteries = [SELECT id FROM Telemetry__c WHERE Vehicle__r.Id IN :Trigger.old];
       
       if(telemeteries != null){            
           To_do__c todo = new To_do__c(Status__c='New', Description__c = 'Please check Env after Vehicle deletion.');
           insert todo;
       }
       delete telemeteries;
      
       
   }
}

