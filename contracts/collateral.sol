// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ierc20token.sol";
import "./loan.sol";

contract Collateral {
    SimpleERC20Token public token;
    Loan public loan;
    uint256 public collateralAmount;

    constructor(SimpleERC20Token _token, Loan _loan, uint256 _collateralAmount) {
        token = _token;
        loan = _loan;
        collateralAmount = _collateralAmount;
    }

    function releaseCollateral() public {
        require(msg.sender == loan.lender(), "Only lender can release collateral");
        require(block.timestamp > loan.dueDate(), "Collateral can only be released after the loan has expired");

        require(token.transfer(loan.borrower(), collateralAmount), "Failed to transfer collateral back to borrower");

        selfdestruct(payable(loan.lender()));
    }
}
