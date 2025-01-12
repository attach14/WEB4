// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, Ownable {
    uint256 private curId;

    constructor(address initialOwner) ERC721("MyToken", "MTK") Ownable(initialOwner) {}


    function mint(address to) public onlyOwner returns (uint256) {
        curId++;
        uint256 tokenId = curId;
        _mint(to, tokenId);
        return tokenId;
    }

    function burn(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Wrong owner");
        _burn(tokenId);
    }

    function getCurrentTokenId() public view returns (uint256) {
        return curId;
    }
}