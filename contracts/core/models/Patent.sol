// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/models/Profile.sol";
import "contracts/core/models/Category.sol";

struct Patent {
    uint id;
    string title;
    string summary;
    string body;
    uint created_at;
    uint updated_at;
    string category;
    string[] tags;
    string user;
    address author;
}

struct PatentResource {
    uint id;
    string title;
    string summary;
    string body;
    uint created_at;
    uint updated_at;
    Category category;
    uint[] tags;
    Profile author;
}