const Owner = artifacts.require("Owner");

module.exports = function(_deployer) {
  _deployer.deploy(Owner)
};