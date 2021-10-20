/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Trigger class for Car Offer 
* *  @Task: POX-1 
* */
trigger CarOfferTrigger on Car_Offer__c (before insert, before update) {
    
    if (Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            CarOfferUtility carOfferUtil = new CarOfferUtility();    
            carOfferUtil.validateOnlyOnePhysicalOffer(Trigger.new);

        }
    }
}