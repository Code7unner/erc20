pragma solidity ^0.8.0;

import "./ERC20.sol";

contract LimbusToken is ERC20 {
    constructor(uint256 initialBalance) ERC20("LimbusToken", "LTX") public {
      _mint(msg.sender, initialBalance);
    }
}