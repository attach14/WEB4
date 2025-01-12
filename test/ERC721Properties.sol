// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {ERC721Properties} from "lib/properties/contracts/ERC721/ERC721Properties.sol";
import {MyToken} from "../src/ERC721.sol";

contract MyTokenProperties is ERC721Properties {
    MyToken private token;
    constructor() {
        token = new MyToken(msg.sender);
        initialize(token);
    }
    function testMint() public {
        uint256 currentId = token.getCurrentTokenId();
        token.mint(msg.sender);
        assertEq(token.balanceOf(msg.sender), 1, "Balance is incorrect after minting");
        assertEq(token.ownerOf(currentId + 1), msg.sender, "Owner is incorrect after minting");
    }

    function testBurn() public {
        uint256 tokenId = token.mint(msg.sender);
        token.burn(tokenId);
        assertEq(token.balanceOf(msg.sender), 0, "Balance is incorrect after burning");
        try token.ownerOf(tokenId) {
            revert("Token was not burned");
        } catch {
        }
    }
}