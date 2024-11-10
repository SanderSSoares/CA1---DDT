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

    //variable to track the number of blank votes (no candidate selected)
    uint public blankVotes;

    //Event to log voting actions
    event VoteCasted(address voter, uint candidateId);

    //Constructor to initialize the contract
    constructor(){
        //Adding twovalid  candidates with unique IDs and names
        addCandidate(13, "Candidate A");
        addCandidate(22, "Candidate B");
    }

    //Function to add candidate to the candidates mapping
    function addCandidate(uint _id, string memory _name) internal {
        candidates[_id] = Candidate(_id, _name, 0); //Initialize a new candidate
    }

    //Function to allow citizen to vote for a candidate or cast a blank vote
    function vote(uint _candidateId) public{

        //Check first if the citizen has already voted
        require(!hasVoted[msg.sender], "You have already voted.");
        //Validate the candidates' ID (0 for abstaining)
        require(
            _candidateId ==13 || _candidateId ==22 || _candidateId ==0, "Invalid candidate ID. Press 0 if you with to Abstain."
        );

        //Increament vote count for abstained votes
        if (_candidateId ==0){
            blankVotes++;
        }else{
            //Increment vote count for the selected candidate
            candidates[_candidateId].voteCount++;
        }
        
        totalVotes++; //To increment thet total vote count
        hasVoted[msg.sender] = true; //Mark the citizen as having voted
        emit VoteCasted(msg.sender, _candidateId); //Emitting voting evento to log the action on the blockchain
    }

    //Now we want to retrieve the voting results
    //Returns an array with votes for candidate 13, candidate 22, and blank(abstained) votes
    function getResults() public view returns (uint[3] memory){
        uint[3] memory results;
        results[0] = candidates[13].voteCount; //Votes for candidate 13
        results[1] = candidates[22].voteCount; //Votes for candidate 22
        results[2] = blankVotes; //Number of abstained votes
        return results; //Results the results as an array
    }

    //Now to reset teh vote counts
    //This is improtant for testing and to make sure the deviec will be fully reseted for next election

    function resetVotes() public{
        candidates[13].voteCount=0; //Reseting votes for both candidates
        candidates[22].voteCount=0;

        blankVotes=0;//REseting the abstained and total votes
        totalVotes=0;
    }

}