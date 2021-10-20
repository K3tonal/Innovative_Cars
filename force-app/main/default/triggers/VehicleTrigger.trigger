/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Trigger class for Vehicle
* *  @Task: POX-1 
* */
trigger VehicleTrigger on Vehicle__c (before delete) {
    
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            VehicleUtility vehicleUtil = new VehicleUtility();
            vehicleUtil.clearTelemetryData(Trigger.old);
        }
    } 
}