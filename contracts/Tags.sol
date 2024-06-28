// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/interfaces/Ownerable.sol";
import "contracts/core/interfaces/Countable.sol";
import "contracts/core/models/Tag.sol";

contract Tags is Ownerable, Countable {
    mapping(uint256 => Tag) tags;

    function add(string calldata _name) public isOwner {
        incrementCount();
        tags[_count] = Tag({id: _count, name: _name});
    }

    function get(uint256 _index) public view returns (Tag memory) {
        Tag storage tag = tags[_index];
        return tag;
    }

    function some(uint256 _limit, uint256 _offset)
        public
        view
        returns (Tag[] memory)
    {
        _limit = _limit >= _count ? _count : _limit;
        _offset = _offset <= 0 ? 1 : _offset > _count ? _count : _offset;
        
        Tag[] memory _tags = new Tag[](_limit);

        for (uint256 i; i < _limit; i++) {
            _tags[i] = tags[i + _offset];
        }

        return _tags;
    }

    function update(uint _index, string calldata _name) public {
        require(_index >= _count || _index <= _count, "No item with the given index found.");
        tags[_index].name = _name;
    }

    function remove(uint _index) public {
        delete tags[_index];
        decrementCount();
    }
}
