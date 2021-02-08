const query = require("../services/query/query");
const express = require("express");
const validateRequest = require("../services/validateRequest");
const utility = require("../services/utility");
const transactionError = require("../config/transactionError");
const router = express.Router();

router.post(
  "/",
  validateRequest.validateCreateAccountRequest,
  async (req, res, next) => {
    //
    try {
      const { userId, accountTypeId, totalBalance } = res.locals.accountDetails;
      let reply = await query.createAccount({
        userId,
        accountTypeId,
        totalBalance,
      });
      if (utility.isNullOrUndefined(reply)) {
        next(
          transactionError(
            "Something went wrong while creatig account, please try again",
            400
          )
        );
      }
      res.locals.response = {
        message: "The account has been successfully created.",
      };
      next();
    } catch (err) {
      next(transactionError(err.message, 400));
    }
  }
);

module.exports = router;
