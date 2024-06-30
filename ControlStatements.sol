// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SchoolGrades {
    // Mapping to store student grades
    mapping(address => uint) public grades;

    // Function to record a student's grade
    function recordGrade(address student, uint grade) public {
        // Require valid student address
        require(student != address(0), "Invalid student address");

        // Require valid grade (between 0 and 100)
        require(grade >= 0 && grade <= 100, "Invalid grade");

        // Record the grade
        grades[student] = grade;
    }

    // Function to get a student's grade
    function getGrade(address student) public view returns (uint) {
        // Require student has a recorded grade
        require(grades[student] > 0, "No grade recorded for this student");

        // Return the student's grade
        return grades[student];
    }

    // Function to update a student's grade
    function updateGrade(address student, uint newGrade) public {
        // Require valid student address
        require(student != address(0), "Invalid student address");

        // Require valid new grade (between 0 and 100)
        require(newGrade >= 0 && newGrade <= 100, "Invalid grade");

        // Require student has an existing grade
        require(grades[student] > 0, "No grade recorded for this student");

        // Update the grade
        grades[student] = newGrade;
    }
}
