// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import {ERC20} from "@solmate/tokens/ERC20.sol";

/**
 * @title UnpermissionedTarget
 * @notice A contrived example target contract.
 */
contract UnpermissionedTarget {
  mapping(address => mapping(address => uint256)) public balances;

  // Unpermissioned function - anyone can deposit funds into any address
  function deposit(
    address asset,
    uint256 amount,
    address onBehalfOf
  ) public payable returns (uint256) {
    ERC20 token = ERC20(asset);
    balances[asset][onBehalfOf] += amount;
    token.transferFrom(msg.sender, address(this), amount);

    return balances[asset][onBehalfOf];
  }

  function balance(
    address asset, 
    address depositor
  ) public view returns (uint256) {
    return balances[asset][depositor];
  }
}
