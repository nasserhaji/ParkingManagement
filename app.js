// Create a new web3 instance
const web3 = new Web3('https://rinkeby.infura.io/v3/your-project-id');

// Define the contract address and ABI
const contractAddress = '0x123...';
const abi = [/* ... */];

// Create a new contract instance
const contract = new web3.eth.Contract(abi, contractAddress);

// Define the user's wallet address and private key
const walletAddress = '0xabc...';
const privateKey = '0xdef...';

// Set the default account for sending transactions
web3.eth.accounts.wallet.add(privateKey);
web3.eth.defaultAccount = walletAddress;

// Define the park function
async function park(carPlate) {
  try {
    const result = await contract.methods.park(carPlate).send({ from: walletAddress });
    console.log(result);
  } catch (error) {
    console.error(error);
  }
}

// Call the park function
park('AB12CD');
