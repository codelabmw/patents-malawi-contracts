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
    uint category_id;
    uint[] tags; // array of Tag id's
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
    uint[] tags; // array of Tag id's
    Profile author;
}