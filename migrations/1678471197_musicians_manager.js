const MusiciansManager = artifacts.require("MusiciansManager");

module.exports = function(_deployer) {
  _deployer.deploy(MusiciansManager)
};