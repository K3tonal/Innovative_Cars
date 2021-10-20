/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Test Class for Car Offer 
* *  @Task: POX-1 
* */
@isTest
public with sharing class CarOfferTest {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Test method for creating physical Car_Offer 
     * *  for vehicle that already has physical offer
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest
    static void testTwoPhysicalOfferForSameVehicle(){
       
        List<Dealership__c> dealerships = CarOfferDataFactory.createDealersWithAccount(2);
        insert dealerships;

        Vehicle__c vehicle = new Vehicle__c(Brand__c='Test Vehicle', Model__c = 'Test Model', Vin__c = 'TestVIN');
        insert vehicle;

        Boolean exceptionThrown = false;
        
        for(Dealership__c dealer : dealerships){
                        
            Car_Offer__c carOffer = new Car_Offer__c(Vehicle__c=vehicle.id, Dealership__c = dealer.Id, Offer_Type__c='physical');            
            try{
                insert carOffer;
            } catch(Exception ex) {
                exceptionThrown = true;
                Boolean expectedExceptionThrown =  (ex.getMessage().contains('Vehicle is already available in')) ? true : false;
                System.AssertEquals(true, expectedExceptionThrown, ex.getMessage()); 
            }               
        }
        System.assertEquals(true, exceptionThrown, 'No exception was thrown'); 
    }
          

    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Test method for creating physical Car_Offer 
     * *  for vehicle that already has physical offer
     * *  @Task: POX-1 
     * *  @param 
     * */
    @isTest
    static void testTwoPhysicalOfferPassAsList(){
       
       List<Dealership__c> dealerships = CarOfferDataFactory.createDealersWithAccount(2);
       insert dealerships;
       

       Vehicle__c vehicle = new Vehicle__c(Brand__c='Test Vehicle', Model__c = 'Test Model', Vin__c = 'TestVIN');
       insert vehicle;

       List<Car_Offer__c> carOffers = new List<Car_Offer__c> {
           new Car_Offer__c(Vehicle__c = vehicle.Id, Dealership__c = dealerships.get(0).Id, Offer_Type__c = 'physical'),
           new Car_Offer__c(Vehicle__c = vehicle.Id, Dealership__c = dealerships.get(1).Id, Offer_Type__c = 'physical')
       };
       
       try {            
            Database.insert(carOffers, true);        
            System.assert(False, 'No exception');
       } catch (Exception ex) {
            System.assert(ex.getMessage().contains('Vehicle is already available in'));
       }     
       
   }
}
