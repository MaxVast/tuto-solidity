// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import './owner.sol';

contract TestView {

    uint public number;

    function setNumber(uint _number) external {
        number = _number;
    }

    //pure a utiliser lors de calcul
    function fois2(uint _number) external pure returns(uint) {
        return _number*2;
    }
}