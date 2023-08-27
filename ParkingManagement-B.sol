pragma solidity >=0.4.22 <0.9.0;

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
