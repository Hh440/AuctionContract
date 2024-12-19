// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import {console} from "forge-std/console.sol";

contract AuctionContract{
    address public owner;
    uint public startingAmount;
    uint public maxAmount;
    address public  highestBidder;
    address public previousBidderAddress;

     bool endAuction ;

     event NewBid(address indexed bidder,uint amount);
     event AuctionEnded(address winner,uint amount);
     event RefundIssued(address indexed refund, uint amount);
    

    constructor(uint _startingAmount) payable {
        owner=msg.sender;
        startingAmount=_startingAmount;
        maxAmount=startingAmount;
        highestBidder=address(0);

        endAuction=false;

    }

    modifier onlyOwner(){
        require(msg.sender==owner);
        _;

    }

    modifier auctionOngoing(){
         require(endAuction==false,"Auction is not open");
         _;
    }


    function refund(address previousBidder, uint amount) internal  auctionOngoing{

        previousBidderAddress=previousBidder;
       
        payable (previousBidder).transfer(amount);



        emit RefundIssued(previousBidder, amount);

    }

    function bid(uint value) public payable  auctionOngoing {
         require(msg.sender != owner, "Owner cannot place bids");
        require(value>maxAmount,"Bid the amount higher the current highest bid");
        if(highestBidder!=address(0)){
            refund(highestBidder, maxAmount);
        }

        maxAmount=value;
        console.logAddress(msg.sender);
        highestBidder=msg.sender;
        emit NewBid(highestBidder,maxAmount);

        
    
    }

    function bidder() public view returns (address){
        return highestBidder;
    }


    function endFunc() public  onlyOwner auctionOngoing{
        endAuction=true;
        
        if(maxAmount!=startingAmount){
            payable (owner).transfer(maxAmount);
        }
        emit AuctionEnded(highestBidder, maxAmount);
       


    }
    

    
}