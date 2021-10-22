global class createCaseFromEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {    
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String fromAdressEmail = email.fromAddress;
        String textEmail = String.isEmpty(email.plainTextBody) ? '' : email.plainTextBody;        
        String valueTrip;
        String valueAccountId;       
        String nameCustomerEmail = String.isEmpty(email.fromName) ? 'New Account for Trip' : email.fromName;
        String tripId = textEmail.substringBetween('[T#',']');
        
        if (!String.isEmpty(tripId)) {
            List<Trip__c> searchTrip = [SELECT Name,AccountId__c FROM Trip__c WHERE Id = :tripId LIMIT 1];
            List<Account> searchAccount = [SELECT Name FROM Account WHERE Id = :searchTrip[0].AccountId__c LIMIT 1];
            valueTrip = searchTrip[0].Id;
            valueAccountId = searchAccount[0].Id;          
        } else {
            List<Account> searchAccount = [SELECT Name FROM Account WHERE Email__c = :fromAdressEmail LIMIT 1];
            if (searchAccount.size() == 0) {
                Account newAccount = new Account(
                    Name = nameCustomerEmail,
                    Email__c = fromAdressEmail
                );
                insert newAccount;
                Trip__c newTrip = new Trip__c(
                    Name = 'New Trip',
                    AccountId__c = newAccount.Id
                );
                insert newTrip;           
                valueTrip = newTrip.Id;               
                valueAccountId = newAccount.Id;
            } else {
                Trip__c newTrip = new Trip__c(
                    Name = 'New Trip',
                    AccountId__c = searchAccount[0].Id
                );
                insert newTrip;           
                valueTrip = newTrip.Id;
                valueAccountId = searchAccount[0].Id;
            }                        
        }        
        Case caseCreateFromEmail = new Case(
            Status = 'New',
            Origin = 'Email',
            TripId__c = valueTrip,
            AccountId = valueAccountId            
        );
        insert caseCreateFromEmail;

        result.success = true;       
        return result;
    }    
}
