@isTest
public with sharing class showAllTripThisCustomerControllerTest {
    @isTest
    public static void getTripsTest() {
        Account testAccunt = new Account(
            Name = 'Test Account'
        );
        insert testAccunt;
        Trip__c testTrip = new Trip__c(
                    Name = 'Test Trip',
                    AccountId__c = testAccunt.Id
                );
        insert testTrip;
        Case testCase = new Case(
            Status = 'New',
            Origin = 'Email',           
            AccountId = testAccunt.Id            
        );
        insert testCase;

        Test.startTest();
        String resultMethod = showAllTripThisCustomerController.getTrips(testCase.Id);
        Test.stopTest();

        System.assertEquals(resultMethod.contains('Test Trip'), true, 'Trip not found');
    }
}
