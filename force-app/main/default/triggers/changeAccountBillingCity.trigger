trigger changeAccountBillingCity on Account (after insert, after update) {          
    for(Account editAccount : Trigger.New) {
        if(Trigger.isInsert) {            
            String billingCity = editAccount.BillingCity;
            String idAccount = editAccount.Id;            
            getWeatherWithSite.getDataWeather(billingCity, idAccount);
        } else if(Trigger.isUpdate) {
            String billingCity = editAccount.BillingCity;
            String idAccount = editAccount.Id;
            for (Account oldAccount : Trigger.old) {
                if(oldAccount.Id ==  idAccount) {
                    if(billingCity != oldAccount.BillingCity) {
                        getWeatherWithSite.getDataWeather(billingCity, idAccount);                                    
                    }
                }
            }           
        }        
    }
}