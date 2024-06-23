// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStatements {
    // This variable will hold the sum of the two numbers
    uint public sum;

    // Function to add two numbers, making sure they are valid and no overflow occurs
    function addNumbers(uint a, uint b)  public {
        // Using require to check input values
        require(a>0,"First number must be greater than zero");
        require(b>0, "Second number must be greater than zero");
        
        // Adding numbers and checking overflow with assert
        uint result = a+b;
        assert(result>=a);

        // Store the result in the state variable
        sum = result;
    }
    // Function to demonstrate how revert works
    function testRevert(uint a) public pure {
        if(a<10){
            revert("Input must be at least 10");
        }
    }
}
