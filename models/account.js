module.exports = (sequelize, DataTypes) => {
  const account = sequelize.define(
    "account",
    {
      userId: {
        type: DataTypes.INTEGER,
        field: "user_id",
      },
      accountTypeId: {
        type: DataTypes.INTEGER,
        field: "account_type_id",
      },
      totalBalance: {
        type: DataTypes.DECIMAL,
        field: "total_balance",
      },
    },
    {
      underscored: true,
      freezeTableName: true,
    }
  );
  //association functions
  account.associate = function (models) {
    account.belongsTo(models.user, {
      foreignKey: "userId",
    });
    account.belongsTo(models.account_type, {
      foreignKey: "accountTypeId",
    });
  };
  return account;
};
