@isTest
public class nightlyJobCreateWeatherTrackTest {
    @isTest
    public static void nightlyJobCreateWeatherTrackTest() {
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingCity = 'Mountain View'
        );
        insert testAccount;
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('dataWeatherForTest');
        mock.setStatusCode(200);                
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        System.schedule('testBasicScheduledApex',CRON_EXP, new nightlyJobCreateWeatherTrack());
        Test.stopTest();

        List<Weather_Track__c> testListTrack = [SELECT Name FROM Weather_Track__c WHERE AccountId__c = :testAccount.Id];

        System.assertEquals(false, testListTrack.isEmpty(), 'Not create track');

    }
}
