// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

import "../src/BlockchainBasicsNFT.sol";

contract BlockchainBasicsNFTTest is Test, IERC721Receiver {
    address private targetAddress;
    BlockchainBasicsNFT private target;

    function setUp() public {
        targetAddress = vm.envAddress("TARGET");
        target = BlockchainBasicsNFT(targetAddress);
    }

    function testBlockchainBasicsNFT() public {
        uint256 tokenId = target.mintNft();

        target.safeTransferFrom(address(this), msg.sender, tokenId);

        assertTrue(target.ownerOf(tokenId) == msg.sender);
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
