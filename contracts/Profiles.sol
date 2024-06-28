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

    function get(address _address) public view returns (Profile memory) {
        return profiles[_address];
    }

    function update(address _address, string calldata _name, string calldata _email, string calldata _phone) public {
        Profile storage profile = profiles[_address];
        profile.name = _name;
        profile.email = _email;
        profile.phone = _phone;
    }
}
