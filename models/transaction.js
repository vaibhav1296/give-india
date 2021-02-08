module.exports = (sequelize, DataTypes) => {
  const transaction = sequelize.define(
    "transaction",
    {
      fromAccount: {
        type: DataTypes.INTEGER,
        field: "from_account",
      },
      toAccount: {
        type: DataTypes.INTEGER,
        field: "to_account",
      },
      totalAmountTransfer: {
        type: DataTypes.DECIMAL,
        field: "total_amount_transfer",
      },
    },
    {
      underscored: true,
      freezeTableName: true,
    }
  );
  transaction.associate = function (models) {
    transaction.belongsTo(models.account, {
      foreignKey: "fromAccount",
    });
    transaction.belongsTo(models.account, {
      foreignKey: "toAccount",
    });
  };
  return transaction;
};
