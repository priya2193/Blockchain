pragma solidity ^0.5.1;

contract Operations{
    
    struct Item{
        uint itemID;
        uint itemPrice;
        string itemName;
        address UserID; // Owner ID
    }
    
    struct User{
        address UserID;
        uint Balance;
        uint Registered;
    }

    address public chairPerson;
    mapping(address => User) public users;
    mapping(uint => Item) public items;
    uint itemCount;
    
    event Sent(address sender, address receiver, uint bal, uint iID);
    
    constructor() public {
        chairPerson = msg.sender;
        itemCount = 0;
    }
    
    function registerUser(address ID, uint bal) public {
        require(msg.sender == chairPerson);
        if(users[ID].Registered != 1){
            users[ID].UserID = ID;
            users[ID].Balance = bal;
            users[ID].Registered = 1;    
        }
    }
    
    function registerItem(string memory name, address userID, uint price) public {
        require(msg.sender == chairPerson);
        if(users[userID].Registered == 1){
            itemCount = itemCount + 1;
            items[itemCount].itemName = name;
            items[itemCount].itemPrice = price;
            items[itemCount].UserID = userID;
            items[itemCount].itemID = itemCount;    
        }
    }
    
    function unRegister(address ID) public {
        require(msg.sender == chairPerson);
        users[ID].Registered = 0;
        for(uint i = 1; i<=itemCount; i++){
            if(items[i].UserID == ID){
                items[i].UserID = chairPerson;
            }
        }
        
    }
    
    function buy(address ID, uint iID) public payable {
       if(users[ID].Balance >= items[iID].itemPrice && users[ID].Registered == 1) {
           users[ID].Balance = users[ID].Balance - items[iID].itemPrice;
           users[items[iID].UserID].Balance = users[items[iID].UserID].Balance + items[iID].itemPrice;
           address receiver = items[iID].UserID;
           items[iID].UserID = ID;
           emit Sent(ID, receiver, items[iID].itemPrice, iID);

       }
       else{
           revert();
       }
    }
        
    // function settlePayment(uint uID, uint Price) public {
    //     require(msg.sender == chairPerson);
    //     // Owner should settle the latest Payment event
        
    // }
}