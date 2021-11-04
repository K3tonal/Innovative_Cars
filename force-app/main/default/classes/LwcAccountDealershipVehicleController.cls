/*   @author name <wojciech.krasowski@accenture.com> * @date 03/11/2021 * 
* *  @description Prepers data for LWC displayVehicleParent
* *  @Task: POX-1 
* */
public with sharing class LwcAccountDealershipVehicleController {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 01/11/2021 * 
     * *  @description Method to get Account List          
     * *  @Task: POX-1 
     * *  @return List of Accounts
     * */
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountList(){
        List<Account> accList = [Select Id, Name, Phone, Industry, Description From Account];
        return accList;
    }
    /** * @author name <wojciech.krasowski@accenture.com> * @date 01/11/2021 * 
     * *  @description Method to get Dealer List based on accountId  
     * *  @param  accId Account ID     
     * *  @Task: POX-1 
     * *  @return List of Dealers
     * */
    @AuraEnabled(cacheable = true)
    public static List<Dealership__c> getDealershipList(String accId){
       List<Dealership__c> dealerList = [SELECT Id, Name, Street__c, Number__c, City__c FROM Dealership__c WHERE Account__c=:accId];
       return dealerList;
    }
    /** * @author name <wojciech.krasowski@accenture.com> * @date 01/11/2021 * 
     * *  @description Method to get Vehicle List based on dealerId
     * *  @param  dealerId Dealer ID    
     * *  @Task: POX-1 
     * *  @return List of Vehicles
     * */
    @AuraEnabled(cacheable = true)
    public static List<Vehicle__c> getVehicleList(String dealerId){
        List<Vehicle__c> vehicleList = [SELECT Id, Name, Brand__c, Model__c FROM Vehicle__c WHERE Id IN (SELECT Vehicle__c FROM Car_offer__c WHERE Dealership__c = :dealerId)];
        return vehicleList;
    }
}
