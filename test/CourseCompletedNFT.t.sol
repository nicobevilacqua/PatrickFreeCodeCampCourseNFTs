// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

import "../src/CourseCompletedNFT.sol";

contract CourseCompletedNFTTest is Test, IERC721Receiver {
    address private targetAddress;
    CourseCompletedNFT private target;

    function setUp() public {
        targetAddress = vm.envAddress("TARGET");
        console.log(targetAddress);
        target = CourseCompletedNFT(targetAddress);
    }

    function testCourseCompletedNFT() public {
        // deploy my contract
        MyContract myContract = new MyContract();

        // mint NFT
        uint256 tokenId = target.mintNft(address(myContract), bytes4(keccak256(bytes("doSomething2()"))));

        // the NFT id is the returned value minus 1
        tokenId -= 1;

        console.log(tokenId);

        // send NFT to my wallet
        target.safeTransferFrom(address(this), msg.sender, tokenId);

        // NFT owner should be my wallet address
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
