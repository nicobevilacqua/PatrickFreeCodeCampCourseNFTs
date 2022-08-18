// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

import "../src/BlockchainBasicsNFT.sol";

contract BlockchainBasicsNFTScript is Script, IERC721Receiver {
    address private targetAddress;
    BlockchainBasicsNFT private target;

    function setUp() public {
        targetAddress = vm.envAddress("TARGET");
        console.log(targetAddress);
        target = BlockchainBasicsNFT(targetAddress);
    }

    function run() public {
        vm.startBroadcast();

        // mint NFT
        uint256 tokenId = target.mintNft();

        // the NFT id is the returned value minus 1
        tokenId -= 1;

        console.log(tokenId);

        // send NFT to my wallet
        target.safeTransferFrom(address(this), msg.sender, tokenId);

        // NFT owner should be my wallet address
        require(target.ownerOf(tokenId) == msg.sender, "something went wrong");

        console.log("NFT transfered");

        vm.stopBroadcast();
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
