// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DemoUpgradeableV1 is Initializable, OwnableUpgradeable {
    uint256 public value;

    function setValue(uint256 _value) public virtual {
        value = _value;
    }

    function getValue() public view virtual returns (uint256) {
        return value;
    }

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
    }
}