// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Ownerable {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner {
        require(owner == msg.sender, "Only authorized personel can add new entries.");
        _;
    }
}