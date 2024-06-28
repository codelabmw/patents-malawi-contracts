// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/models/Category.sol";
import "contracts/core/interfaces/Ownerable.sol";
import "contracts/core/interfaces/Countable.sol";

contract Categories is Ownerable, Countable {
    mapping(uint => Category) categories;

    function add(string calldata _name) public isOwner {
        incrementCount();
        categories[_count] = Category({id: _count, name: _name});
    }

    function get(uint _index) public view returns (Category memory) {
        return categories[_index];
    }

    function all() public view returns (Category[] memory _categories) {
        _categories = new Category[](_count);

        for (uint i; i < _count; i++) {
            uint index = i + 1;
            _categories[index] = categories[index];
        }

        return _categories;
    }
}
