/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Queueable class 
* *  @Task: POX-1 
* */
public with sharing class RenovationTeamCalloutQue implements Queueable, Database.AllowsCallouts {
    
    Set<Id> caseIdList;

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Constructor method              
     * *  @Task: POX-1 
     * *  @param caseIdList Set of Case Id
     * */
    public RenovationTeamCalloutQue(Set<Id> caseIdList) {  
        this.caseIdList = caseIdList;
    }

     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description  Execute method calls external service and change 
     * *                Case status if resonse == 201        
     * *  @Task: POX-1 
     * *  @param context QueueableContext
     * */
    public void execute(QueueableContext context){
        Http server = new Http(); 
        HttpRequest req = new HttpRequest(); 

        List<Case> caseList = [SELECT Id FROM Case WHERE Id IN :caseIdList];

        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST'); 
        req.setBody(JSON.serialize(caseList));  
        HttpResponse resp = server.send(req); 

        If(resp.getStatusCode() == 201){            
            for(Case c : caseList){
                c.Status = 'Closed';
            }
        } else {
            System.debug(LoggingLevel.ERROR,'Connection Error');
            for(Case c : caseList){
                c.Status = 'Failed';
            }
        } 
        update caseList;
    }
}


