public class CreateRelationshipMap {
    public static Map<Id,List<Contact>> createRelationshipMap() {
        List<Account> listAllAccountWithOrg = [SELECT Name,(SELECT Name FROM Contacts) FROM Account LIMIT 90];
        Map<Id,List<Contact>> mapAllAccountAndRelationgshipContacts = new Map<Id,List<Contact>>(); 
        for (Account accountWithOrg : listAllAccountWithOrg) {
            mapAllAccountAndRelationgshipContacts.put(accountWithOrg.Id, accountWithOrg.getSObjects('Contacts'));
        }
        return mapAllAccountAndRelationgshipContacts;
    }
}
