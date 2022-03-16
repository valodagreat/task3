//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    uint256 public constant priceOfToken = 0.001 ether;
    uint256 public constant fixedTotalSupply = 1000000 * 10**18;
    
    constructor () ERC20("ValToken", "VKT"){

    }

    function buyToken (address receiver, uint256 amount) public payable {
        uint256 _cost = priceOfToken * amount;
        require(msg.value == _cost, "Ether sent is incorrect");
        uint256 amountWithDecimals = amount * 10**18;
        require((totalSupply() + amountWithDecimals) <= fixedTotalSupply,"Maximum supply reached.");
        _mint(receiver, amountWithDecimals);
    }

    receive() external payable {}

    fallback() external payable {}
}