@isTest
public class createCaseFromEmailTest{    
    @isTest    
    public static void emptyLetterNoAccountTest() {    
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        email.fromAddress = 'ilovenagpur@gmail.com'; 
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();          
        env.fromAddress = 'ilovenagpur@gmail.com';    
        createCaseFromEmail creatCase = new createCaseFromEmail();
        creatCase.handleInboundEmail(email, env );
    }
    
    @IsTest
    public static void emptyLetterAvailableAccountTest(){
        Account testAccount = new Account(
            Name = 'Test Account',
            Email__c = 'ilovenagpur@gmail.com'
        );
        insert testAccount;
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        email.fromAddress = 'ilovenagpur@gmail.com'; 
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();          
        env.fromAddress = 'ilovenagpur@gmail.com';    
        createCaseFromEmail creatCase = new createCaseFromEmail();
        creatCase.handleInboundEmail(email, env );        
    }

    @IsTest
    public static void availableTripAvailableAccountTest(){
        Account testAccount = new Account(
            Name = 'Test Account',
            Email__c = 'ilovenagpur@gmail.com'
        );
        insert testAccount;
        Trip__c testTrip = new Trip__c(
            name = 'Test Trip',
            AccountId__c = testAccount.Id
        );
        insert testTrip;
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        email.fromAddress = 'ilovenagpur@gmail.com'; 
        email.plainTextBody = '[T#' + testTrip.Id + ']';
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();          
        env.fromAddress = 'ilovenagpur@gmail.com';                
        createCaseFromEmail creatCase = new createCaseFromEmail();
        creatCase.handleInboundEmail(email, env );        
    }
}