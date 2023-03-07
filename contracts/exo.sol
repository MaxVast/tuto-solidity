// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

//import "../node_modules/hardhat/console.sol";

contract simpleWallet {

    struct wallet {
        uint numbPayments;
        uint balance;
    }

    mapping(address => wallet) Wallets;

    function getTotalBalances() public view returns(uint) {
        return address(this).balance;
    }

    function getBalance() public view returns(uint) {
        return Wallets[msg.sender].balance;
    }

    function getNumbPayments() public view returns(uint) {
        return Wallets[msg.sender].numbPayments;
    }

    function withdrawAllToken(address payable _to) public payable {
        uint _amount = Wallets[msg.sender].balance;
        Wallets[msg.sender].balance = 0;
        _to.transfer(_amount);
    }

    function withdrawToken(address payable _to, uint256  _number) public payable {
        require(Wallets[msg.sender].balance >= _number, "Not enough tokens");
        uint _sold = _number * (1 ether);
        Wallets[msg.sender].balance -= _sold;
        _to.transfer(_sold);
    }

    receive() external payable  {
        Wallets[msg.sender].numbPayments += 1;
        Wallets[msg.sender].balance += msg.value; 
    }
}