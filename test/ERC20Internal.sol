pragma solidity ^0.8.0;

import "../src/ERC20.sol";
import {PropertiesConstants} from "lib/properties/contracts/util/PropertiesConstants.sol";
import {CryticERC20BasicProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20BasicProperties.sol";
import {CryticERC20BurnableProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20BurnableProperties.sol";
import {CryticERC20MintableProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20MintableProperties.sol";

contract ERC20InternalHarness is
    MyToken,
    CryticERC20BasicProperties,
    CryticERC20BurnableProperties,
    CryticERC20MintableProperties
{   
    constructor() {
        _mint(USER1, INITIAL_BALANCE);
        _mint(USER2, INITIAL_BALANCE);
        _mint(USER3, INITIAL_BALANCE);
        _mint(msg.sender, INITIAL_BALANCE);

        initialSupply = totalSupply();
        isMintableOrBurnable = true;
    }
    function mint(address to, uint256 amount) public override(CryticERC20MintableProperties, MyToken) {
        MyToken.mint(to, amount);
    }
    function transfer(address to, uint256 value) public override(ERC20, MyToken) returns (bool) {
        return MyToken.transfer(to, value);
    }
    function transferFrom(address from, address to, uint256 value) public override(ERC20, MyToken) returns (bool) {
        return MyToken.transferFrom(from, to, value);
    }
    function balanceOf(address account) public view virtual override(ERC20, MyToken) returns (uint256) {
        return MyToken.balanceOf(account);
    }
}