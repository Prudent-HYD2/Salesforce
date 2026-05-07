/**
 * TestDataFactory
 *
 * Utility class for creating test records in Apex tests.
 * All methods create and return records without inserting them
 * unless the insert parameter is set to true.
 */
@isTest
public class TestDataFactory {

    /**
     * Creates a single Account record.
     *
     * @param name   The name for the Account.
     * @param doInsert  Whether to insert the record into the database.
     * @return The created Account.
     */
    public static Account createAccount(String name, Boolean doInsert) {
        Account acc = new Account(
            Name = name,
            Phone = '555-0100',
            BillingStreet = '123 Main St',
            BillingCity = 'San Francisco',
            BillingState = 'CA',
            BillingPostalCode = '94105',
            BillingCountry = 'US'
        );
        if (doInsert) {
            insert acc;
        }
        return acc;
    }

    /**
     * Creates multiple Account records.
     *
     * @param count     The number of accounts to create.
     * @param doInsert  Whether to insert the records into the database.
     * @return List of created Accounts.
     */
    public static List<Account> createAccounts(Integer count, Boolean doInsert) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                Phone = '555-010' + i,
                BillingCity = 'San Francisco',
                BillingState = 'CA',
                BillingCountry = 'US'
            ));
        }
        if (doInsert) {
            insert accounts;
        }
        return accounts;
    }

    /**
     * Creates a single Contact record linked to an Account.
     *
     * @param firstName The first name of the Contact.
     * @param lastName  The last name of the Contact.
     * @param accountId The Id of the parent Account (can be null).
     * @param doInsert  Whether to insert the record into the database.
     * @return The created Contact.
     */
    public static Contact createContact(String firstName, String lastName, Id accountId, Boolean doInsert) {
        Contact con = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = firstName.toLowerCase() + '.' + lastName.toLowerCase() + '@example.com',
            Phone = '555-0200',
            AccountId = accountId
        );
        if (doInsert) {
            insert con;
        }
        return con;
    }

    /**
     * Creates multiple Contact records linked to an Account.
     *
     * @param count     The number of contacts to create.
     * @param accountId The Id of the parent Account.
     * @param doInsert  Whether to insert the records into the database.
     * @return List of created Contacts.
     */
    public static List<Contact> createContacts(Integer count, Id accountId, Boolean doInsert) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < count; i++) {
            contacts.add(new Contact(
                FirstName = 'First' + i,
                LastName = 'Last' + i,
                Email = 'contact' + i + '@example.com',
                AccountId = accountId
            ));
        }
        if (doInsert) {
            insert contacts;
        }
        return contacts;
    }

    /**
     * Creates a single Opportunity record linked to an Account.
     *
     * @param name      The name of the Opportunity.
     * @param accountId The Id of the parent Account.
     * @param stage     The stage name (e.g. 'Prospecting').
     * @param closeDate The close date for the Opportunity.
     * @param doInsert  Whether to insert the record into the database.
     * @return The created Opportunity.
     */
    public static Opportunity createOpportunity(String name, Id accountId, String stage, Date closeDate, Boolean doInsert) {
        Opportunity opp = new Opportunity(
            Name = name,
            AccountId = accountId,
            StageName = stage,
            CloseDate = closeDate,
            Amount = 10000
        );
        if (doInsert) {
            insert opp;
        }
        return opp;
    }

    /**
     * Creates multiple Opportunity records linked to an Account.
     *
     * @param count     The number of opportunities to create.
     * @param accountId The Id of the parent Account.
     * @param doInsert  Whether to insert the records into the database.
     * @return List of created Opportunities.
     */
    public static List<Opportunity> createOpportunities(Integer count, Id accountId, Boolean doInsert) {
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < count; i++) {
            opps.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                AccountId = accountId,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30 + i),
                Amount = (i + 1) * 1000
            ));
        }
        if (doInsert) {
            insert opps;
        }
        return opps;
    }

    /**
     * Creates a single Lead record.
     *
     * @param firstName The first name of the Lead.
     * @param lastName  The last name of the Lead.
     * @param company   The company name for the Lead.
     * @param doInsert  Whether to insert the record into the database.
     * @return The created Lead.
     */
    public static Lead createLead(String firstName, String lastName, String company, Boolean doInsert) {
        Lead ld = new Lead(
            FirstName = firstName,
            LastName = lastName,
            Company = company,
            Email = firstName.toLowerCase() + '.' + lastName.toLowerCase() + '@example.com',
            Phone = '555-0300',
            Status = 'Open - Not Contacted'
        );
        if (doInsert) {
            insert ld;
        }
        return ld;
    }
}
