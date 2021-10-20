trigger CarOfferTrigger on Car_Offer__c (before insert, before update) {
    
    if (Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            System.debug('################inside trigger: ' + Trigger.new);
            CarOfferUtility carOfferUtil = new CarOfferUtility();    
            carOfferUtil.validateOnlyOnePhysicalOffer(Trigger.new);

        }
    }
}