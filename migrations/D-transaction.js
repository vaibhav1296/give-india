module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable("transaction", {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
      },
      from_account: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: "account",
          key: "id",
        },
      },
      to_account: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: "account",
          key: "id",
        },
      },
      total_amount_transfer: {
        type: Sequelize.DECIMAL,
        allowNull: false,
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP(3)"),
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP(3)"),
      },
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable("transaction");
  },
};
