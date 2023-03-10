// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import "../../node_modules/hardhat/console.sol";

contract Owner {

    address owner;

    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
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