// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Voting{
    uint _votersId;
    uint startTime;
    address owner;
    enum Parties {
        APC,
        PDP,
        LP
    }
    struct Voter{
        address voter;
        string voterName;
        uint votersID;
        Parties parties;
    }
    mapping (uint => Voter) public  mapVoter;

    constructor(){
        owner = msg.sender;
    }
    modifier  onlyOwner(){
      require(msg.sender == owner, "only Owner can start election");
      _;
  }

     function startElection() public onlyOwner returns (uint)  {
     return  startTime = block.timestamp;
     }
    function vote(  string memory _voterName, Parties _parties) public  {
    require (  block.timestamp - startTime <= 28800, "time for voting elapsed");
    Voter storage voters = mapVoter[_votersId];
    _votersId +=1;
    mapVoter[_votersId].voterName =  _voterName;
    mapVoter[_votersId].votersID  = _votersId;
     mapVoter[_votersId].voter = msg.sender;
     mapVoter[_votersId].parties =  _parties;
    }
    function getVotersDetails(uint votersId) public view onlyOwner returns(string memory, address, Parties){
        Voter storage voters = mapVoter[votersId];
        return (voters.voterName, voters.voter, voters.parties);
    }
    function getResult(uint votersId) public view returns ( Parties , string memory){
         Voter storage voters = mapVoter[votersId];
       if (voters.parties == Parties.APC){
           return  (voters.parties, "APC");
       } else  if (voters.parties == Parties.PDP){
             return  (voters.parties, "PDP");
       }else if(voters.parties == Parties.LP){
         return  (voters.parties, "LP");
       }
    }
  
}


















