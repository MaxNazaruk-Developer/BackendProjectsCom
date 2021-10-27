@isTest
public class getWeatherWithSiteTest {
    @isTest
    public static void getWeatherWithSitePositiveTest() {
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingCity = 'Mountain View'
        );        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('dataWeatherForTest');
        mock.setStatusCode(200);                
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        insert testAccount;
        Test.stopTest();       
        
        List<Weather_Track__c> testTreck = [SELECT Name FROM Weather_Track__c WHERE AccountId__c = :testAccount.Id];

        System.assertEquals(false, testTreck.isEmpty(), 'Does not create an object track');
        System.assertEquals('Track in Mountain View', testTreck[0].Name, 'Wrong object name');
    }

    @IsTest
    public static void getWeatherWithSiteNigativTest(){
        Account testAccount = new Account(
            Name = 'Test Account'            
        ); 
        insert testAccount;        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('dataWeatherForTest');
        mock.setStatusCode(200);                
        Test.setMock(HttpCalloutMock.class, mock);
        Account editCityAccount = [SELECT BillingCity FROM Account WHERE Id =:testAccount.Id LIMIT 1];
        editCityAccount.BillingCity = 'Mountain View';        

        Test.startTest();
        update editCityAccount;
        Test.stopTest();

        List<Weather_Track__c> testTreck = [SELECT Name FROM Weather_Track__c WHERE Name = 'Track in Mountain View'];

        System.assertEquals(false, testTreck.isEmpty(), 'Does not create an object track');                
    }
}
