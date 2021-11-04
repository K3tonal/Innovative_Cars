/*   @author name <wojciech.krasowski@accenture.com> * @date 03/11/2021 * 
* *  @description Prepers data for LWC displayVehicleDetail
* *  @Task: POX-1 
* */
public with sharing class LwcVehicleDetailController {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 01/11/2021 * 
     * *  @description Method adds or remove User from Vehicle Interest List 
     * *                based of provided vehicleId and status       
     * *  @Task: POX-1 
     * *  @param status value from checkbox
     * *  @param vehicleId 
     * */
    @AuraEnabled
    public static void addOrRemoveUserFromVehicleInterest(Boolean status, String vehicleId){
        
        if(vehicleId != null){
            Id vehId = vehicleId;
            String userId = UserInfo.getUserId();
            User user = [Select Id, Name from User where Id =:userId];

            Vehicle__c vehicle = [SELECT Id, Brand__c, Model__c, User_interested__c from Vehicle__c where Id=:vehId];

            if(status){
                vehicle.User_interested__c = user.Id;                
            } else {
                vehicle.User_interested__c = null;
            }
            update vehicle;
        }        
    }

    /** * @author name <wojciech.krasowski@accenture.com> * @date 01/11/2021 * 
     * *  @description Method sets initial value of checkbox on LWC 
     * *  @param  vehicleId     
     * *  @Task: POX-1 
     * *  @return Value to be set on checkbox
     * */
    @AuraEnabled(cacheable=true)
    public static Boolean setInitCheckboxValueOnLwc(String vehicleId){
        if(vehicleId != null){

            Id vehId = vehicleId;
            String userId = UserInfo.getUserId();
            User user = [Select Id, Name from User where Id =:userId];

            Vehicle__c vehicle = [SELECT Id, Brand__c, Model__c, User_interested__c from Vehicle__c where Id=:vehId];
            if(vehicle.User_interested__c == user.Id ){
                return true;
            }            
        }
        return false;
    }
}
