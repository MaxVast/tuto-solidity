// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import './Owner.sol';

contract MusiciansManager is Owner {

  event musicianCreated(string _artistName);
  event trackAdded(string _artistName, string _title);
  event getTheTracks(Tracks[] _tracks);
  event getTheMusician(string _artistName);

  struct Tracks {
    string title;
    uint duration;
  }

  struct Musician {
    string artistName;
    Tracks[] tracks;
  }

  mapping(address => Musician) Musicians;

  function addMusician(address _address, string memory _artistName) external isOwner {
    require(bytes(Musicians[_address].artistName).length == 0, "This musician has already been created");
    Musicians[_address].artistName = _artistName;
    emit musicianCreated(_artistName);
  }

  function addTrack(address _address, string memory _title, uint _duration) external isOwner {
    require(bytes(Musicians[_address].artistName).length > 0, "This musicians doesnt not exist");
    Tracks memory thisTrack = Tracks(_title,_duration);
    Musicians[_address].tracks.push(thisTrack);
    emit trackAdded(Musicians[_address].artistName, _title);
  }

  function getTracks(address _address) external {
    emit getTheTracks(Musicians[_address].tracks);
  }

  function getMusician(address _address) external {
    emit getTheMusician(Musicians[_address].artistName);
  }
}
