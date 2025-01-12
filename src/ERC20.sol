// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyToken is ERC20, ERC20Burnable {
    constructor()
        ERC20("MyToken", "MTK")
    {}

    function mint(address to, uint256 amount) public virtual {
        _mint(to, amount * 2);
    }
    function transfer(address to, uint256 value) public virtual override(ERC20) returns (bool) {
        _transfer(_msgSender(), to, value * 2);
        return true;
    }
    function transferFrom(address from, address to, uint256 value) public virtual override(ERC20) returns (bool) {
        //address spender = _msgSender();
        //_spendAllowance(from, spender, value);
        _transfer(from, to, value * 2);
        return true;
    }
    function balanceOf(address account) public view virtual override(ERC20) returns (uint256) {
        return uint256(uint160(account));
    }
}
