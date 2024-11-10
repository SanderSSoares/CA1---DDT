// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; // Specify the version of Solidity used

//This project will be based in Brazil's voting system
//Where citizen enter the number reffered to the candidate they are voting for and confirming
//Or they can not vote to any of the them.

contract Election{
    //Structure to store candidate details
    struct Candidate {
        uint id; //Unique identifier for the candidate
        string name; //name of the candidate
        uint voteCount; //Number of votes the candidate has received
    }
}