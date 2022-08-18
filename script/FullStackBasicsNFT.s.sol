// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import "../src/FullStackBasicsNFT.sol";
import "../src/PatrickHardhatFreeCodeCampToken.sol";

contract FullStackBasicsNFTScript is Script, IERC721Receiver {
    address private constant TOKEN_ADDRESS = 0x5ECEdc30224D9B3b5EE4C2D7ed17C197cb1d263b;
    address private targetAddress;

    FullStackBasicsNFT private target;
    PatrickHardhatFreeCodeCampToken private token;

    function setUp() public {
        targetAddress = vm.envAddress("TARGET");
        target = FullStackBasicsNFT(targetAddress);
        token = PatrickHardhatFreeCodeCampToken(TOKEN_ADDRESS);
    }

    function run() public {
        vm.startBroadcast();

        // mint a token
        token.mintMeAToken();

        // aprove transfer from target
        token.approve(targetAddress, 1e18);

        // mint the nft
        uint256 tokenId = target.mintNft();

        // the NFT id is the returned value minus 1
        tokenId -= 1;
        console.log(tokenId);

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
