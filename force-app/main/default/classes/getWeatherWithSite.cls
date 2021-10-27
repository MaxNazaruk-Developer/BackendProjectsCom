public with sharing class getWeatherWithSite {
    @future(callout=true)
    public static void getDataWeather(String cityName, String idAccount) {
        HttpRequest req = new HttpRequest();
        String urlAdressReq = 'https://api.openweathermap.org/data/2.5/weather?q=' + cityName + '&appid=2b7871e974836d5dafe3aff097e7c722';
        req.setEndpoint(urlAdressReq);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse response = http.send(req);       

        if(response.getStatusCode() == 200) {            
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());                   
            Map<String, Object> main = (Map<String, Object>) results.get('main');
            List<Object> listWeather = (List<Object>) results.get('weather');
            Map<String, Object> weather = (Map<String, Object>) listWeather[0];            
            Weather_Track__c newTrack = new Weather_Track__c();
            newTrack.Name = 'Track in ' + cityName;                  
            newTrack.Temp_C__c = (Integer) JSON.deserialize(JSON.serialize(main.get('temp')), Integer.class) - 273;
            newTrack.Humidity__c = (Integer) JSON.deserialize(JSON.serialize(main.get('humidity')), Integer.class);
            newTrack.Pressure__c = (Integer) JSON.deserialize(JSON.serialize(main.get('pressure')), Integer.class);
            newTrack.Description__c = (String) JSON.deserialize(JSON.serialize(weather.get('description')), String.class);
            newTrack.AccountId__c = idAccount;            
            insert newTrack;            
        }
    }        
}
