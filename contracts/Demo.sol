// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 1. 引入 Chainlink 的接口
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Demo {
    // uint256 public value;

    // 2. 声明一个状态变量来保存 Chainlink 预言机的地址
    AggregatorV3Interface internal priceFeed;

    /**
     * 3. 构造函数：部署合约时需要指定要使用哪个价格源
     * 例如：ETH/USD 在 Sepolia 测试网的地址是 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor(address _priceFeedAddress) {
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    /**
     * 4. 核心功能：获取最新价格
     * 返回值：ETH 价格，带 8 位小数（例如 2000.12345678 表示 $2000.12）
     */
    function getLatestPrice() public view returns (int) {
        // 调用预言机合约的 latestRoundData 函数
        (
            /* uint80 roundID */,
            int price,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();
        
        // 返回价格
        return price;
    }

    /**
     * 5. 辅助功能：获取价格的小数位数
     * 通常 ETH/USD 是 8 位小数
     */
    function getDecimals() public view returns (uint8) {
        return priceFeed.decimals();
    }

    /**
     * latestRoundData() 返回值：
     *   1. 这个函数返回 5 个值，但我们通常只需要 price。
     *   2.其他值（如 roundID, timestamp）可以用来检查数据是否过时（防止预言机宕机返回旧数据）。
     * 数据过时检查（生产环境推荐）
     */
    function getLatestPriceSafe() public view returns (int) {
        (uint80 roundID, int price, , uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // 确保数据不是过时的
        require(answeredInRound >= roundID, "Stale price");
        // 确保数据是在最近 1 小时内更新的
        require(block.timestamp - timeStamp < 1 hours, "Stale price");
        return price;
    }

    // // 获取带小数点的价格字符串（用于展示）
    // function getFormattedPrice() public pure returns (string memory) { // view - 暂时用pure
    //     int price = 199682999100; // getLatestPrice(); - 暂时写死
    //     uint8 decimals = 8; // getDecimals(); - 暂时写死
        
    //     // 将价格转换为人类可读格式
    //     // 例如：price = 200012345678，decimals = 8
    //     // 实际价格 = 2000.12345678
    //     uint priceInWhole = uint(price) / (10 ** decimals);
    //     uint priceInFraction = uint(price) % (10 ** decimals);
        
    //     // 返回组合后的字符串（这里简单起见，只返回整数部分）
    //     return string(abi.encodePacked(uint2str(priceInWhole), ".", uint2str(priceInFraction)));
    // }

    // // 简单的 uint 转 string 函数（Solidity 原生不支持直接转换）
    // function uint2str(uint _i) internal pure returns (string memory str) {
    //     if (_i == 0) return "0";
    //     uint j = _i;
    //     uint length;
    //     while (j != 0) {
    //         length++;
    //         j /= 10;
    //     }
    //     bytes memory bstr = new bytes(length);
    //     uint k = length;
    //     while (_i != 0) {
    //         k = k-1;
    //         uint8 temp = (48 + uint8(_i - _i / 10 * 10));
    //         bytes1 b1 = bytes1(temp);
    //         bstr[k] = b1;
    //         _i /= 10;
    //     }
    //     str = string(bstr);
    // }

    // function setValue(uint256 _value) public virtual {
    //     value = _value;
    // }

    // function getValue() public view virtual returns (uint256) {
    //     return value;
    // }
}