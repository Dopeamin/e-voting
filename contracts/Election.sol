pragma solidity ^0.5.12;

// We declare the smart contract with the "contract" keyword
contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Read/write candidates
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;

    // Event to be emitted when a vote is cast
    event votedEvent(
        uint indexed _candidateId
    );

    // Constructor that gets called when the smart contract is deployed to the blockchain
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        // Require that they haven't voted before
        require(!voters[msg.sender], "The voter has already voted.");

        // Require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate to vote for.");

        // Record that voter has voted
        voters[msg.sender] = true;

        // Update candidate vote count
        candidates[_candidateId].voteCount++;

        // Emit the voted event
        emit votedEvent(_candidateId);
    }
}
