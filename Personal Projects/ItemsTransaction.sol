pragma solidity >=0.4.22 <0.6.0;

contract MarsColonization {
    
    struct MarsHouse {
        uint price;
        uint houseId;
        string ownerId;
        bool forSale;
        address ownerAddress;
    }

    struct User {
        string userName;
        uint budget;
        address userAddress;
    }
    
    string public userName;
    string public houseOwner;
    bool public houseStatus;
    uint public housePrice;
    uint public userBudget;
    
    address public marsMonitoringAuthority;
    mapping(address => User) users;
    mapping(uint => MarsHouse) houses;
    // event Sent(address from, address to, MarsHouse house);
    
    //Number of houses available in the pool
    constructor(uint8 _numHouses) public {
        marsMonitoringAuthority = msg.sender;
        for(uint i = 0; i<_numHouses; i++){
            if(i<_numHouses/2){
                houses[i].price = 100;
            }else{
                houses[i].price = 200;
            }
            houses[i].ownerId = "MarsGovernment";
            houses[i].forSale = true;
            houses[i].houseId = i;
            houses[i].ownerAddress = marsMonitoringAuthority;
            
        }
        
    }
    
    function createUser(address userAdd, string name, uint money) public {
        if (msg.sender != marsMonitoringAuthority) return;
        users[userAdd].userName = name;
        users[userAdd].budget = money;
        users[userAdd].userAddress = userAdd;
    }
    
    function getUser(address userAdd) public {
        userName = users[userAdd].userName;
        userBudget = users[userAdd].budget;
        return;
    }
    
    function markTerritory(address buyerAdd, uint HId) public {
        if(users[buyerAdd].budget >= houses[HId].price && houses[HId].forSale == true){
            users[buyerAdd].budget -= houses[HId].price;
            houses[HId].ownerId = users[buyerAdd].userName;
            houses[HId].forSale = false;
            if(houses[HId].ownerAddress != marsMonitoringAuthority){
                users[houses[HId].ownerAddress].budget += houses[HId].price;
            }
            houses[HId].ownerAddress = buyerAdd;
            // emit Sent(buyerAdd, houses[HId].ownerAddress, houses[HId]);
        }
    }
    
    function letTheHouseGo(address userAdd, uint HId, uint price) public{
        if(houses[HId].forSale == true) return;
        if(keccak256(abi.encodePacked(houses[HId].ownerId)) == keccak256(abi.encodePacked(users[userAdd].userName))){
            houses[HId].forSale = true;
            if(price != 0){
                houses[HId].price = price;
            }
            
        }
    }
    
    function getHouse(uint HId) public {
        houseOwner = houses[HId].ownerId;
        houseStatus = houses[HId].forSale;
        housePrice = houses[HId].price;
        return;
    }
    
}
