//Map<Id,Vehicle__c> map = new Map<Id,Vehicle__c>([SELECT Id FROM Vehicle__c WHERE VIN__c = 'TestVIN']);

//List<Vehicle__c> vehicle = [SELECT Id, VIN__c FROM Vehicle__c WHERE VIN__c = 'TestVIN'];

//System.debug(vehicle);

// Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
// message.toAddresses = new String[] { 'jivepow140@forfity.com'};
// message.optOutPolicy = 'FILTER';
// message.subject = 'Test';
// message.plainTextBody = 'This is the message body.';
// Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
// Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

// if (results[0].success) 
// {
//     System.debug('The email was sent successfully.');
// } else 
// {
//     System.debug('The email failed to send: ' + results[0].errors[0].message);
// }

        // List<Dealership__c> dealerships = CarOfferDataFactory.createDealersWithAccount(2);
        // insert dealerships;

        // Vehicle__c vehicle = new Vehicle__c(Brand__c='Test Vehicle', Model__c = 'Test Model', Vin__c = 'TestVIN');
        // Vehicle__c vehicle1 = new Vehicle__c(Brand__c='Test Vehicle1', Model__c = 'Test Model', Vin__c = 'TestVIN');

        // insert vehicle;
        // insert vehicle1;
        // List<Car_Offer__c> carOfferList = new List<Car_Offer__c>();
        //  Car_Offer__c carOffer = new Car_Offer__c(Vehicle__c=vehicle.id, Dealership__c = dealerships.get(0).Id, Offer_Type__c='virtual');
        //  Car_Offer__c carOffer2 = new Car_Offer__c(Vehicle__c=vehicle1.id, Dealership__c = dealerships.get(1).Id, Offer_Type__c='virtual');
        //  carOfferList.add(carOffer);
        //  carOfferList.add(carOFfer2);
         
        //  insert carOfferList;


        // ClearTelemetryData myBatchObject = new ClearTelemetryData();
        // Id batchId = Database.executeBatch(myBatchObject);
        
        //AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId ]
        //System.debug('#######################' +job);

        
                //new Case(Origin='Web', Dealership__c = dealer.Id ,Reason='renovation')

        Dealership__c dealer = [SELECT Id, Status__c FROM Dealership__c WHERE Id = 'a017R00003x4dD5QAI'];
        dealer.Status__c = 'closed';
        update dealer;

        // REQUIRED_FIELD_MISSING, Required fields are missing: [Street__c, Number__c, City__c, Dealership_Type__c, Account__c]: [Street__c, Number__c, City__c, Dealership_Type__c, Account__c]