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

    function some(uint _limit, uint _offset) public view returns (Category[] memory) {
        _limit = _limit >= _count ? _count : _limit;
        _offset = _offset <= 0 ? 1 : _offset > _count ? _count : _offset;
        
        Category[] memory _categories = new Category[](_limit);

        for (uint i; i < _limit; i++) {
            _categories[i] = categories[i + _offset];
        }

        return _categories;
    }

    function update(uint _index, string calldata _name) public {
        require(_index >= _count || _index <= _count, "No item with the given index found.");
        categories[_index].name = _name;
    }

    function remove(uint _index) public {
        delete categories[_index];
        decrementCount();
    }
}