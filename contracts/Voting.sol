// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

// @title Voting contract for 0xDePaul
// @author boopowo
// @notice Not finished pls don't use. Actually idk if it actually works. IT DOESN'T WORK

contract Voting {

    //Put events here I guess 

    //Counts the number of total proposals. Also useful for proposalId
    uint proposalCount = 0;
    uint ongoingProposal = 0;

    //Single proposal
    struct Proposal {
        //Data Types TBD
        uint proposalId;
        string proposalName;
        string proposalDescription;
        address proposalMaker;
        uint duration;
        uint totalVotes;
        uint yesVotes;
        uint noVotes;
        bool succeeded;
    }

    //Single member
    struct Member {
        string name;
        address memberAddress;
        bool hasVoted;
    }

    //Array of proposals
    Proposal[] public proposals;

    //Maps address to Member
    mapping(address => Member) public members;

    //Requires msg.sender to be a member
    modifier isMember() {
        require(members[msg.sender].memberAddress == msg.sender);
        _;
    }

    //addMember
    function addMember() internal {

    }

    //Members can propose
    function propose(string memory _name, string memory _description, uint256 _duration) internal isMember{
        //Adding proposal to array with arguments and adds 1 to proposalCount
        proposals.push(Proposal(proposalCount ,_name, _description, msg.sender, block.timestamp + _duration, 0, 0, 0, false));
        proposalCount++;
    }

    //Member vote
    function vote(bool choice) internal isMember{
        //Require that the address is a member of the club AND has not voted on the proposal yet AND is not the proposal creator AND voting time hasn't ended
        require(members[msg.sender].hasVoted == false && msg.sender != proposals[ongoingProposal].proposalMaker && proposals[ongoingProposal].duration > block.timestamp);

        //Registers vote in proposal
        if(choice == true){
            proposals[ongoingProposal].yesVotes++;
            proposals[ongoingProposal].totalVotes++;
        } else {
            proposals[ongoingProposal].noVotes++;
            proposals[ongoingProposal].totalVotes++;
        }

        //Makes sure the member cannot vote twice on the proposal
        members[msg.sender].hasVoted = true;
    }

    //Returns result of a previous proposal
    function viewProposalResult(uint _proposalId) public view returns(bool) {
        //The proposal has to be finished voting
        require(proposals[_proposalId].duration < block.timestamp && _proposalId < ongoingProposal, "Voting has not finished yet");
        return proposals[_proposalId].succeeded;
        }
    }
