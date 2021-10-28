@isTest
public  class CreateRelationshipMapTest {
    @isTest
    public static void CreateRelationshipMapTest() {
        for (Integer i = 0; i < 2; i++) {
            Account testAccount = new Account(
                Name = 'Test Account ' + i
            );
            insert testAccount;
            for (Integer j = 0; j <= i; j++) {
                Contact testContact = new Contact(
                    LastName = 'Test Contact' + j,
                    AccountId = testAccount.Id
                );
                insert testContact;    
            }
        }

        Test.startTest();
        Map<Id,List<Contact>> getValueFromClass = CreateRelationshipMap.createRelationshipMap();
        Test.stopTest();
        Account testAccount1 = [SELECT Name FROM Account WHERE Name = 'Test Account 1' LIMIT 1];
        System.assertEquals(false, getValueFromClass.isEmpty(), 'Map is empty');
        System.assertEquals(2, getValueFromClass.get(testAccount1.Id).size(), 'Values correspond to the key');
    }
}
