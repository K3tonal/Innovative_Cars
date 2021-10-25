
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
        
        List<Id> vehicleIdList = getPhysicalVehiclesIdFromCarOffer(carOffersFromTrigger);
        
        List<Car_Offer__c> existingCarOffers = [SELECT id, Offer_Type__c, Vehicle__r.id, Dealership__r.Name FROM Car_Offer__c WHERE Vehicle__r.Id IN :vehicleIdList];       

        for(Car_Offer__c carOffer : carOffersFromTrigger){
            for(Car_Offer__c exCarOffer : existingCarOffers){
                 if (carOffer.Offer_Type__c =='physical' && carOffer.Vehicle__c == exCarOffer.Vehicle__c){                       
                    carOffer.addError(System.label.VEHICLE_ALREADY_AVAILABLE + exCarOffer.Dealership__r.Name + System.label.VEHICLE_ONE_PHYSICAL_OFFER);
                }                 
            }
            existingCarOffers.add(carOffer);            
        }        
    }

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method extracts list of Physical Vehicle Id  
     * *                from carOffers
     * *  @Task: POX-1 
     * *  @param carOffers List of car offer
     * *  @return List of Vehicle Ids
     * */
    private List<Id> getPhysicalVehiclesIdFromCarOffer(List<Car_Offer__c> carOffers){
        List<Id> vehicleIdList = new List<Id>();
        for(Car_Offer__c carOffer : carOffers) {
            if(carOffer.Offer_Type__c == 'physical'){
                vehicleIdList.add(carOffer.Vehicle__c);
            }           
        } 
        return vehicleIdList;
    }

     /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method extracts data from Trigger and preper to send 
     * *                to async sendEmail
     * *  @Task: POX-1 
     * *  @param carOffersFromTrigger List of car offer from trigger
     * */
    public void sendEmailConfirmation(Map<Id,Car_Offer__c> carOffersFromTrigger){
              
        List<Id> carOfferIds = new List<Id>(carOffersFromTrigger.keySet());        
        sendEmail(carOfferIds);
    }

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Async method to send email 
     * *                
     * *  @Task: POX-1 
     * *  @param carOffersId List of CarOffer Ids.
     * */
    @future
     public static void sendEmail(List<Id> carOffersId){
        
        List<Car_Offer__c> carOffers = [SELECT Id, Name FROM Car_Offer__c WHERE Id IN: carOffersId];
        List<String> offerName = new List<String>();
        for(Car_Offer__c c: carOffers ){
            offerName.add(c.Name);
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {'jivepow140@forfity.com'};
        message.subject = System.label.NEW_CARS_HAS_BEEN_ADDED;
        message.plainTextBody = System.label.NEW_CARS_HAS_BEEN_ADDED + ': ' + offerName;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};        

        try{
            Messaging.sendEmail(messages);
    
        } catch (EmailException ex){
            System.debug(System.label.ENCOUNTERED_AN_ERROR + ex);
        }             
     }
}
