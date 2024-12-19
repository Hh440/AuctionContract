// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/AuctionContract.sol";

contract TestContract is Test {
    AuctionContract c;

    address bidder1= address(0x82Eb1ae21D52821EEb195F2c2c0D40e66b33c97D);

    address bidder2 = address(0xDF40e7cb2bfCccb796D879ce074f70d68a1De73b);

    function setUp() public {
        c = new AuctionContract(200);
    }



    function testBid() public {
       vm.prank(0x82Eb1ae21D52821EEb195F2c2c0D40e66b33c97D);
        c.bid(400);


        assertEq(c.highestBidder(),0x82Eb1ae21D52821EEb195F2c2c0D40e66b33c97D ,"ok");

        assertEq(c.maxAmount(), 400,"ok");

    }


    function testRefund() public{

         vm.prank(bidder1);
         c.bid(400);

         vm.prank(bidder2);
         c.bid(600);


         c.refund(bidder1,400);

         assertEq(c.highestBidder(), bidder2,"ok");
         assertEq(c.previousBidderAddress(), bidder1,"ok");


        
    }

    
}
