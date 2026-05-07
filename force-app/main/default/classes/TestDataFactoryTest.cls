/**
 * TestDataFactoryTest
 *
 * Unit tests for the TestDataFactory class, verifying that all factory methods
 * produce records with the expected field values.
 */
@isTest
private class TestDataFactoryTest {

    @isTest
    static void testCreateAccount() {
        Account acc = TestDataFactory.createAccount('Acme Corp', false);

        System.assertNotEquals(null, acc, 'Account should not be null');
        System.assertEquals('Acme Corp', acc.Name, 'Account name should match');
        System.assertEquals('555-0100', acc.Phone, 'Account phone should match');
        System.assertEquals('San Francisco', acc.BillingCity, 'Billing city should match');
        System.assertEquals(null, acc.Id, 'Account should not be inserted');
    }

    @isTest
    static void testCreateAccountWithInsert() {
        Account acc = TestDataFactory.createAccount('Inserted Corp', true);

        System.assertNotEquals(null, acc.Id, 'Account should have an Id after insert');
        System.assertEquals('Inserted Corp', acc.Name, 'Account name should match');
    }

    @isTest
    static void testCreateAccounts() {
        Integer count = 5;
        List<Account> accounts = TestDataFactory.createAccounts(count, false);

        System.assertEquals(count, accounts.size(), 'Should create the correct number of accounts');
        for (Integer i = 0; i < count; i++) {
            System.assertEquals('Test Account ' + i, accounts[i].Name, 'Account name should match index');
            System.assertEquals(null, accounts[i].Id, 'Accounts should not be inserted');
        }
    }

    @isTest
    static void testCreateAccountsWithInsert() {
        Integer count = 3;
        List<Account> accounts = TestDataFactory.createAccounts(count, true);

        System.assertEquals(count, accounts.size(), 'Should create the correct number of accounts');
        for (Account acc : accounts) {
            System.assertNotEquals(null, acc.Id, 'Each account should have an Id after insert');
        }
    }

    @isTest
    static void testCreateContact() {
        Account acc = TestDataFactory.createAccount('Contact Parent', true);
        Contact con = TestDataFactory.createContact('John', 'Doe', acc.Id, false);

        System.assertNotEquals(null, con, 'Contact should not be null');
        System.assertEquals('John', con.FirstName, 'First name should match');
        System.assertEquals('Doe', con.LastName, 'Last name should match');
        System.assertEquals('john.doe@example.com', con.Email, 'Email should be derived from name');
        System.assertEquals(acc.Id, con.AccountId, 'AccountId should be set');
        System.assertEquals(null, con.Id, 'Contact should not be inserted');
    }

    @isTest
    static void testCreateContactWithInsert() {
        Account acc = TestDataFactory.createAccount('Contact Parent', true);
        Contact con = TestDataFactory.createContact('Jane', 'Smith', acc.Id, true);

        System.assertNotEquals(null, con.Id, 'Contact should have an Id after insert');
        System.assertEquals('Jane', con.FirstName, 'First name should match');
    }

    @isTest
    static void testCreateContacts() {
        Account acc = TestDataFactory.createAccount('Bulk Contact Account', true);
        Integer count = 4;
        List<Contact> contacts = TestDataFactory.createContacts(count, acc.Id, false);

        System.assertEquals(count, contacts.size(), 'Should create the correct number of contacts');
        for (Integer i = 0; i < count; i++) {
            System.assertEquals('First' + i, contacts[i].FirstName, 'First name should match index');
            System.assertEquals('Last' + i, contacts[i].LastName, 'Last name should match index');
            System.assertEquals('contact' + i + '@example.com', contacts[i].Email, 'Email should match index');
            System.assertEquals(acc.Id, contacts[i].AccountId, 'AccountId should be set');
        }
    }

