/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Vehicle Utility Class 
* *  @Task: POX-1 
* */
public with sharing class VehicleUtility {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
    * *  @description Method removes Telemetry records from Trigger
    * *                 and create To Do record to check 
    * *  @Task: POX-1 
    * *  @param vehiclesFromTrigger List of Vehicles from Trigger
    * */
   public void clearTelemetryData(List<Vehicle__c> vehiclesFromTrigger){

       List<Telemetry__c> telemeteries = [SELECT id FROM Telemetry__c WHERE Vehicle__r.Id IN :vehiclesFromTrigger];
       
       List<To_do__c> toDoList = new List<To_do__c>();
       For(Vehicle__c vehicle : vehiclesFromTrigger){
            toDoList.add(new To_do__c(Status__c='New', Description__c = System.label.CHECK_VEHICLE_AFTER_DELETION + vehicle.Vin__c));
       }

       insert toDoList;
       delete telemeteries;
      
       
   }
}

