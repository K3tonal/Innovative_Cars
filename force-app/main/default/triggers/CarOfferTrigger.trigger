/*   @author name <wojciech.krasowski@accenture.com> * @date 18/10/2021 * 
* *  @description Trigger class for Car Offer 
* *  @Task: POX-1 
* */
trigger CarOfferTrigger on Car_Offer__c (before insert, before update, after insert) {
    CarOfferUtility carOfferUtil = new CarOfferUtility();
    if (Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){                
            carOfferUtil.validateOnlyOnePhysicalOffer(Trigger.new);
        }
    } 
    else if(Trigger.isAfter) {
        if(Trigger.isInsert){            
            carOfferUtil.sendEmailConfirmation(Trigger.new);
        }
    }
}