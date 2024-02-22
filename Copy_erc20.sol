// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
function totalSupply() external view returns (uint);//you don't implement aninterface function. no curly bracket needed for interface. 
function balanceOf(address account) external view returns (uint);
function transfer(address recipient, uint amount) external returns(bool);
function allowance(address owner, address spender) external  view returns (uint);
function approve(address spender, uint amount) external returns (bool);
function transferFrom(address sender, address recipient, uint amount) external returns(bool);//called by the recipient

event Transfer(address indexed from, address indexed to, uint value); //index helps to track transactions
event Approval(address indexed owner, address indexed spender, uint value);
}

contract ERC20 is IERC20{
    uint public override totalSupply;
    mapping(address=>uint) public override balanceOf;
    mapping(address=>mapping(address=>uint)) public override allowance; //nested mapping
string public name= "Dawn token";
string public symbol= "Dtk";
uint public decimal= 18;

function transfer (address recipient, uint amount) external override returns (bool) {
balanceOf[msg.sender] -= amount;
balanceOf[recipient] += amount;
emit Transfer (msg.sender, recipient, amount);
return true;
}
function approve(address spender, uint amount) external override returns (bool){
    allowance[msg.sender][spender] = amount;
    emit Approval (msg.sender, spender, amount);
    return true;
}
function transferFrom(address sender, address recepient, uint amount) 
external override returns (bool){
    //remember this transferFrom function will be called by the recipient
    //deduct the allowance you were given
    allowance[sender][msg.sender]-=amount;
    //remove the amount from the sender's account(husband)
    balanceOf[sender]-amount;
    //credit the recipient with the amount deducted above
    balanceOf[recepient]+=amount;
    //let the frontend know that a transaction has occured
    emit Transfer(sender, recepient, amount);
    return true;
}
function mint(uint amount) external{
    balanceOf[msg.sender]+=amount;
    totalSupply+=amount;
    emit Transfer(address(0),msg.sender, amount);
}
function burn (uint amount) external {
    balanceOf[msg.sender]-= amount;
    totalSupply-=amount;
    emit Transfer(msg.sender, address(0), amount);
}
 
} 