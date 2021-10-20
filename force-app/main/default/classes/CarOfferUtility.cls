
/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Car Offer Utility Class
* *  @Task: POX-1 
* */
public with sharing class CarOfferUtility {

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method iterate over Car_Offer List and return error  
     * *  for vehicle that already has physical offer.
     * *  @Task: POX-1 
     * *  @param carOffersFromTrigger List from Trigger.new
     * */
    public void validateOnlyOnePhysicalOffer(List<Car_Offer__c> carOffersFromTrigger) {

        
        List<Id> vehicleIdList = new List<Id>();
        for(Car_Offer__c carOffer : carOffersFromTrigger){
            if(carOffer.Offer_Type__c == 'physical'){
                vehicleIdList.add(carOffer.Vehicle__c);
            }           
        } 
        
        List<Car_Offer__c> existingCarOffers = [SELECT id, Offer_Type__c, Vehicle__r.id, Dealership__r.Name FROM Car_Offer__c WHERE Vehicle__r.Id IN :vehicleIdList];
       

        for(Car_Offer__c carOffer : carOffersFromTrigger){
            for(Car_Offer__c exCarOffer : existingCarOffers){
                 if (carOffer.Vehicle__c == exCarOffer.Vehicle__c){                       
                    carOffer.addError(System.label.VEHICLE_ALREADY_AVAILABLE + exCarOffer.Dealership__r.Name + System.label.VEHICLE_ONE_PHYSICAL_OFFER);
                }                 
            }
            existingCarOffers.add(carOffer);            
        }
        
    }
}
