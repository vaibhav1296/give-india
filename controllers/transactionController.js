const query = require("../services/query/query");
const express = require("express");
const validateRequest = require("../services/validateRequest");
const { getTotalBalanceOfUser } = require("../services/query/query");
const transactionError = require("../config/transactionError").transactionError;
router = express.Router();

router.post(
  "/",
  validateRequest.validateTransactionRequest,
  async (req, res, next) => {
    try {
      let { fromAccountId, toAccountId, amount } = req.body;
      amount = parseFloat(amount);
      let sourceAccountBalance = await query.getAccountBalance(fromAccountId);
      let destinationAccountBalance = await query.getAccountBalance(
        toAccountId
      );
      sourceAccountBalance = parseFloat(sourceAccountBalance.totalBalance);
      destinationAccountBalance = parseFloat(
        destinationAccountBalance.totalBalance
      );
      const newSourceBalance = sourceAccountBalance - amount;
      const newDestinationBalance = destinationAccountBalance + amount;
      await query.createTransaction(
        fromAccountId,
        toAccountId,
        amount,
        newSourceBalance,
        newDestinationBalance
      );
      // craete API response
      const reply = await query.getUserIdOfAccount(toAccountId);
      const userId = reply.userId;
      let totalDestBalance = await query.getTotalBalanceOfUser(userId);
      const time = new Date().toLocaleString();
      totalDestBalance = totalDestBalance.totalBalance;
      res.locals.response = {
        message: "The transaction went successfull",
        body: {
          newSrcBalance: newSourceBalance,
          totalDestBalance,
          timestamp: time,
        },
      };
      next();
    } catch (err) {
      next(transactionError(err.message, 400));
    }
  }
);

module.exports = router;
