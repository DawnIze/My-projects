// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Kemi {
    bool public paused;
    uint public count;
    function setpause (bool x) public{
        paused=x;
    }
    function increase () public{
        require (!paused); //require the opp. of the state variable
        count+=1;}

        function decrease () public{
            require (!paused);
            count -=1;
        }

    }
