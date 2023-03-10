const FavoriteNumber = artifacts.require("FavoriteNumber");

module.exports = function(_deployer) {
  _deployer.deploy(FavoriteNumber)
};
