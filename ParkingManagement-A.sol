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
