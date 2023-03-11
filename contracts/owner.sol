// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Owner {
  
  address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, 'Not the owner');
        _;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}