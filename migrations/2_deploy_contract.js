const ERC721Dynamic = artifacts.require("ERC721DynamicExtension");

module.exports = async function (deployer, network, accounts) {
  // deployment steps
  await deployer.deploy(ERC721Dynamic);
};