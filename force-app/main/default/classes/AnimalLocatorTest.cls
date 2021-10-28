@isTest
public class AnimalLocatorTest{
    @isTest 
    public static  void AnimalLocatorMock1() {
        Test.SetMock(HttpCallOutMock.class, new AnimalLocatorMock());
        string result=AnimalLocator.getAnimalNameById(1);
        string expectedResult='chicken';
        System.assertEquals(result, expectedResult);
    }
}
