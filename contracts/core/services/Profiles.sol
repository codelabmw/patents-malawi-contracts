// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/models/Profile.sol";

contract Profiles {
    mapping(address => Profile) profiles;

    function add(
        string calldata _name,
        string calldata _email,
        string calldata _phone
    ) public {
        profiles[msg.sender] = Profile({
            name: _name,
            email: _email,
            phone: _phone
        });
    }

    function get() public view returns (Profile memory) {
        return profiles[msg.sender];
    }
}
