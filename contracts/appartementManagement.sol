// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import './owner.sol';

contract AppartementManagement is Owner {

    uint counter;

    enum typeProperty { land, flat, house, villa }

    struct property {
        uint SKU;
        string name;
        uint price;
        typeProperty propertyType;
    }

    mapping(address => property[]) Possessions;

    function addProperty(address _address, string memory _name, uint _price,typeProperty _propertyType) public isOwner {
        require(_price >= 100000, 'The price must to be more or equal to 100000 wei');
        require(uint(_propertyType) >= 0 && uint(_propertyType) <= 3, 'The typeProperty must to be between 0 and 3');
        uint _SKU = counter++;
        Possessions[_address].push(property(_SKU, _name, _price, _propertyType));
    }

    function updateOneProperty(address _address, uint _SKU, string memory _name, uint _price,typeProperty _propertyType) public isOwner {
        require(_price >= 100000, 'The price must to be more or equal to 100000 wei');
        require(uint(_propertyType) >= 0 && uint(_propertyType) <= 3, 'The typeProperty must to be between 0 and 3');
        for(uint i = 0; i <= Possessions[_address].length; i++) {
            if(Possessions[_address][i].SKU == _SKU) { 
                Possessions[_address][i].name = _name;
                Possessions[_address][i].price = _price;
                Possessions[_address][i].propertyType = _propertyType;
                break;
            }
        }
    }

    function getPropertys(address _address) public view isOwner returns(property[] memory) {
        return Possessions[_address];
    }

    function getPropertysNumber(address _address) public view isOwner returns(uint) {
        return Possessions[_address].length;
    }

    function getProperty() public view returns(property[] memory) {
        return Possessions[msg.sender];
    }
}