/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Queueable class 
* *  @Task: POX-1 
* */
public with sharing class CreateCaseQue implements Queueable {
    
    List<Dealership__c> dealershipListUpdated;
    Map<Id,Dealership__c> dealershipMapBeforeUpdate;

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Constructor method              
     * *  @Task: POX-1 
     * *  @param dealershipTriggerNew List of Dealership from Trigger.New
     * *  @param dealershipTriggerOldMap Map of Dealership from Trigger.newMap
     * */
    public CreateCaseQue(List<Dealership__c> dealershipTriggerNew, Map<Id,Dealership__c> dealershipTriggerOldMap) {
        this.dealershipListUpdated = dealershipTriggerNew;
        this.dealerShipMapBeforeUpdate = dealershipTriggerOldMap;
    }

     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Execute method filter Dealerships which status was changed             
     * *  @Task: POX-1 
     * *  @param context QueueableContext
     * */
    public void execute(QueueableContext context){
        List<Case> caseList = new List<Case>();
        for(Dealership__c dealer: dealershipListUpdated){
            if(dealer.Status__c == 'closed' && (dealer.Status__c != dealershipMapBeforeUpdate.get(dealer.Id).Status__c)){ 
                caseList.add(new Case(Origin='Web', Dealership__c = dealer.Id ,Reason='renovation')); 
            }
        }
        if(caseList.size() > 0){
            insert caseList;
            Set<Id> resultIds = (new Map<Id,Case>(caseList)).keySet();
            System.enqueueJob(new RenovationTeamCalloutQue(resultIds));
         }
    }
}


