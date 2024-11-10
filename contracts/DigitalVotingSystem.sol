// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; // Specify the version of Solidity used

//This project will be based in Brazil's voting system
//Where citizen enter the number reffered to the candidate they are voting for and confirming
//Or they can not vote to any of the them.

//Creating contract
contract Election{
    //Structure to store candidate details
    struct Candidate {
        uint id; //Unique identifier for the candidate
        string name; //name of the candidate
        uint voteCount; //Number of votes the candidate has received
    }

    //Mapping of candidate IDs to their corresponding candidate structure
    mapping(uint => Candidate) public candidates;

    //Mapping to track whether an address has already voted
    mapping(address => bool) public hasVoted;

    //Variable to track the total number of votes
    uint public totalVotes;

    //variable to track the number of white votes (no candidate selected)
    uint public whiteVotes;

    //Event to log voting actions
    event VoteCasted(address voter, uint candidateId);

    //Constructor to initialize the contract
    constructor(){
        //Adding twovalid  candidates with unique IDs and names
        addCandidate(13, "Candidate A");
        addCandidate(22, "Candidate B");
    }

}