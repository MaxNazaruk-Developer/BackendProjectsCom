public class nightlyJobCreateWeatherTrack implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Account> listAccountNotEmptyFieldCity = [
            SELECT Name,BillingCity,(
                    SELECT Name
                    FROM Weather_Tracks__r
                	WHERE Date__c = TODAY
                ) 
            FROM Account 
            WHERE BillingCity != null
        ];
        for (Account AccountNotEmptyFieldCity : listAccountNotEmptyFieldCity) {
            if (AccountNotEmptyFieldCity.getSObjects('Weather_Tracks__r') == null) {
                getWeatherWithSite.getDataWeather(AccountNotEmptyFieldCity.BillingCity, AccountNotEmptyFieldCity.Id);                
            }
        }       
    }
}
