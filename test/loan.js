const loan = artifacts.require("loan");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("loan", function (/* accounts */) {
  it("should assert true", async function () {
    await loan.deployed();
    return assert.isTrue(true);
  });
});
