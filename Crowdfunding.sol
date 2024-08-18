// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public creator;
    uint public fundingGoal;
    uint public deadline;
    uint public totalFunds;
    mapping(address => uint) public contributions;

    constructor(uint _goal, uint _duration) {
        creator = msg.sender;
        fundingGoal = _goal;
        deadline = block.timestamp + _duration;
    }

    function contribute() external payable {
        require(block.timestamp < deadline, "The campaign has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        assert(address(this).balance == totalFunds);
    }

    function checkGoalReached() external view returns (bool) {
        return totalFunds >= fundingGoal;
    }

    function withdrawFunds() external {
        require(msg.sender == creator, "Only the campaign creator can withdraw funds");
        require(block.timestamp >= deadline, "Campaign is still ongoing");
        require(totalFunds >= fundingGoal, "Funding goal not reached");

        uint amount = totalFunds;
        totalFunds = 0;

        (bool success, ) = creator.call{value: amount}("");
        require(success, "Transfer failed");

        assert(totalFunds == 0);
    }

    function refund() external {
        require(block.timestamp >= deadline, "Campaign is still ongoing");
        require(totalFunds < fundingGoal, "Funding goal was reached");

        uint contributed = contributions[msg.sender];
        require(contributed > 0, "No contributions found");

        contributions[msg.sender] = 0;
        totalFunds -= contributed;

        (bool success, ) = msg.sender.call{value: contributed}("");
        if (!success) {
            revert("Refund failed");
        }

        assert(contributions[msg.sender] == 0);
    }
}
