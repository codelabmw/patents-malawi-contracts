// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/interfaces/Countable.sol";
import "contracts/core/models/Patent.sol";

contract Patents is Countable {
    mapping(uint256 => Patent) patents;

    function add(
        string calldata _title,
        string calldata _summary,
        string calldata _body,
        uint256 _category_id,
        uint256[] calldata _tags
    ) public {
        incrementCount();
        patents[_count] = Patent({
            id: _count,
            title: _title,
            summary: _summary,
            body: _body,
            created_at: block.timestamp,
            updated_at: block.timestamp,
            category_id: _category_id,
            tags: _tags,
            author: msg.sender
        });
    }

    function get(uint256 _index) public view returns (Patent memory) {
        return patents[_index];
    }

    function some(uint256 _limit, uint256 _offset)
        public
        view
        returns (Patent[] memory)
    {
        _limit = _limit >= _count ? _count : _limit;
        _offset = _offset <= 0 ? 1 : _offset > _count ? _count : _offset;

        Patent[] memory _patents = new Patent[](_limit);

        for (uint256 i; i < _limit; i++) {
            _patents[i] = patents[i + _offset];
        }

        return _patents;
    }

    function update(
        uint256 _index,
        string calldata _title,
        string calldata _summary,
        string calldata _body,
        uint256 _category_id,
        uint256[] calldata _tags
    ) public {
        require(
            _index >= _count || _index <= _count,
            "No item with the given index found."
        );

        Patent storage patent = patents[_index];

        patent.title = _title;
        patent.summary = _summary;
        patent.body = _body;
        patent.updated_at = block.timestamp;
        patent.category_id = _category_id;
        patent.tags = _tags;
    }

    function remove(uint256 _index) public {
        delete patents[_index];
        decrementCount();
    }
}
