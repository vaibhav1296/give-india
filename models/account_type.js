module.exports = (sequelize, DataTypes) => {
  const account_type = sequelize.define(
    "account_type",
    {
      type: DataTypes.STRING,
    },
    {
      underscored: true,
      freezeTableName: true,
    }
  );

  return account_type;
};
