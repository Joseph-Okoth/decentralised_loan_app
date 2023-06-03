window.addEventListener('DOMContentLoaded', () => {
  // Contract Address and ABI
  const contractAddress = '0xFDCa0Aef52cD9A40C139f2e692fe52567d137Dc6';
  const contractABI = [
    // Collateral Contract ABI
    // ...

    // SimpleERC20Token Contract ABI
    // ...

    // Loan Contract ABI
    // ...
  ];

  // Initialize Web3
  let web3;
  if (typeof window.ethereum !== 'undefined') {
    web3 = new Web3(window.ethereum);
    window.ethereum.enable();
  } else {
    console.log('Please install MetaMask to use this application.');
    return;
  }

  // Contract Instances
  const collateralContract = new web3.eth.Contract(contractABI, contractAddress);
  const tokenContract = new web3.eth.Contract(contractABI, contractAddress);
  const loanContract = new web3.eth.Contract(contractABI, contractAddress);

  // Form Submit Event Listener
  const loanForm = document.getElementById('loanForm');
  loanForm.addEventListener('submit', async (e) => {
    e.preventDefault();

    const borrowerAddress = document.getElementById('borrowerAddress').value;
    const collateralAmount = document.getElementById('collateralAmount').value;
    const payoffAmount = document.getElementById('payoffAmount').value;
    const loanDuration = document.getElementById('loanDuration').value;

    // Create Loan Transaction
    try {
      const loanCreationTx = await loanContract.methods
        .createLoan(borrowerAddress, collateralAmount, payoffAmount, loanDuration)
        .send({ from: web3.eth.defaultAccount });

      // Output Transaction Receipt
      const output = document.getElementById('output');
      output.innerHTML = `
        <p>Loan created successfully!</p>
        <p>Transaction Hash: ${loanCreationTx.transactionHash}</p>
      `;
    } catch (error) {
      console.error(error);
      const output = document.getElementById('output');
      output.innerHTML = `<p>An error occurred while creating the loan.</p>`;
    }
  });
});
