// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 导入并重新导出 OpenZeppelin 的 ERC1967Proxy 合约
// 这个文件用于让 Hardhat 能够编译和部署 ERC1967Proxy
import {ERC1967Proxy as OpenZeppelinERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// 重新导出以便 Hardhat 可以找到
contract UUPSUpgradeableProxy is OpenZeppelinERC1967Proxy {
    constructor(
        address _logic,
        bytes memory _data
    ) OpenZeppelinERC1967Proxy(_logic, _data) {}
}