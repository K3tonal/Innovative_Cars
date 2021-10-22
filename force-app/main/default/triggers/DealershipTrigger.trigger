/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Trigger class for Dealership
* *  @Task: POX-1 
* */
trigger DealershipTrigger on Dealership__c (after update) {

    DealershipUtility dealerUtility = new DealershipUtility();
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            dealerUtility.createCaseIfClosed(Trigger.new, Trigger.oldMap);
        }
    }

}