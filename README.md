# Auction Contract

This repository contains the implementation of a smart contract for conducting auctions on the Ethereum blockchain. The contract is written in Solidity and enables the creation of simple timed auctions where participants can bid, and the highest bidder wins when the auction ends.

## Features

- **Start and End Auctions**: The contract allows defining a specific duration for the auction.
- **Place Bids**: Participants can place bids, and the highest bidder is tracked.
- **Withdraw Overbid**: Non-winning bidders can withdraw their funds after the auction ends.
- **Transfer Ownership**: The auction creator can transfer ownership of the auctioned item to the winner.

## Requirements

- **Ethereum Development Environment**: A local or remote Ethereum network.
- **Node.js and npm**: For managing dependencies and scripts.
- **Solidity**: The contract is written in Solidity (recommended version: `^0.8.0`).
- **Foundry**: For deploying and testing the contract.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Hh440/AuctionContract.git
   cd AuctionContract
   ```

2. Install Foundry:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

3. Compile the smart contract:
   ```bash
   forge build
   ```

## Deployment

Deploy the contract to a local or test Ethereum network using Foundry:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url <network-url> --private-key <private-key>
```

Replace `<network-url>` with the appropriate network (e.g., `localhost`, `goerli`, etc.) and `<private-key>` with your wallet's private key.

## Usage

### Interacting with the Contract

1. **Create an Auction**
   The auction creator can start an auction by specifying the duration and initial parameters. The details are set during contract deployment.

2. **Place a Bid**
   Bidders can place their bids by sending Ether to the contract using the `bid` function.

   Example in JavaScript:
   ```javascript
   const tx = await contract.bid({ value: ethers.utils.parseEther("1.0") });
   await tx.wait();
   ```

3. **End Auction**
   The auction ends automatically after the defined duration. The owner can call the `endAuction` function to finalize the process.

4. **Withdraw Funds**
   Non-winning participants can withdraw their bids by calling the `withdraw` function.

## Testing

Run the tests using Foundry:

```bash
forge test
```

## Contract Functions

### Public Functions

- `startAuction(uint _biddingTime)`: Starts the auction with a specific duration.
- `bid()`: Allows participants to place bids.
- `endAuction()`: Ends the auction and determines the winner.
- `withdraw()`: Allows non-winning bidders to withdraw their funds.

### Events

- `AuctionStarted(address owner, uint endTime)`
- `BidPlaced(address bidder, uint amount)`
- `AuctionEnded(address winner, uint amount)`

## Security Considerations

- Ensure only authorized users can start an auction.
- Avoid reentrancy attacks in the `withdraw` function by using the Checks-Effects-Interactions pattern.
- Handle edge cases like zero bids gracefully.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
