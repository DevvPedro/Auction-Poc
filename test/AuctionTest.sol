// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Auction.sol";
import "../src/Auctionattack.sol";

contract ContractTest is Test {
    Auction auction;
    Auctionattack auctionattack;

    address attacker = address(1);
    address bobby = address(2);
    address pepe = address(3);

    function setUp() public {
    //Sets up the addresses with 13 ether each.

        vm.deal(attacker, 13 ether);
        vm.deal(bobby, 13 ether);
        vm.deal(pepe, 13 ether);
    
    //pepe deploys auction contract and lists an NFT
        vm.startPrank(pepe);
        auction = new Auction();
        auction.list{value : 1 ether}();
        vm.stopPrank();

    // attacker deploys auctionattack and bids for the NFT with a malicious contract
        vm.startPrank(attacker);
        auctionattack = new Auctionattack(address(auction));
        auctionattack.attack{value : 2 ether}(0);
        vm.stopPrank();
    }

    // address bobby tries to call the contract but reverts with error string.

    function testAttack() public {
        vm.expectRevert(abi.encodePacked('......'));
        vm.prank(bobby);
        auction.bid{value : 5 ether}(0);
    }
    }
