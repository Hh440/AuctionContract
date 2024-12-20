// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/AuctionContract.sol";

contract TestContract is Test {
    AuctionContract c;
    

    address owner=  address(this);
    address bidder1= address(0x82Eb1ae21D52821EEb195F2c2c0D40e66b33c97D);

    address bidder2 = address(0xDF40e7cb2bfCccb796D879ce074f70d68a1De73b);

    function setUp() public {
        c = new AuctionContract{value:1 ether}(1 ether);
    }



    function testInitialValue() public{
        assertEq(c.owner(),owner,"ok");
        assertEq(c.highestBidder(), address(0),"ok");
        assertEq(c.maxAmount(), 1 ether,"ok");
        
    }



    function testBid() public {

        vm.deal(bidder1, 2 ether);
       vm.prank(bidder1);

        c.bid{value:2 ether}(2 ether);


        assertEq(c.highestBidder(),bidder1 ,"ok");

        assertEq(c.maxAmount(), 2 ether,"ok");

    }


    function testRefund() public{
        

        // putting some ether in respective bidder address
        vm.deal(bidder1,5 ether);
        vm.deal(bidder2,9 ether);

        // bidder 1 bids 
         vm.prank(bidder1);
         c.bid{value: 2 ether}(2 ether);
         assertEq(c.highestBidder(), bidder1,"ok");
         assertEq(c.maxAmount(),2 ether,"ok");
        
         


         // bidder 2 bids

         vm.prank(bidder2);
         c.bid{value: 4 ether}(4 ether);
         assertEq(c.highestBidder(), bidder2,"ok");
         assertEq(c.maxAmount(),4 ether,"ok");
         

         assertEq(c.previousBidderAddress(),bidder1,"ok");
                
    }


    function testEnd() public {

        

         vm.deal(bidder1,5 ether);
        vm.deal(bidder2,9 ether);
        vm.deal(owner,3 ether);

        // bidder 1 bids 
         vm.prank(bidder1);
         c.bid{value: 2 ether}(2 ether);
         assertEq(c.highestBidder(), bidder1,"ok");
         assertEq(c.maxAmount(),2 ether,"ok");
        
         


         // bidder 2 bids

         vm.prank(bidder2);
         c.bid{value: 4 ether}(4 ether);
         assertEq(c.highestBidder(), bidder2,"ok");
         assertEq(c.maxAmount(),4 ether,"ok");
         
         vm.prank(owner);
         c.endFunc();

         assertTrue(c.endAuction());

        
        
    }

    
}
