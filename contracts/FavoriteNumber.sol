// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract FavoriteNumber {

  uint public numberFavorite;

  function setNumberFavory(uint _number) external {
      numberFavorite = _number;
  }

}
