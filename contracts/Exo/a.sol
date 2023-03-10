// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import './b.sol';

contract A {

    address addressB;

    function setAddressB(address _addressB) external {
        addressB = _addressB;
    }

    function callGetNumber() external view returns(uint) {
        interfaceB b = interfaceB(addressB);
        return b.getNumber();
    }

    function callSetNumber(uint _number) external {
        interfaceB b = interfaceB(addressB);
        return b.setNumber(_number);
    }

}