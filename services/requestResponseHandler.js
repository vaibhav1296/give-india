const utility = require("./utility");
const isTransactionError = require("./utility").isTransactionError;
const transactionError = require("../config/transactionError").transactionError;
const handleResponse = (req, res, next) => {
  if (res.locals.response) {
    let response = {
      status: {
        code: 0,
        message: res.locals.response.message,
      },
    };
    if (res.locals.response.body) {
      response = {
        ...response,
        ...res.locals.response.body,
      };
    }
    res.locals.responseStatus = true;
    res.send(response);
  } else {
    next();
  }
};
const handleError = (err, req, res, next) => {
  let error = err;
  if (!isTransactionError(error)) {
    error = transactionError("Server Error");
  }
  res.status(error.statusCode || 500);
  if (
    utility.isNullOrUndefined(res.locals.responseStatus) ||
    res.locals.responseStatus
  ) {
    res.send({
      status: {
        code: error.statusCode,
        message: error.message,
      },
    });
  }
};

module.exports = {
  handleResponse,
  handleError,
};
