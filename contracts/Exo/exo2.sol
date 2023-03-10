// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

contract Exo2 {

    struct student {
        string lastName;
        string firstName;
        uint[] ratings;
    }

    mapping(address => student) Students;

    function addRate(address _student, uint _rate) public {
        Students[_student].ratings.push(_rate);
    }

    function updateRate(address _student, uint _value, uint _index) public {
        Students[_student].ratings[_index] = _value;
    }

    function deleteRate(address _student, uint _index) public {
        delete Students[_student].ratings[_index];
    }

    function getRates(address _student) public view returns(uint[] memory) {
        return Students[_student].ratings;
    }

    function setName(address _student, string memory _lastName, string memory _firstName) public {
        Students[_student].lastName = _lastName;
        Students[_student].firstName = _firstName;
    }

    function getLastName(address _student) public view returns(string memory){
        return Students[_student].lastName;
    }
}