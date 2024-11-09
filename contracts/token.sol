// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceClaim {
    struct Claim {
        uint256 id;
        address claimant;
        bytes32 documentHash;
        bool isVerified;
    }

    mapping(uint256 => Claim) public claims;

    function addClaim(uint256 _id, bytes32 _documentHash) public {
        claims[_id] = Claim({
            id: _id,
            claimant: msg.sender,
            documentHash: _documentHash,
            isVerified: false
        });
    }

    function verifyClaim(uint256 _id) public {
        require(claims[_id].id == _id, "Claim does not exist.");
        claims[_id].isVerified = true;
    }
}
