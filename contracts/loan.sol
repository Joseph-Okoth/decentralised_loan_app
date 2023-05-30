// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ierc20token.sol";

contract Loan {
    address public lender; // Address of the lender
    address public borrower; // Address of the borrower
    IERC20Token public token; // Reference to an ERC20 token contract
    uint256 public collateralAmount; // Amount of collateral provided by the borrower
    uint256 public payoffAmount; // Amount that needs to be repaid by the borrower
    uint256 public dueDate; // Timestamp representing the due date for the loan

    constructor(
        address _lender,
        address _borrower,
        IERC20Token _token,
        uint256 _collateralAmount,
        uint256 _payoffAmount,
        uint256 loanDuration
    )
        public
    {
        lender = _lender; // Set the lender address
        borrower = _borrower; // Set the borrower address
        token = _token; // Set the token reference
        collateralAmount = _collateralAmount; // Set the collateral amount
        payoffAmount = _payoffAmount; // Set the payoff amount
        dueDate = block.timestamp + loanDuration; // Calculate the due date based on the loan duration
    }

    event LoanPaid(); // Event emitted when the loan is paid off

    function payLoan() public payable {
        require(block.timestamp <= dueDate); // Check if the current timestamp is before or equal to the due date
        require(msg.value == payoffAmount); // Check if the value sent with the transaction matches the payoff amount

        require(token.transfer(borrower, collateralAmount)); // Transfer the collateral tokens to the borrower
        emit LoanPaid(); // Emit the LoanPaid event to indicate that the loan has been paid off
        selfdestruct(lender); // Destroy the contract and send any remaining Ether balance to the lender
    }

    function repossess() public {
        require(block.timestamp > dueDate); // Check if the current timestamp is after the due date

        require(token.transfer(lender, collateralAmount)); // Transfer the collateral tokens to the lender
        selfdestruct(lender); // Destroy the contract and send any remaining Ether balance to the lender
    }
}