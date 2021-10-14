public with sharing class getObjectController {
    @AuraEnabled(cacheable=true) 
    public static String getObject(){
        Map<String, Schema.SObjectType> getAllObjectWithOrg = Schema.getGlobalDescribe(); //Получаю колекцию ключей значений имен всех обьектов
        List<dataObject> arraySelectObject = new List<dataObject>();
        for (String nameObjcet : getAllObjectWithOrg.keySet()) { //перебераю имена обьектов            
            SObjectType oneObject = Schema.getGlobalDescribe().get(nameObjcet); //поиск обьекта по его имени                       
            Schema.DescribeSObjectResult objectDescription = oneObject.getDescribe(); // Получаю его свойства 
             
            if(objectDescription.isSearchable() == true) {
                dataObject wrapperObj=new dataObject();
                wrapperObj.lable = objectDescription.getLabel();
                wrapperObj.value = objectDescription.getName();                               
                arraySelectObject.add(wrapperObj);                               
            }
        }        
        String dataObjectForCombobox = JSON.serialize(arraySelectObject);              
        return dataObjectForCombobox;               
    }

    public class dataObject{        
        public String lable;
        public String value;
    }
}