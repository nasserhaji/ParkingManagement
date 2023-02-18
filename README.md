# Parking-management-smartcontract
This smart contract is based on blockchain technology and is used for parking management in the city.
Example smart contract for parking management using Solidity
This smart contract has the following functionality:

## It allows the owner to add parking spots with a given price.
* Users can reserve a parking spot by providing the ID of the spot they want to reserve and paying the correct amount of ether.
* The smart contract keeps track of the total revenue generated from parking reservations.
* The owner can withdraw the total revenue from the smart contract.
Note that this is just an example and would need to be adapted to your specific needs. Additionally, make sure to properly test and audit your smart contract before deploying it on the Ethereum network.

### This smart contract is based on blockchain technology and is used for parking management in the city.

The blockchain-based parking management smart contract manages parking information in a database. The smart contract includes functions for setting parking prices, reserving parking spaces, and managing customers' digital wallets.

Using this smart contract, users can reserve their desired parking space and use it after paying the fee. Managers can also manage the number of available parking spaces and set parking prices separately for each user.

Since this smart contract is based on blockchain, security and transparency are guaranteed in transaction processing and data management. Additionally, this smart contract prevents unconventional programs and malicious attacks on the system by using functions that run automatically and repeatedly.

# Terms and Conditions:
* The parking management company is obliged to use the blockchain system to register and notify customer information.
* Customer payments must be made digitally, and all transactions will be recorded in the blockchain system.
* The parking price will be determined based on demand and automatically set through the smart contract.
* The parking fee will be paid by customers through the blockchain digital wallet.
* All blockchain transactions will be accessible and verifiable by the city, the public, and the parking management company. Therefore, transparency and openness in parking management will be promoted.
* In case of a problem with payments or other issues, the blockchain system will be able to make necessary corrections in a short period of time.
* All information related to customers, vacant parking spaces, parking status, and other relevant information will be stored in a shared database.

# parking management A
```solidity
pragma solidity ^0.8.0;

contract ParkingManagement {
    
    mapping (address => uint256) public balances;
    mapping (address => uint256) public parkingLots;
    mapping (address => uint256) public parkingPrices;
    uint256 public totalParkingLots;
    uint256 public defaultParkingPrice;
    
    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed recipient, uint256 amount);
    
    constructor() {
        defaultParkingPrice = 1 ether;
    }
    
    fallback() external payable {
        // Nothing to do here, this function is simply needed to receive payments
    }
    
    receive() external payable {
        // Nothing to do here, this function is simply needed to receive payments
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function setDefaultParkingPrice(uint256 _price) public {
        require(msg.sender == owner);
        defaultParkingPrice = _price;
    }
    
    function getParkingPrice() public view returns (uint256) {
        if (parkingPrices[msg.sender] > 0) {
            return parkingPrices[msg.sender];
        } else {
            return defaultParkingPrice;
        }
    }
    
    function addParkingLot(address _address, uint256 _numLots) public {
        require(msg.sender == owner);
        parkingLots[_address] += _numLots;
        totalParkingLots += _numLots;
    }
    
    function reserveParkingLot() public payable {
        require(parkingLots[msg.sender] > 0);
        require(msg.value == getParkingPrice());
        balances[msg.sender] += msg.value;
        parkingLots[msg.sender]--;
        emit Deposit(msg.sender, msg.value);
    }
    
    function withdraw(uint256 _amount) public

```

# parking management B
```solidity
pragma solidity ^0.8.0;

contract ParkingManagement {
    struct ParkingSpot {
        uint256 spotId;
        uint256 price;
        bool isAvailable;
    }

    address payable public owner;
    mapping(uint256 => ParkingSpot) public parkingSpots;
    uint256 public totalSpots;
    uint256 public totalRevenue;

    event SpotReserved(address user, uint256 spotId, uint256 price);

    constructor() {
        owner = payable(msg.sender);
        totalSpots = 0;
        totalRevenue = 0;
    }

    function addSpot(uint256 _price) public onlyOwner {
        totalSpots++;
        parkingSpots[totalSpots] = ParkingSpot(totalSpots, _price, true);
    }

    function reserveSpot(uint256 _spotId) public payable {
        require(msg.value == parkingSpots[_spotId].price, "Incorrect amount sent");
        require(parkingSpots[_spotId].isAvailable, "Spot is already taken");

        parkingSpots[_spotId].isAvailable = false;
        totalRevenue += msg.value;

        emit SpotReserved(msg.sender, _spotId, msg.value);
    }

    function withdrawFunds() public onlyOwner {
        owner.transfer(address(this).balance);
        totalRevenue = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}

```
