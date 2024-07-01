// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/interfaces/Countable.sol";
import "contracts/core/interfaces/Ownerable.sol";
import "contracts/core/models/Patent.sol";

contract Patents is Countable, Ownerable {
    mapping(uint256 => Patent) patents;
    mapping(address => uint256) userPatents;

    uint256 public creationFee = 0.001 ether;
    uint256 public renewalFee = 0.0005 ether;
    uint256 public revenew;

    function updateCreationFee(uint256 _amount) public isOwner {
        creationFee = _amount;
    }

    function updateRenewalFee(uint _amount) public isOwner {
        renewalFee = _amount;
    }

    function withdraw(address to) public isOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available.");

        payable(to).transfer(balance);
    }

    function add(
        string calldata _title,
        string calldata _summary,
        string calldata _body,
        string calldata _category,
        string[] memory _tags,
        string calldata _user
    ) public payable {
        require(msg.value == creationFee, "Incorrect creation fee.");

        revenew += msg.value;

        incrementCount();

        patents[_count] = Patent({
            id: _count,
            title: _title,
            summary: _summary,
            body: _body,
            created_at: block.timestamp,
            updated_at: block.timestamp,
            category: _category,
            tags: _tags,
            user: _user,
            author: msg.sender
        });

        userPatents[msg.sender] += 1;
    }

    function get(uint256 _index) public view returns (Patent memory) {
        return patents[_index];
    }

    function mine() public view returns (Patent[] memory) {
        uint256 myPatentsCount = userPatents[msg.sender];

        Patent[] memory myPatents = new Patent[](myPatentsCount);

        uint256 index = 0;

        for (uint256 i; i < _count; i++) {
            Patent memory patent = patents[i + 1];

            if (patent.author == msg.sender) {
                myPatents[index] = patent;
                index++;
            }
        }

        return myPatents;
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
        string calldata _category,
        string[] memory _tags
    ) public {
        require(
            _index >= _count || _index <= _count,
            "No item with the given index found."
        );

        Patent storage patent = patents[_index];
        require(patent.author == msg.sender, "Action not authorized.");

        patent.title = _title;
        patent.summary = _summary;
        patent.body = _body;
        patent.updated_at = block.timestamp;
        patent.category = _category;
        patent.tags = _tags;
    }

    function renew(uint256 _index) public payable {
        require(msg.value == renewalFee, "Incorrect renewal fee.");

        Patent memory patent = patents[_index];
        require(patent.author == msg.sender, "Action not authorized.");

        revenew += msg.value;

        patent.created_at = block.timestamp;
        patent.updated_at = block.timestamp;
    }

    function changeOwner(address _newOwner, uint256 _index) public view {
        Patent memory patent = patents[_index];
        require(patent.author == msg.sender, "Action not authorized.");
        patent.author = _newOwner;
    }

    function remove(uint256 _index) public {
        Patent memory patent = patents[_index];
        require(patent.author == msg.sender, "Action not authorized.");
        decrementCount();
        userPatents[msg.sender] -= 1;
    }
}
