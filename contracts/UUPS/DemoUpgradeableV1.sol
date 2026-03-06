// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract DemoUpgradeableV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
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

    // ============ UUPS升级授权 ============
    /**
     * @dev 授权升级函数，只有owner可以升级
     */
    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}
}