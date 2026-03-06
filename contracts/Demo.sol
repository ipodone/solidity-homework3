// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Demo {
    uint256 public value;

    function setValue(uint256 _value) public virtual {
        value = _value;
    }

    function getValue() public view virtual returns (uint256) {
        return value;
    }
}