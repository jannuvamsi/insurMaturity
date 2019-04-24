// import solidity
pragma solidity ^0.4.0;

contract Inheritance {
    address owner;
    bool deceased;
    uint money;
    
    constructor() public payable {
        owner = msg.sender;
        money = msg.value;
        deceased = false;
    }
    
    //Check whether the person is owner
    modifier oneOwner {
        require (msg.sender == owner);
        _;
    }
    
    //Check for status of the insured item
    modifier isDeceased {
        require (deceased == true);
        _;
    }
    
    address[] wallets;
    
    mapping (address => uint) inheritance;
    
    function setup(address _wallet, uint _inheritance) public oneOwner {
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
    }
    
    function moneyPaid() private isDeceased {
        for (uint i=0; 0<wallets.length; i++) {
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }
    //Checking for the item maturity is over
    function died() public oneOwner {
        deceased = true;
        moneyPaid();
    }

}