pragma solidity ^0.4.0;

contract heddarum{
    address public creator;
    mapping (address => uint256) balances;
    
    function heddarum(){
        creator = msg.sender;
    }
    
    event created(address _where, uint howMuch);
    
    event tranferred(address from, address to, uint howMuch);
    
    function balanceOf(address _whoever) public view returns (uint256){
        require (_whoever != 0x0);
        return balances[_whoever];
    }
    
    function create(address _receiver, uint amount){
        if (msg.sender != creator) return;
        require (_receiver != 0x0);
        balances[_receiver] += amount;
        created(_receiver, amount);
    }
    
    function tranfer(address _receiver, uint amount){
        require (_receiver != 0x0);
        require (balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[_receiver] += amount;
        tranferred(msg.sender, _receiver, amount);
    }
    
    
}
