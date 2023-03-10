// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

contract Exo3 {
    
    enum step {ordered, shipped, delivered}

    struct product {
        uint _SKU;
        Exo3.step _step;
    }

    mapping(address => product) CustomerOrder;

    function order(address _customer, uint _SKU) public {
        product memory p = product(_SKU, step.ordered);
        CustomerOrder[_customer] = p;
    }

    function ship(address _customer) public {
        CustomerOrder[_customer]._step = step.shipped;
    }

    function deliver(address _customer) public {
        CustomerOrder[_customer]._step = step.delivered;
    }

    function getSKU(address _customer) public view returns(uint) {
        return  CustomerOrder[_customer]._SKU;
    }

    function getStep(address _customer) public view returns(step) {
        return CustomerOrder[_customer]._step;
    }
}