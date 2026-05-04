// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EduPayChain {

    address public admin;

    enum Status {
        Pending,
        Verified,
        Rejected
    }

    struct Payment {
        string nim;
        string semester;
        uint amount;
        string proofHash;
        Status status;
    }

    mapping(uint => Payment) public payments;

    uint public paymentCount;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin only");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function submitPayment(
        string memory _nim,
        string memory _semester,
        uint _amount,
        string memory _proofHash
    ) public {

        paymentCount++;

        payments[paymentCount] = Payment(
            _nim,
            _semester,
            _amount,
            _proofHash,
            Status.Pending
        );
    }

    function verifyPayment(uint _id) public onlyAdmin {
        payments[_id].status = Status.Verified;
    }

    function rejectPayment(uint _id) public onlyAdmin {
        payments[_id].status = Status.Rejected;
    }

    function checkStatus(uint _id) public view returns(Status) {
        return payments[_id].status;
    }
}