// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract StudentManagementBoard {
    address public owner;
    enum Gender {
        male,
        female
    }

    struct Student {
        string name;
        uint8 age;
        string class;
        Gender gender;
    }

    mapping(uint => Student) private students;
    uint8 private studentId = 0;
    mapping(address => bool) public authorizedUsers;

    constructor() {
        owner = msg.sender;
    }

    // Define the owner modifier
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can perform this action"
        );
        _;
    }

    //custom function to add authorized users
    function addAdminRole(address user) external onlyOwner {
        authorizedUsers[user] = true;
    }

    function removeAuthorizedUser(address user) external onlyOwner {
        authorizedUsers[user] = false;
    }

    modifier onlyAuthorized() {
        require(
            msg.sender == owner || authorizedUsers[msg.sender],
            "Not authorized"
        );
        _;
    }

    // Function to add a new student, restricted to the contract owner
    function registerStudent(
        string memory _name,
        uint8 _age,
        string memory _class,
        Gender _gender
    ) external onlyAuthorized {
        Student memory student = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender
        });
        students[studentId] = student;
        studentId++;
    }

    // Function to get a specific student by ID
    function getStudent(
        uint8 _studentId
    ) public view returns (Student memory student_) {
        require(_studentId < studentId, "Student ID does not exist");
        student_ = students[_studentId];
    }

    function getStudentName(
        uint8 _studentId
    ) public view returns (string memory) {
        require(_studentId < studentId, "Student ID does not exist");
        return students[_studentId].name;
    }

    function getStudentAge(uint8 _studentId) public view returns (uint8) {
        require(_studentId < studentId, "Student ID does not exist");
        return students[_studentId].age;
    }

    function getStudentClass(
        uint8 _studentId
    ) public view returns (string memory) {
        require(_studentId < studentId, "Student ID does not exist");
        return students[_studentId].class;
    }

    function getStudentGender(uint8 _studentId) public view returns (Gender) {
        require(_studentId < studentId, "Student ID does not exist");
        return students[_studentId].gender;
    }

    // Function to get all students
    function getStudents() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);
        for (uint i = 0; i < studentId; i++) {
            students_[i] = students[i];
        }
    }

    // Optional: Function to get the total number of students
    function getTotalStudents() public view returns (uint8) {
        return studentId;
    }
}
