public class showAllTripThisCustomerController {
    @AuraEnabled 
    public static String getTrips(String idCase) {              
        List<Case> getCase = [
            SELECT AccountId 
            FROM Case 
            WHERE Id = :idCase 
            LIMIT 1
        ];        
        List<Trip__c> getTrips = [
            SELECT Name,AccountId__c,CreatedDate 
            FROM Trip__c 
            WHERE AccountId__c = :getCase[0].AccountId
            LIMIT 90            
        ];        
        return JSON.serialize(getTrips);
    }
}