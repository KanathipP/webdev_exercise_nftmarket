const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarketplace", function () {
  it("Should deploy the contract and create a token", async function () {
    const NFTMarketplace = await ethers.getContractFactory("NFTMarketplace");
    const nftMarketplace = await NFTMarketplace.deploy();
    await nftMarketplace.waitForDeployment();

    const tokenURI = "https://example.com/token/1";
    const tx = await nftMarketplace.createToken(tokenURI);
    const receipt = await tx.wait();

    console.log("Transaction Receipt:", receipt);

    // Verify that the contract address is valid
    expect(nftMarketplace.target).to.be.properAddress;

    // Verify that the transaction was successful
    expect(receipt.status).to.equal(1);

    // Verify that a token was created
    const tokenId = await nftMarketplace.getCurrentTokenId();
    expect(tokenId).to.be.a('bigint');
    expect(tokenId).to.be.greaterThan(0n);
  });
}); 