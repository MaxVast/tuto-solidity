// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import './owner.sol';

contract Wallet is Owner {
    
    mapping(address => uint) private Wallets;

    function withdrawAllToken(address payable _to) external payable {
        uint _amount = Wallets[msg.sender];
        Wallets[msg.sender] = 0;
        _to.transfer(_amount);
    }

    function withdrawToken(address payable _to, uint _number) external payable {
        require(_number <= Wallets[msg.sender], "Not enough tokens");
        Wallets[msg.sender] -= _number;
        _to.transfer(_number);
    }


    function getbalance() external view returns (uint) {
        return Wallets[msg.sender]; // returns the balance of this user
    }

    function getTotalBalances() external isOwner view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        Wallets[msg.sender] += msg.value;
    }

    fallback() external payable {
    }
}
