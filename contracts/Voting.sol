// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

// @title Voting contract for 0xDePaul
// @author boopowo
// @notice Not finished pls don't use. Actually idk if it actually works. IT DOESN'T WORK

contract Voting {
    //Single proposal
    struct Proposal {
        string proposalName;
        string proposalDescription;
        address proposalMaker;
        //Data Types TBD
        uint256 duration;
        uint256 totalVotes;
        uint256 yesVotes;
        uint256 noVotes;
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

    //Members can propose
    function propose(string memory _name, string memory _description) internal {
        //Require that the address is a member of the club
        require(members[msg.sender].memberAddress == msg.sender);
    }

    //Member vote
    function vote() internal {
        //Require that the address is a member of the club AND has not voted on the proposal yet
        require(
            members[msg.sender].memberAddress == msg.sender &&
                members[msg.sender].hasVoted == false
        );
    }
}
