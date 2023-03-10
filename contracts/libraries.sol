// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

//https://github.com/OpenZeppelin/openzeppelin-contracts
//npm install @openzeppelin/contracts
import '../node_modules/@openzeppelin/contracts/utils/Strings.sol';

contract Libraries {

    function concatener(string memory _stringA, uint _numberA, uint _numberB) external pure returns(string memory) {
        string memory res = string(abi.encodePacked(_stringA, Strings.toString(_numberA), Strings.toString(_numberB)));
        return res;
    }

}