# Blockchain-Based Solution for Insurance Fraud Prevention

## Objective
Insurance fraud is a persistent issue affecting the industry worldwide, costing providers and honest policyholders billions of dollars annually. Fraudulent activities, such as submitting false claims, exaggerating damages, or exploiting policy loopholes, disrupt fair practices and inflate costs for legitimate customers.

In response to these challenges, there is a need for a solution that ensures secure, transparent, and immutable documentation of insurance records. By leveraging blockchain technology, we can enhance trust and security in the insurance process, making it harder for fraudulent activities to occur while improving efficiency and transparency.

## Part 1: Transparent Documentation and Claims Verification

1. Immutable Recordkeeping  
   - Use blockchain technology to securely log claim data, preventing any alteration of records once added to the ledger. This ensures transparency and reliability in claim histories.

2. Claim Validation  
   - Implement smart contracts to automatically verify claim eligibility based on predefined rules, reducing fraudulent claims and simplifying processing.

3. User Authentication  
   - Use blockchain-based identity verification to confirm user identities, reducing the risk of fraudulent submissions.

## Part 2: Fraud Detection and Prevention

1. Data Integrity and Security 
   - Store sensitive claim data across a distributed network to protect against tampering, ensuring claims cannot be easily manipulated.

2. Anomaly Detection 
   - Integrate algorithms to detect unusual claim patterns, such as repeated high-value claims or identical document submissions.

3. Audit Trail and Reporting 
   - Generate immutable audit trails and summary reports for all claims and their status, providing administrators with a transparent overview of claims activity.

4. User-Friendly Dashboard  
   - Design a dashboard displaying real-time claims, anomalies, and verification status, allowing administrators to monitor fraud risks and manage claims efficiently.

## Deliverables :

1. Blockchain-Based Claims Log Module 
   - A system for securely logging and verifying claims data, ensuring records remain immutable.

2. Fraud Detection Module 
   - A tool for analyzing and flagging fraudulent patterns in claim submissions.

3. Unified Claims Management Interface  
   - A user interface integrating both modules, allowing seamless claim verification and fraud detection. 

---
## Why do we chose this problem statement?

### Feasibility and Scope:

The insurance fraud prevention solution is more contained since it primarily involves document storage, verification, and claim process automation.
We planned to demonstrate the essential components (like document verification with blockchain and smart contract-based claims processing) without needing complex integrations, as you might with cross-border payments.

### Blockchain’s Clear Impact:

For fraud prevention, blockchain’s value is easily understood: it provides an immutable record of claims and documents, which reduces the chance of fraud and tampering. This clear, straightforward application of blockchain could impress judges without requiring in-depth financial integrations.

