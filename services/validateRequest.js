const query = require("./query/query");
const utility = require("./utility");
const transactionError = require("../config/transactionError").transactionError;
const { accountConstraints } = require("../config/customConfig");
const validateCreateAccountRequest = async (req, res, next) => {
  try {
    let { accountTypeId, initialBalance, userId } = req.body;
    // check for null
    if (utility.isNullOrUndefined(userId)) {
      next(transactionError("User ID is invalid", 400));
    }
    if (utility.isNullOrUndefined(accountTypeId)) {
      next(transactionError("Account ID is invalid", 400));
    }
    //check for null
    if (utility.isNullOrUndefined(initialBalance)) {
      //if null then check if the account type isn't BASIC_SAVINGS
      next(transactionError("Please provide initial balance", 400));
    } else {
      initialBalance = parseFloat(initialBalance);
      if (initialBalance > parseFloat(accountConstraints.maxBalance)) {
        let accountType = await query.getAccountType(accountTypeId);
        accountType = accountType.type;
        if (accountType === "BASIC_SAVINGS") {
          next(
            transactionError(
              `You need minimum ${accountConstraints.minBalance} rupees.`,
              400
            )
          );
        }
      }
    }
    res.locals.accountDetails = {
      accountTypeId,
      userId,
      totalBalance: initialBalance,
    };
    next();
  } catch (err) {
    next(transactionError(err.message, 400));
  }
};

const validateTransactionRequest = async (req, res, next) => {
  try {
    let { fromAccountId, toAccountId, amount } = req.body;
    //check for null or undefined
    if (utility.isNullOrUndefined(fromAccountId)) {
      next(transactionError("Please provide source account detail", 400));
    }
    if (utility.isNullOrUndefined(toAccountId)) {
      next(transactionError("Please provide destination account detail", 400));
    }
    if (utility.isNullOrUndefined(amount)) {
      next(transactionError("Please provide an amount", 400));
    }
    amount = parseFloat(amount);
    let sourceAccountDetail = await query.getAccountDetail(fromAccountId);
    let destinationAccountDetail = await query.getAccountDetail(toAccountId);
    if (
      utility.isNullOrUndefined(sourceAccountDetail) ||
      utility.isNullOrUndefined(destinationAccountDetail)
    ) {
      next(
        transactionError(
          "No source/destination account with this credetial",
          400
        )
      );
    }
    const sourceAccountUserId = sourceAccountDetail.userId;
    const destinationAccountUserId = destinationAccountDetail.userId;
    //check if both accounts aren't related to the same user
    if (sourceAccountUserId === destinationAccountUserId) {
      next(
        transactionError(
          "Transaction within same user accounts are not allowed!!",
          400
        )
      );
    }
    // check if source account have enough balance
    sourceAccountDetail.totalBalance = parseFloat(
      sourceAccountDetail.totalBalance
    );
    destinationAccountDetail.totalBalance = parseFloat(
      destinationAccountDetail.totalBalance
    );
    if (!(sourceAccountDetail.totalBalance - amount >= 0.0)) {
      next(
        transactionError("The source account doesn't have enough balance.", 400)
      );
    }
    // check for BASIC_SAVINGS account contraints if account type is BASIC_SAVINGS
    let basicSavingsAccountId = await query.getAccountTypeId("BASIC_SAVINGS");
    basicSavingsAccountId = basicSavingsAccountId.id;
    if (destinationAccountDetail.accountTypeId === basicSavingsAccountId) {
      if (
        destinationAccountDetail.totalBalance + amount >
        accountConstraints.maxBalance
      ) {
        next(
          transactionError(
            `Destination account can't hold more than ${accountConstraints.maxBalance}`,
            400
          )
        );
      }
    }

    next();
  } catch (err) {
    next(transactionError(err.message, 400));
  }
};

module.exports = {
  validateCreateAccountRequest,
  validateTransactionRequest,
};
