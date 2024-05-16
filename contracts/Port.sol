// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PortDAO {
    address public owner;
    uint256 public proposalCount;

    struct Proposal {
        uint256 id;
        string description;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Proposal) public proposals;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event ProposalCreated(uint256 indexed proposalId, string description);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support);
    event ProposalExecuted(uint256 indexed proposalId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function createProposal(string memory description) public {
        proposalCount++;
        Proposal storage newProposal = proposals[proposalCount];
        newProposal.id = proposalCount;
        newProposal.description = description;
        newProposal.forVotes = 0;
        newProposal.againstVotes = 0;
        newProposal.executed = false;
        emit ProposalCreated(proposalCount, description);
}

    function vote(uint256 proposalId, bool support) public {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(!proposal.voters[msg.sender], "You already voted");

        if (support) {
            proposal.forVotes++;
        } else {
            proposal.againstVotes++;
        }

        proposal.voters[msg.sender] = true;
        emit Voted(proposalId, msg.sender, support);
    }

    function executeProposal(uint256 proposalId) public onlyOwner {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        uint256 totalVotes = proposal.forVotes + proposal.againstVotes;
        require(totalVotes > 0, "No votes casted for this proposal");

        // Check if the proposal has enough support to execute
        if ((proposal.forVotes * 100) / totalVotes > 50) {
            proposal.executed = true;
            // Perform actions based on the proposal
            // For simplicity, let's emit an event here
            emit ProposalExecuted(proposalId);
        }
    }

    // Optional functions
    function getProposalCount() public view returns (uint256) {
        return proposalCount;
    }
}
