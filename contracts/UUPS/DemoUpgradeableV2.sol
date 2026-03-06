// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./DemoUpgradeableV1.sol";

contract DemoUpgradeableV2 is DemoUpgradeableV1 {
    uint256 public newValue; // 新增状态变量

    function setValue(uint256 _newValue) public virtual override {
        newValue = _newValue;
    }

    function getValue() public view virtual override returns (uint256) {
        return value + newValue;
    }
}