const collateral = artifacts.require("collateral");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("collateral", function (/* accounts */) {
  it("should assert true", async function () {
    await collateral.deployed();
    return assert.isTrue(true);
  });
});
