// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import './owner.sol';

contract Wallet is Owner {

    struct payment {
        uint amount;
        uint timestamp;
    }

    struct balance {
        uint totalBalance;
        uint numbPayments;
        mapping(uint => payment) payments;
    }

    mapping(address => balance) Wallets;

    function getTotalBalance() external isOwner view returns(uint) {
        return address(this).balance;
    }

    function getBalance() external view returns(uint) {
        return Wallets[msg.sender].totalBalance;
    }

    function withdrawAllToken(address payable _to) external payable {
        uint _amount = Wallets[msg.sender].totalBalance;
        Wallets[msg.sender].totalBalance = 0;
        _to.transfer(_amount);
    }

    function withdrawToken(address payable _to, uint _number) external payable {
        require(_number <= Wallets[msg.sender].totalBalance, "Not enough tokens");
        Wallets[msg.sender].totalBalance -= _number;
        _to.transfer(_number);
    }

    receive() external payable  {
        payment memory thisPayment = payment(msg.value, block.timestamp);
        Wallets[msg.sender].numbPayments += 1;
        Wallets[msg.sender].totalBalance += msg.value; 
        Wallets[msg.sender].payments[Wallets[msg.sender].numbPayments] = thisPayment;
    }

}