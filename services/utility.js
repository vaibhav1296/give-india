const TransactionError = require("../config/transactionError").TransactionError;

const isNullOrUndefined = (param) => {
  if (param === null || param === undefined) {
    return true;
  }
  return false;
};
const isTransactionError = (err) => {
  return err instanceof TransactionError;
};
module.exports = {
  isNullOrUndefined,
  isTransactionError,
};
