// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/core/services/Patents.sol";
import "contracts/core/services/Profiles.sol";
import "contracts/core/services/Categories.sol";
import "contracts/core/services/Tags.sol";

contract Storage {
    Patents public pantents;
    Profiles public profiles;
    Categories public categories;
    Tags public  tags;

    constructor() {
        pantents = new Patents();
        profiles = new Profiles();
        categories = new Categories();
        tags = new Tags();
    }
}