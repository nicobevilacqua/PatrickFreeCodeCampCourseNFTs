// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

import "../src/CourseCompletedNFT.sol";

contract CourseCompletedNFTScript is Script, IERC721Receiver {
    address private targetAddress;
    CourseCompletedNFT private target;

    function setUp() public {
        targetAddress = vm.envAddress("TARGET");
        console.log(targetAddress);
        target = CourseCompletedNFT(targetAddress);
    }

    function run() public {
        vm.startBroadcast();
        // deploy my contract
        MyContract myContract = new MyContract();

        // call mintNft
        uint256 tokenId = target.mintNft(address(myContract), bytes4(keccak256(bytes("doSomething2()"))));

        // the NFT id is the returned value minus 1
        tokenId -= 1;

        // new NFT transfered to contract
        console.log("tokenId");
        console.log(tokenId);
        console.log("tokenId");

        // send NFT to my wallet
        target.safeTransferFrom(address(this), msg.sender, tokenId);

        // validate ownership
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
