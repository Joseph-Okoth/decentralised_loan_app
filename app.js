const Web3 = require('web3');
const contract = require('C:\Users\JosephOkoth\Desktop\coding_practice\solidity_loan_smart_contract\build\contracts\Collateral.json'); // Path to the compiled contract artifacts

// Initialize a Web3 instance
const web3 = new Web3('http://localhost:8545'); // Update with your network provider URL

// Set the default account (sender) for transactions
web3.eth.defaultAccount = '0x...'; // Update with your account address

// Get the contract ABI and address from the compiled contract artifacts
const abi = contract.abi;
const address = contract.networks['...'].address; // Update with the network ID

// Create a contract instance
const contractInstance = new web3.eth.Contract(abi, address);

// Example function to interact with the contract
async function interactWithContract() {
  try {
    // Call a contract function (read-only)
    const result = await contractInstance.methods.myFunction().call();
    console.log('Contract result:', result);

    // Send a transaction to a contract function (state-changing)
    const receipt = await contractInstance.methods.myFunction().send();
    console.log('Transaction receipt:', receipt);
  } catch (error) {
    console.error('Error:', error);
  }
}

// Call the function to interact with the contract
interactWithContract();