## Architecture Diagram :
![WhatsApp Image 2024-11-09 at 08 50 27_00e9cd02](https://github.com/user-attachments/assets/7c9e50fc-0802-4799-9eb6-61e9e16dc2aa)

## Development Platform:
1. VScode
2. Hardhat
3. Node js
4. Ether
## Consensus Used:
### 1.Proof of Stake (PoS): 
   PoS chain like Ethereum, the underlying network is handling consensus. This simplifies the setup and reduces energy consumption, which is beneficial for a sustainable insurance application.
### 2.Delegated Proof of Stake (DPoS):
   DPoS can be included if your insurance project requires high speed, but typically, DPoS is less decentralized than PoS,for the future enhancements.

These could be integrated in the project , When a new claim is submitted, consensus can verify and record it across all nodes, making it immutable and transparent.
This guarantees that every participant, whether an insurer, a customer, or a regulatory authority, sees the same version of the truth.
# BACKEND :

## Installation of Hardhat command:
### Check Node.js and npm versions:
```
node -v
npm -v
```
```
npm install --save-dev hardhat
```
```
mkdir insurance-blockchain
cd insurance-blockchain
npx hardhat
```
### Smart contract:
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceClaim {
    struct Claim {
        address claimant;
        string documentHash;
        bool isVerified;
    }

    mapping(uint => Claim) public claims;
    uint public claimCount;

    // Add a new claim
    function addClaim(string memory _documentHash) public {
        claimCount++;
        claims[claimCount] = Claim(msg.sender, _documentHash, false);
    }

    // Verify a claim
    function verifyClaim(uint _claimId) public {
        require(_claimId > 0 && _claimId <= claimCount, "Invalid claim ID");
        claims[_claimId].isVerified = true;
    }

    // Retrieve claim details
    function getClaim(uint _claimId) public view returns (address, string memory, bool) {
        Claim memory claim = claims[_claimId];
        return (claim.claimant, claim.documentHash, claim.isVerified);
    }
}
```
## Compile the contract:
```
npx hardhat compile
```
## Deploying the contract to a Local Blockchain :

### 1. Start a local Ethereum Network :
```
npx hardhat node
```
### 2. Creating a Deployment Script :
```
async function main() {
    const InsuranceClaim = await ethers.getContractFactory("InsuranceClaim");
    const insurance = await InsuranceClaim.deploy();
    await insurance.deployed();
    console.log("InsuranceClaim deployed to:", insurance.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
```
### 4. Depolying the contract :
```
npx hardhat run scripts/deploy.js --network localhost
```

## Interacting with the contract :

### 1. Open a Hardhat console to interact with your deployed contract :
```
npx hardhat console --network localhost
```
### 2. Interacting with Functions :
```
const insurance = await ethers.getContractAt("InsuranceClaim", "your_contract_address");
await insurance.addClaim(1, ethers.utils.formatBytes32String("DocumentHash1"));
await insurance.verifyClaim(1);
```


## Output of the backend:
![Screenshot 2024-11-09 075245](https://github.com/user-attachments/assets/83cc9280-924a-4a22-a798-5abe45249eda)


## Here we present our output of insurance blocks in a video as a drive link:

https://youtu.be/hea5zUCgaJQ

## Vulnerability Test with Mocha :

![Screenshot (190)](https://github.com/user-attachments/assets/aa7a4814-756f-4b91-8741-a769c940a1aa)

# FRONTEND :
## Project Setup :
```
npx create-react-app insurance-frontend
cd insurance-frontend
```
## Installing Dependencies :
```
npm install web3 ethers bootstrap
```

![WhatsApp Image 2024-11-09 at 08 55 21_c1ac3821](https://github.com/user-attachments/assets/3c4a98a6-6973-4877-ad5b-4033a8bd288e)

## Setup a Smart Contract Interface :
```
import { ethers } from "ethers";
import InsuranceABI from "./InsuranceContract.json"; // assuming ABI file

const contractAddress = "YOUR_CONTRACT_ADDRESS";
const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const insuranceContract = new ethers.Contract(contractAddress, InsuranceABI, signer);
```

## Creating Core UI components :

### 1. Document Verification component :
```
import React, { useState } from "react";

function DocumentVerification() {
    const [documentHash, setDocumentHash] = useState("");
    const [verificationResult, setVerificationResult] = useState(null);

    const handleVerify = async () => {
        try {
            const result = await insuranceContract.verifyDocument(documentHash);
            setVerificationResult(result);
        } catch (error) {
            console.error("Verification failed", error);
            setVerificationResult("Verification failed");
        }
    };

    return (
        <div>
            <h2>Document Verification</h2>
            <input
                type="text"
                placeholder="Enter document hash"
                value={documentHash}
                onChange={(e) => setDocumentHash(e.target.value)}
            />
            <button onClick={handleVerify}>Verify Document</button>
            {verificationResult && <p>Result: {verificationResult}</p>}
        </div>
    );
}

export default DocumentVerification;
```
### 2. Claim Submission component :
```
import React, { useState } from "react";

function ClaimSubmission() {
    const [claimData, setClaimData] = useState({ policyNumber: "", claimAmount: "" });
    const [submitResult, setSubmitResult] = useState(null);

    const handleSubmit = async () => {
        try {
            const transaction = await insuranceContract.submitClaim(
                claimData.policyNumber,
                ethers.utils.parseUnits(claimData.claimAmount, "ether")
            );
            await transaction.wait();
            setSubmitResult("Claim submitted successfully!");
        } catch (error) {
            console.error("Submission failed", error);
            setSubmitResult("Submission failed");
        }
    };

    return (
        <div>
            <h2>Claim Submission</h2>
            <input
                type="text"
                placeholder="Policy Number"
                value={claimData.policyNumber}
                onChange={(e) => setClaimData({ ...claimData, policyNumber: e.target.value })}
            />
            <input
                type="text"
                placeholder="Claim Amount (ETH)"
                value={claimData.claimAmount}
                onChange={(e) => setClaimData({ ...claimData, claimAmount: e.target.value })}
            />
            <button onClick={handleSubmit}>Submit Claim</button>
            {submitResult && <p>{submitResult}</p>}
        </div>
    );
}

export default ClaimSubmission;
```
## Integrating Components in App.js :
```
import React from "react";
import DocumentVerification from "./DocumentVerification";
import ClaimSubmission from "./ClaimSubmission";
import "bootstrap/dist/css/bootstrap.min.css";

function App() {
    return (
        <div className="container">
            <h1>Insurance Fraud Prevention</h1>
            <DocumentVerification />
            <ClaimSubmission />
        </div>
    );
}

export default App;
```
## Connecting to Metamask :
```
import React, { useState } from "react";
import { ethers } from "ethers";

function WalletConnect() {
    const [walletAddress, setWalletAddress] = useState(null);

    const connectWallet = async () => {
        if (window.ethereum) {
            try {
                await window.ethereum.request({ method: "eth_requestAccounts" });
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                const signer = provider.getSigner();
                setWalletAddress(await signer.getAddress());
            } catch (error) {
                console.error("Wallet connection failed", error);
            }
        } else {
            alert("Please install MetaMask!");
        }
    };

    return (
        <div>
            <button onClick={connectWallet}>
                {walletAddress ? `Connected: ${walletAddress}` : "Connect Wallet"}
            </button>
        </div>
    );
}

export default WalletConnect;
```
## Run the Frontend :
```
npm start
```
# For the Future development:
 ## Interoperable Wallets and Identity Verification:
In insurance applications, verifying the identity of users and claims across chains can be a critical aspect. For this, consider interoperable solutions that enable user identity and data sharing: use of DIDs would be a simplifield solution,this could be integrated to the frontend.

DIDs (Decentralized Identifiers): These allow identity verification across multiple chains using a unified identity.
## Tokenization:
Non-Fungible Tokens (NFTs): NFTs are unique tokens that represent ownership of a specific asset or data and cannot be exchanged on a one-to-one basis with other tokens. NFTs are based on standards like ERC-721 on Ethereum.Each insurance policy or claim could be tokenized as an NFT, representing a unique claim ID or policy number. By making each policy an NFT, you can track ownership, transferability, and prevent duplicate claims by ensuring each policy ID is unique.used for claim verification and also incentives for hosnesty activities,hence making it more efficient.






### Note: This serves only as a reference example. Innovative ideas and unique implementation techniques are highly encouraged and warmly welcomed!
