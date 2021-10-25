/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Dealership Utility Class. 
* *  @Task: POX-1 
* */
public with sharing class DealershipUtility {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  calls queueable method to create Case and send email             
     * *  @Task: POX-1 
     * *  @param dealershipTriggerNew List from Trigger.new
     * *  @param dealershipTriggerOldMap Map from Trigger.old
     * */
    public void createCaseIfClosed(List<Dealership__c> dealershipTriggerNew, Map<Id,Dealership__c> dealershipTriggerOldMap){       

        System.enqueueJob(new CreateCaseQue(dealershipTriggerNew, dealershipTriggerOldMap));
    }
}
