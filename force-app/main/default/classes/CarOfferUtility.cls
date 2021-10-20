
/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Car Offer Utility Class
* *  @Task: POX-1 
* */
public with sharing class CarOfferUtility {

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method iteret over Car_Offer List and return error  
     * *  for vehicle that already has physical offer.
     * *  @Task: POX-1 
     * *  @param carOffersFromTrigger List from Trigger.new
     * */
    public void validateOnlyOnePhysicalOffer(List<Car_Offer__c> carOffersFromTrigger) {

        
        List<Id> vehicleIdList = new List<Id>();
        for(Car_Offer__c co : carOffersFromTrigger){
            if(co.Offer_Type__c == 'physical'){
                vehicleIdList.add(co.Vehicle__c);
            }           
        } 
        
        List<Car_Offer__c> existingCarOffers = [SELECT id, Offer_Type__c, Vehicle__r.id, Dealership__r.Name FROM Car_Offer__c WHERE Vehicle__r.Id IN :vehicleIdList];
       

        for(Car_Offer__c co : carOffersFromTrigger){
            for(Car_Offer__c exco : existingCarOffers){
                 if (co.Vehicle__c == exco.Vehicle__c){                       
                    co.addError('Vehicle is already available in ' + exco.Dealership__r.Name + '. Vehicle can have only one physical offer');
                }                 
            }
            existingCarOffers.add(co);            
        }
        
    }
}
