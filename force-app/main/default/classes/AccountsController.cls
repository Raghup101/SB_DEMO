public class AccountsController {

    @AuraEnabled
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Industry FROM Account];
    }
}