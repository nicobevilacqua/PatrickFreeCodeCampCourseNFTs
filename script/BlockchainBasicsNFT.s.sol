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
        target = BlockchainBasicsNFT(targetAddress);
    }

    function run() public {
        vm.startBroadcast();

        uint256 tokenId = target.mintNft();
        target.safeTransferFrom(address(this), msg.sender, tokenId);

        require(target.ownerOf(tokenId) == msg.sender, "something went wrong");

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
