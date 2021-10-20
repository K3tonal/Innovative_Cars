/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Vehicle Data Factory Class
* *  @Task: POX-1 
* */
public with sharing class VehicleDataFactory {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method creates List of Vehicles and associated Telemetry records
     * *  based on given ammounts
     * *  @Task: POX-1 
     * *  @param numberOfVehicles Number of Vehicle record to create
     * *  @param telemetryPerVeh Number of associated Telemetry record to create
     * *  @return list of vehicles
     * */
    public static List<Vehicle__c> createVehiclesWithTelemetry(Integer numberOfVehicles, Integer telemetryPerVeh){

        List<Vehicle__c> vehicleList = new List<Vehicle__c>();
        for(Integer i = 0; i < numberOfVehicles; i ++){
            vehicleList.add(new Vehicle__c(Brand__c='TestBrand' +i, Model__c = 'TestModel' +i, Vin__c = 'TestVIN'+i ));            
        }
        insert vehicleList;

        List<Telemetry__c> telemetryList = new List<Telemetry__c>();
        for(Vehicle__c vehicle : vehicleList){
            for( Integer i =0 ; i < telemetryPerVeh; i++){
                telemetryList.add(new Telemetry__c(Vehicle__c = vehicle.id));    
            }
        }
        insert telemetryList;
        
        return vehicleList;
    }
}
