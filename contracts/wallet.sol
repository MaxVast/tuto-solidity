// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract wallet {
    
   mapping(address => uint) private balances;

   function balance() external view returns (uint) {
        return balances[msg.sender]; // returns the balance of this user
    }
}
