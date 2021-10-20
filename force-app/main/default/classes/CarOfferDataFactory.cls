/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Vehicle Data Factory Class
* *  @Task: POX-1 
* */
public with sharing class CarOfferDataFactory {
    
    /** * @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
     * *  @description Method creates List of Vehicles and associated Telemetry records
     * *  based on given ammounts
     * *  @Task: POX-1 
     * *  @param numberOfDealers Number of Dealers to create
     * *  @return list of Dealershipp
     * */
    public static List<Dealership__c> createDealersWithAccount(Integer numberOfDealers){
        
        Integer randomNumber = Integer.valueof((Math.random() * 1000));
        Account acc = new Account(Name='Test Account' + randomNumber);    
        insert acc;

        List<Dealership__c> dealerships = new List<Dealership__c>();

        for(Integer i = 0; i < numberOfDealers; i++){

            dealerships.add(new Dealership__c(Name='Test Dealer' +i,
                                Name__c='Test Dealer' +i, 
                                Street__c = 'TestStreet' +1, 
                                Number__c= i, City__c='TestCity'+1, 
                                Dealership_Type__c='Passenger vehicle', 
                                Account__c = acc.Id));
        }
        
        return dealerships;
    }
}
