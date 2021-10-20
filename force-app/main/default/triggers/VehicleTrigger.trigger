trigger VehicleTrigger on Vehicle__c (before delete) {
    
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            VehicleUtility vehicleUtil = new VehicleUtility();
            vehicleUtil.clearTelemetryData(Trigger.old);
        }
    } 
}