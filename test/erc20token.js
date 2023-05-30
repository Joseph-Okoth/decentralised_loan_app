const erc20token = artifacts.require("erc20token");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("erc20token", function (/* accounts */) {
  it("should assert true", async function () {
    await erc20token.deployed();
    return assert.isTrue(true);
  });
});
