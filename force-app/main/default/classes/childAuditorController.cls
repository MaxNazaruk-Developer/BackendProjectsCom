public class childAuditorController {
    public class objectRelationship {
        public String relationshipName;
        public Integer quantity;
    }

    @AuraEnabled(cacheable=true)
    public static String getRelationshipObject(String nameObject, String idObject) {
        List<objectRelationship> listRelationshipObject = new List<objectRelationship>();
        for (Schema.ChildRelationship childRelationship : Schema.getGlobalDescribe().get(nameObject).getDescribe().getChildRelationships()) {                
            if (childRelationship.getRelationshipName () != null && childRelationship.getChildSObject().getDescribe().isSearchable() == true) {         
                String forQueryDatabase = 'SELECT Id,(SELECT Id FROM ' + childRelationship.getRelationshipName() + ') ' + 'FROM ' + nameObject + ' WHERE Id = :idObject';                        
                for (SObject variable2 : Database.Query(forQueryDatabase)) {                    
                    if (variable2.getSObjects(childRelationship.getRelationshipName()) != null) {                        
                        objectRelationship relationshipObject = new objectRelationship();
                        relationshipObject.relationshipName = childRelationship.getRelationshipName();
                        relationshipObject.quantity = variable2.getSObjects(childRelationship.getRelationshipName()).size();
                        listRelationshipObject.add(relationshipObject);
                    }
                }
            }                                
        }
        return JSON.serialize(listRelationshipObject);  
    }
}
