/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Dealership Utility Class. 
* *  @Task: POX-1 
* */
public with sharing class DealershipUtility {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Method check if field Status was set to closed on 
     * *                Dealership and if yes creates New case and pass it 
     * *                to async callRenovationTeam
     * *  @Task: POX-1 
     * *  @param dealershipTriggerNew List from Trigger.new
     * *  @param dealershipTriggerOldMap Map from Trigger.old
     * */
    public void createCaseIfClosed(List<Dealership__c> dealershipTriggerNew, Map<Id,Dealership__c> dealershipTriggerOldMap){        

        List<Dealership__c> dealershipsClosed = new List<Dealership__c>();
        List<Case> caseList = new List<Case>();

        for(Dealership__c dealer : dealershipTriggerNew) {
            if(dealer.Status__c == 'closed' && (dealer.Status__c != dealershipTriggerOldMap.get(dealer.Id).Status__c)){
                dealershipsClosed.add(dealer);                
                caseList.add(new Case(Origin='Web', Dealership__c = dealer.Id ,Reason='renovation'));                             
            }
        }
        insert caseList;
        
        Set<Id> resultIds = (new Map<Id,Case>(caseList)).keySet();
        callRenovationTeam(resultIds);
    }

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Async method making callout to external API 
     * *                if returned status is OK update related Case.
     * *  @Task: POX-1 
     * *  @param caseIdList Set of Case Ids.
     * */
    @future(callout=true)
    static void callRenovationTeam(Set<Id> caseIdList){
        Http server = new Http(); 
        HttpRequest req = new HttpRequest(); 

        List<Case> caseList = [SELECT Id FROM Case WHERE Id IN :caseIdList];
        System.debug('############################################'+caseList);

        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST'); 
        req.setBody(JSON.serialize(caseList));  
        HttpResponse resp = server.send(req); 

        If(resp.getStatusCode() == 201){            
            for(Case c : caseList){
                c.Status = 'Closed';
            }
        } else {
            System.debug(LoggingLevel.ERROR,'blad polaczenia');
            for(Case c : caseList){
                c.Status = 'Failed';
            }
        } 
        update caseList;
    }
}
