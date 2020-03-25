const HelloWorld = artifacts.require("HelloWorld");
const fightGame = artifacts.require("fightGame");
module.exports = function(deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(fightGame);
};
