// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/interfaces/Ownerable.sol";
import "contracts/core/interfaces/Countable.sol";
import "contracts/core/models/Tag.sol";

contract Tags is Ownerable, Countable {
    mapping (uint256 => Tag) tags;

    function add(string calldata _name) public isOwner {
        incrementCount();
        tags[_count] = Tag({id: _count, name: _name});
    }

    function get(uint256 _index) public view returns (Tag memory) {
        Tag storage tag = tags[_index];
        return tag;
    }
}