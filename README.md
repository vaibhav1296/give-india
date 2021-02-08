## What's this? :thinking:

An API collection for creating transactions between two accounts. You will have three types of accounts and you need make a transaction between any two (under certain conditions) and give back a success/error response.

This collection has two endpoints starting with **_/user_** and **_/transaction_** :raised_eyebrow:

When you will hit **_/user_** endpoint with _POST_ method it will add an account in database. The request body for this route looks like this-

```
{
    "accountTypeId":"<INTEGER>" // You will get this from account_type table
    "userId":"<INTEGER>" // You will get this from the user table
    "initialBalance":"<DECIMAL>" //any amount (differ in case of basicSavings account)
}
```

This will add an account in database and will send back a response like this

```
{
    "code":0,
    "message": "The account has been successfully created."
}
```

When you will hit **_/transaction_** route with _POST_ method and below body then it will create a transaction between two accounts :money_mouth_face:

```
{
    "fromAccountId":<INTEGER> // source account
    "toAccountId":<INTEGER> //destination account
    "amount":<DECIMAL>
}
```

There are certain checks that will happen on this API request.

- It will check if the values are provided on not (null value check).
- It will check if both the accounts do not belong to a single user.
- It will check if source account have enough balance to finish this transaction.
- it will check if the destination account type is **BASIC_SAVINGS** then after transaction its balance must be less than 50,000.

After these checks the transaction will make place. Sequelize transaction has been used in this API to ensure that if something goes wrong while updating the database, all the prior made changes will get reverted.

Once everything goes right it will give response like this

```
{
    "status": {
        "code": 0,
        "message": "The transaction went successfull"
    },
    "newSrcBalance": 26000,
    "totalDestBalance": "174000.00",
    "timestamp": "09/02/2021, 01:01:28"
}
```

## How to run

If you want to work with this code you need following things on system

- NodeJS installed
- PostgreSQL database installed
- Postman
- VS code editor or any

Follow below steps to work with this repo

- Clone this repo on your local.
- Run command **npm i**
- Create a database.
- From dump folder take the dump file and restore it for your database.
- For restoring on your database simply run command **psql your-db-name < /path-to-file** (you can check if you have applied any password or role authentication on your database).
- Now edit the config.json file with right credential
- Create .env file and add **SERVER_PORT** variable and pass a server port like 8080 or 3000.
- Run command **npm start** and now test APIs on postman.

That's it. :relieved:
