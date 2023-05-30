// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleERC20Token {
    // Track how many tokens are owned by each address.
    mapping (address => uint256) public balanceOf;

    string public name = "Simple ERC20 Token"; // The name of the token
    string public symbol = "SET"; // The symbol of the token
    uint8 public decimals = 18; // The number of decimal places for the token

    uint256 public totalSupply = 1000000 * (uint256(10) ** decimals); // The total supply of tokens

    event Transfer(address indexed from, address indexed to, uint256 value);

    function SimpleERC20Token() public {
        // Initially assign all tokens to the contract's creator.
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply); // Emit an event to indicate the initial token transfer
    }

    // Transfer tokens from the sender's address to a specified recipient
    function transfer(address to, uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value); // Check if the sender has enough tokens

        balanceOf[msg.sender] -= value;  // Deduct tokens from the sender's balance
        balanceOf[to] += value;          // Add tokens to the recipient's balance
        emit Transfer(msg.sender, to, value); // Emit an event to indicate the token transfer
        return true;
    }

    event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping(address => mapping(address => uint256)) public allowance;

    // Approve a specified address to spend a specified amount of tokens on behalf of the sender
    function approve(address spender, uint256 value)
        public
        returns (bool success)
    {
        allowance[msg.sender][spender] = value; // Set the allowance for the spender
        emit Approval(msg.sender, spender, value); // Emit an event to indicate the approval
        return true;
    }

    // Transfer tokens from a specified address to another address on behalf of the sender
    function transferFrom(address from, address to, uint256 value)
        public
        returns (bool success)
    {
        require(value <= balanceOf[from]); // Check if the from address has enough tokens
        require(value <= allowance[from][msg.sender]); // Check if the sender is allowed to spend the specified amount of tokens from the from address

        balanceOf[from] -= value; // Deduct tokens from the from address
        balanceOf[to] += value; // Add tokens to the recipient's balance
        allowance[from][msg.sender] -= value; // Deduct the spent tokens from the allowance
        emit Transfer(from, to, value); // Emit an event to indicate the token transfer
        return true;
    }
}
