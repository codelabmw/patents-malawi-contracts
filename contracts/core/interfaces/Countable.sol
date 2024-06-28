// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Countable {
    uint _count = 0;

    function incrementCount() internal {
        _count++;
    }

    function decrementCount() internal {
        _count--;
    }

    function count() public view returns (uint256) {
        return _count;
    }
}