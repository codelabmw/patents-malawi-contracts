// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/interfaces/Countable.sol";
import "contracts/core/models/Patent.sol";

contract Patents is Countable {
    mapping(uint256 => Patent) patents;

    function add(
        bytes32 _title,
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

    function get(uint _index) public view returns (Patent memory) {
        return patents[_index];
    }
}