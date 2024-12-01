# Project-Degen-Token-ERC-20-Unlocking-the-Future-of-Gaming
# DegenTokenERC20

## Description

The goal of the project is to create an ERC20 token named Degen and it's symbol is 'DGN' then deploy it using HardHat or Remix. Once deployed, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens. In this project:

- Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards.
- Only the owner can mint tokens.
- Transferring tokens: Players should be able to transfer their tokens to others.
- Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
- Checking token balance: Players should be able to check their token balance at any time.
- Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

## Getting Started

### Executing program

In order to run this program, it is recommended to copy the whole code and run it in Remix or HardHat. The code can be copied below:

```
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
```

After copying it, compiling it will make the contract deployable and ready for interaction.

Find "MyToken.sol" in my contracts folder. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.4" (or another compatible version), and then click on the "Compile MyToken.sol" button.
Once the code is compiled, you can deploy the contract by clicking the "Deploy & Run Transactions" tab in the left-hand sidebar. but before that you will change your environment in the top to "injected Provider", to connect your metamask wallet. Select the "MyToken" contract from the dropdown menu, and click on the "Deploy" button a pop-up window will show click confirm and wait for the contract ro be deployed.

Once the contract is deployed, you can interact with it by copying the Account Address in the Deploy & Run Transactions" tab then go to Deployed contracts click the drop down arrow for the mint and paste the copied address the add your value then click transact to add value for your token. To see the token value the click the balanceof below. then to see the symbol, decimal, and name of the token just click the following buttons. To Send RP you need click the drop down arrow of SendRP then copy and paste the Account Address to the spender box then add your value below before clicking the transact. To Redeem tokens just add a value you want to redeem then click the button, it is just the same with ReduceRP. 

To test this copy the address of the deployed contract in the Deployed Contracts. Then paste it in the HOLESKY TESNET BLOCK EXPLORER to find your token. You will see all the transactions you have dine


P.S
I didn't use the Avalanche Fuji Testnet and Snowtrace because my MetaMask Wallet doesn't have any AVAX value in my account and i can't find a way to connect it, I already ask for help within the Avalanche discord community they say that i need to have a transaction or have a balance in my wallet to work and their website is faulty thats why i use the HOLESKY NETWORK and HOLESKY TESNET BLOCK EXPLORER for my token.

## Authors
@Dracogray24
