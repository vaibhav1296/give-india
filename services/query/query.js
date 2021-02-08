require("dotenv").config();
const models = require("../../models/index");
const Sequelize = require("sequelize");
const env = process.env.NODE_ENV || "development";
const config = require("../../config/config.json")[env];
const sequelize = new Sequelize(config);

const getAccountType = async (id) => {
  return models.account_type.findOne({
    where: { id },
  });
};

const getAccountDetail = async (id) => {
  return models.account.findOne({
    where: { id },
  });
};

const getAccountBalance = async (id) => {
  return models.account.findOne({
    where: { id },
    attributes: ["totalBalance"],
  });
};

const createTransaction = async (
  fromAccountId,
  toAccountId,
  amount,
  sourceBalance,
  destinationBalance
) => {
  const t = await sequelize.transaction();
  try {
    await models.account.update(
      {
        totalBalance: sourceBalance,
      },
      {
        where: {
          id: fromAccountId,
        },
      },
      {
        transaction: t,
      }
    );
    await models.account.update(
      {
        totalBalance: destinationBalance,
      },
      {
        where: {
          id: toAccountId,
        },
      },
      {
        transaction: t,
      }
    );

    const reply = await models.transaction.create({
      fromAccount: fromAccountId,
      toAccount: toAccountId,
      totalAmountTransfer: amount,
    });
    await t.commit();
  } catch (err) {
    await t.rollback();
  }
};
const getTotalBalanceOfUser = async (userId) => {
  return models.account.findOne({
    where: { userId },
    attributes: [
      [
        models.sequelize.fn("sum", models.sequelize.col("total_balance")),
        "totalBalance",
      ],
    ],
  });
};
const getUserIdOfAccount = async (id) => {
  return models.account.findOne({
    where: { id },
    attributes: ["userId"],
  });
};
const getAccountTypeId = async (type) => {
  return models.account_type.findOne({
    where: { type },
  });
};

const createAccount = async ({ userId, accountTypeId, totalBalance }) => {
  return models.account.create({
    userId,
    totalBalance,
    accountTypeId,
  });
};

module.exports = {
  getAccountType,
  createAccount,
  getAccountDetail,
  getAccountTypeId,
  createTransaction,
  getAccountBalance,
  getUserIdOfAccount,
  getTotalBalanceOfUser,
};