    @isTest
    static void testCreateContactsWithInsert() {
        Account acc = TestDataFactory.createAccount('Bulk Contact Account', true);
        Integer count = 2;
        List<Contact> contacts = TestDataFactory.createContacts(count, acc.Id, true);

        System.assertEquals(count, contacts.size(), 'Should create the correct number of contacts');
        for (Contact con : contacts) {
            System.assertNotEquals(null, con.Id, 'Each contact should have an Id after insert');
        }
    }

    @isTest
    static void testCreateOpportunity() {
        Account acc = TestDataFactory.createAccount('Opp Account', true);
        Date closeDate = Date.today().addDays(30);
        Opportunity opp = TestDataFactory.createOpportunity('Big Deal', acc.Id, 'Prospecting', closeDate, false);

        System.assertNotEquals(null, opp, 'Opportunity should not be null');
        System.assertEquals('Big Deal', opp.Name, 'Opportunity name should match');
        System.assertEquals(acc.Id, opp.AccountId, 'AccountId should be set');
        System.assertEquals('Prospecting', opp.StageName, 'Stage should match');
        System.assertEquals(closeDate, opp.CloseDate, 'Close date should match');
        System.assertEquals(10000, opp.Amount, 'Amount should match');
        System.assertEquals(null, opp.Id, 'Opportunity should not be inserted');
    }

    @isTest
    static void testCreateOpportunityWithInsert() {
        Account acc = TestDataFactory.createAccount('Opp Account', true);
        Opportunity opp = TestDataFactory.createOpportunity('Inserted Deal', acc.Id, 'Prospecting', Date.today().addDays(30), true);

        System.assertNotEquals(null, opp.Id, 'Opportunity should have an Id after insert');
        System.assertEquals('Inserted Deal', opp.Name, 'Opportunity name should match');
    }

    @isTest
    static void testCreateOpportunities() {
        Account acc = TestDataFactory.createAccount('Bulk Opp Account', true);
        Integer count = 3;
        List<Opportunity> opps = TestDataFactory.createOpportunities(count, acc.Id, false);

        System.assertEquals(count, opps.size(), 'Should create the correct number of opportunities');
        for (Integer i = 0; i < count; i++) {
            System.assertEquals('Test Opportunity ' + i, opps[i].Name, 'Opportunity name should match index');
            System.assertEquals(acc.Id, opps[i].AccountId, 'AccountId should be set');
            System.assertEquals('Prospecting', opps[i].StageName, 'Stage should be Prospecting');
            System.assertEquals((i + 1) * 1000, opps[i].Amount, 'Amount should scale with index');
        }
    }

    @isTest
    static void testCreateOpportunitiesWithInsert() {
        Account acc = TestDataFactory.createAccount('Bulk Opp Account', true);
        Integer count = 2;
        List<Opportunity> opps = TestDataFactory.createOpportunities(count, acc.Id, true);

        System.assertEquals(count, opps.size(), 'Should create the correct number of opportunities');
        for (Opportunity opp : opps) {
            System.assertNotEquals(null, opp.Id, 'Each opportunity should have an Id after insert');
        }
    }

    @isTest
    static void testCreateLead() {
        Lead ld = TestDataFactory.createLead('Alice', 'Brown', 'Acme', false);

        System.assertNotEquals(null, ld, 'Lead should not be null');
        System.assertEquals('Alice', ld.FirstName, 'First name should match');
        System.assertEquals('Brown', ld.LastName, 'Last name should match');
        System.assertEquals('Acme', ld.Company, 'Company should match');
        System.assertEquals('alice.brown@example.com', ld.Email, 'Email should be derived from name');
        System.assertEquals('Open - Not Contacted', ld.Status, 'Status should match default');
        System.assertEquals(null, ld.Id, 'Lead should not be inserted');
    }

    @isTest
    static void testCreateLeadWithInsert() {
        Lead ld = TestDataFactory.createLead('Bob', 'Green', 'BigCo', true);

        System.assertNotEquals(null, ld.Id, 'Lead should have an Id after insert');
        System.assertEquals('Bob', ld.FirstName, 'First name should match');
        System.assertEquals('BigCo', ld.Company, 'Company should match');
    }
}
