pragma solidity ^0.4.0;

contract Escrow{
	address public buyer;
	address public seller;
	address public arbiter;
	
	//enums allow us to create our own data type (in this case 'State') with its possible values. State = 0 corresponds to AWAITING_PAYMENT and so on
	enum State{AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
	State public currentState; //defaults to AWAITING_PAYMENT
	
	//modifiers
	modifier buyerArbiterOnly(){
		require (msg.sender == buyer || msg.sender == arbiter);
		_;
	}

	modifier sellerArbiterOnly(){
		require (msg.sender == seller || msg.sender == arbiter);
		_;
	}

	modifier inState(State expectedState){
		require(currentState == expectedState);
		_;
	}

	//constructor
	function Escrow(address _buyer, address _seller, address _arbiter){
		buyer = _buyer;
		seller = _seller;
		arbiter = _arbiter;	
	} 
	
	function confirmPayment() buyerArbiterOnly inState(State.AWAITING_PAYMENT) payable {
		currentState = State.AWAITING_DELIVERY;		
	}

	function confirmDelivery() buyerArbiterOnly inState(State.AWAITING_DELIVERY) {
		seller.send(this.balance);
		currentState = State.COMPLETE;
	}

	function refundBuyer() sellerArbiterOnly inState(State.AWAITING_DELIVERY) {
		buyer.send(this.balance);
		currentState = State.REFUNDED;
	}
	
}
