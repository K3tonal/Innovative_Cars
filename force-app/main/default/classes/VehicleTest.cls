/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Test Class for Vehicle 
* *  @Task: POX-1 
* */
@isTest
public with sharing class VehicleTest {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Test method to check deletion of Vehicle 
     * *               with exisitng Telemetry 
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest
    static void deleteVehiclesWithTelemetry(){
        List<Vehicle__c> vehicleList = VehicleDataFactory.createVehiclesWithTelemetry(2,3);
        
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(vehicleList,false);
        Test.stopTest();

        for(Database.DeleteResult result : results){
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size() == 0);
        }
    }  

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Test method to check deletion of Vehicle 
     * *               with no exisitng Telemetry 
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest
    static void deleteVehiclesWithNoTelemetry(){
        List<Vehicle__c> vehicleList = VehicleDataFactory.createVehiclesWithTelemetry(2,0);

        Test.startTest();
        Database.DeleteResult[] results = Database.delete(vehicleList,false);
        Test.stopTest();

        for(Database.DeleteResult result : results){
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size() == 0);
        }
    }    
}

