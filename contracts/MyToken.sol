// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

// ERC20 token with specific parameters, burn, mint, and pause functionality
contract CustomToken is ERC20, Ownable, Pausable {
    uint8 private _decimals;
    uint256 public constant REDEMPTION_RATE = 100;
    mapping(address => uint256) public RPOwned;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _decimals = 18;
        _mint(msg.sender, 100 * 10 ** uint256(_decimals));
    }

    // Override decimals function to use the custom decimals set before deployment
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    // Function to mint new tokens, only owner can call
    function SendRP(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens from the sender's account
    function ReduceRP(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to pause all token transfers, only owner can call
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause all token transfers, only owner can call
    function unpause() public onlyOwner {
        _unpause();
    }

    function RedeemRP(uint256 quantity) public {
        uint256 cost = REDEMPTION_RATE * quantity;
        require(balanceOf(msg.sender) >= cost, "Not enough tokens to redeem for a sword");

        RPOwned[msg.sender] += quantity;
        _burn(msg.sender, cost);
    }
}