/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Data scheduler for ClearTelemetryData batch job 
* *  @Task: POX-1 
* */

public with sharing class ClearTelemetryDataScheduler implements Schedulable {
    
      /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description        
     * *  @Task: POX-1 
     * *  @param sc SchedulableContext
     * */
    public void execute(SchedulableContext sc){
        ClearTelemetryData myBatchObject = new ClearTelemetryData();
        Id batchId = Database.executeBatch(myBatchObject);
    }

}
