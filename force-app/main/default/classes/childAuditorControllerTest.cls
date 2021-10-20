@isTest
public with sharing class childAuditorControllerTest {
    @isTest
    public static void childAuditorControllerTest() {                
        Account testAccount = new Account(
            Name = 'TestAcc'            
        );
        insert testAccount;
        Contact contactTest = new Contact(
            LastName = 'testCon',
            FirstName = 'TestFirstName',
            AccountId = testAccount.Id
        );                      
        insert contactTest;
        Test.startTest();
            String resultConroller = childAuditorController.getRelationshipObject('Account', String.valueOf(testAccount.Id));
        Test.stopTest();            
        System.assertEquals(resultConroller.contains('Contacts'), true);
        System.assertEquals(resultConroller.contains('1'), true);        
    }
}
