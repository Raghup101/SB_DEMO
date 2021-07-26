public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
  }

  //Added COmment for OR-256
  //DROP1 Bug Fixed SP17_DROP1_BugFIX
}