# Salesforce

A Salesforce DX project with test data utilities for Apex development.

## Project Structure

```
force-app/
└── main/
    └── default/
        └── classes/
            ├── TestDataFactory.cls          # Utility class for creating test records
            ├── TestDataFactory.cls-meta.xml
            ├── TestDataFactoryTest.cls      # Unit tests for TestDataFactory
            └── TestDataFactoryTest.cls-meta.xml
```

## TestDataFactory

`TestDataFactory` is an `@isTest` utility class that provides helper methods for creating standard Salesforce records in unit tests. It supports creating records in memory (without DML) or inserting them directly into the database.

### Supported Objects

| Method | Description |
|---|---|
| `createAccount(name, doInsert)` | Creates a single Account |
| `createAccounts(count, doInsert)` | Creates multiple Accounts |
| `createContact(firstName, lastName, accountId, doInsert)` | Creates a single Contact |
| `createContacts(count, accountId, doInsert)` | Creates multiple Contacts |
| `createOpportunity(name, accountId, stage, closeDate, doInsert)` | Creates a single Opportunity |
| `createOpportunities(count, accountId, doInsert)` | Creates multiple Opportunities |
| `createLead(firstName, lastName, company, doInsert)` | Creates a single Lead |

### Usage Example

```apex
@isTest
static void myTest() {
    // Create and insert an Account
    Account acc = TestDataFactory.createAccount('Acme Corp', true);

    // Create 5 Contacts linked to the Account (inserted)
    List<Contact> contacts = TestDataFactory.createContacts(5, acc.Id, true);

    // Create an Opportunity without inserting
    Opportunity opp = TestDataFactory.createOpportunity(
        'Big Deal', acc.Id, 'Prospecting', Date.today().addDays(30), false
    );
    // ... assert fields, then insert manually if needed
}
```

## Setup

This project uses [Salesforce DX](https://developer.salesforce.com/tools/sfdxcli). To deploy to a scratch org:

```bash
sf org create scratch -f config/project-scratch-def.json -a MyScratchOrg
sf project deploy start --source-dir force-app
sf apex run test --test-level RunLocalTests
```
