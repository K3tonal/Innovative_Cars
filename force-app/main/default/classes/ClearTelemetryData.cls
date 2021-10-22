/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Batch job class for Clearing Telemetry Data 
* *  @Task: POX-1 
* */
public with sharing class ClearTelemetryData implements Database.Batchable<SObject> {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method preper data for batch job           
     * *  @Task: POX-1 
     * *  @param bc Database.BatchableContext
     * *  @return List of Telemetry 
     * */
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        String querry = 'SELECT Id, CreatedDate, Manager_Notes__c FROM Telemetry__c WHERE CreatedDate != LAST_N_DAYS:1'; //todo: change for 30 days
        return Database.getQueryLocator(querry);
    }

     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method deletes Telemetries          
     * *  @Task: POX-1 
     * *  @param bc Database.BatchableContext
     * *  @param scope  List of Telemetry record
     * */
    public void execute(Database.BatchableContext bc, List<Telemetry__c> scope){
                
        delete scope;
    }
         /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description           
     * *  @Task: POX-1 
     * *  @param bc Database.BatchableContext
     * */
    public void finish(Database.BatchableContext bc){}
}
