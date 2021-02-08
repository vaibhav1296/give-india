class TransactionError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode || 500;
  }
}

const transactionError = (message, statusCode) => {
  return new TransactionError(message, statusCode);
};
module.exports = {
  TransactionError,
  transactionError,
};
