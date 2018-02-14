pragma solidity ^0.4.0;

contract heddarum{
    address public creator;
    mapping (address => uint256) balances;
    uint public PRICE = 3000000000000000000; //3 ether
    
    function heddarum(){
        creator = msg.sender;
    }
    
    event created(address _where, uint howMuch);
    
    event tranferred(address from, address to, uint howMuch);
    
    function balanceOf(address _whoever) public view returns (uint256){
        require (_whoever != 0x0);
        return balances[_whoever];
    }
    
    function create() payable {
        require (msg.value >0 && msg.value % PRICE == 0 );
        balances[msg.sender] += msg.value / PRICE;
        created(msg.sender, msg.value / PRICE);
    }
    
    function tranfer(address _receiver, uint amount){
        require (_receiver != 0x0);
        require (balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[_receiver] += amount;
        tranferred(msg.sender, _receiver, amount);
    }
    
    
}
