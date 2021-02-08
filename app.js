require("dotenv").config();
const express = require("express");
const app = express();

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const transactionController = require("./controllers/transactionController");
const userController = require("./controllers/userController");
const requestResponseHandler = require("./services/requestResponseHandler");

app.use("/user", userController);
app.use("/transaction", transactionController);
app.use(requestResponseHandler.handleResponse);
app.use(requestResponseHandler.handleError);

app.listen(process.env.SERVER_PORT, () => {
  console.log(`THE SERVER IS RUNNING ON PORT ${process.env.SERVER_PORT}`);
});
