// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// import "./ierc20token.sol";
import "./loan.sol";

contract LoanRequest {
    // The borrower's address is set to the sender's address
    address public borrower = msg.sender;
    // The token contract
    SimpleERC20Token public token;
    // The amount of collateral required for the loan
    uint256 public collateralAmount;
    // The amount of the loan requested
    uint256 public loanAmount;
    // The amount to be paid off for the loan
    uint256 public payoffAmount;
    // The duration of the loan
    uint256 public loanDuration;

    // Constructor to initialize the contract with the specified parameters
    constructor (
        SimpleERC20Token _token,
        uint256 _collateralAmount,
        uint256 _loanAmount,
        uint256 _payoffAmount,
        uint256 _loanDuration
    )
        public
    {
        token = _token;
        collateralAmount = _collateralAmount;
        loanAmount = _loanAmount;
        payoffAmount = _payoffAmount;
        loanDuration = _loanDuration;
    }

    // The loan contract instance
    Loan public loan;

    // Event emitted when the loan request is accepted
    event LoanRequestAccepted(address loan);

    // Function to lend Ether and create a new loan contract
    function lendEther() public payable {
        // Check if the sent Ether matches the loan amount
        require(msg.value == loanAmount);

        // Create a new Loan contract instance
        loan = new Loan(
            msg.sender,
            borrower,
            token,
            collateralAmount,
            payoffAmount,
            loanDuration
        );

        // Transfer the collateral tokens from the borrower to the loan contract
        require(token.transferFrom(borrower, loan, collateralAmount));

        // Transfer the loan amount to the borrower
        borrower.transfer(loanAmount);

        // Emit the LoanRequestAccepted event with the loan contract address
        emit LoanRequestAccepted(loan);
    }
}
