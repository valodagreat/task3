const main = async () => {
  const [owner] = await hre.ethers.getSigners();
  const nftContractFactory = await hre.ethers.getContractFactory('ValNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("NFT Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.mintNFT();
  // Wait for it to be mined.
  await txn.wait();
  console.log("Minted NFT #1");

  txn = await nftContract.mintNFT();
  // Wait for it to be mined.
  await txn.wait();
  console.log("Minted NFT #2");

  const tokenContractFactory = await hre.ethers.getContractFactory('MyToken');
  const tokenContract = await tokenContractFactory.deploy();
  await tokenContract.deployed();
  console.log("Token Contract deployed to:", tokenContract.address);

  let txnII = await tokenContract.buyToken(owner.address, 100, {
      value: hre.ethers.utils.parseEther("0.1")
  });

  await txnII.wait();
  console.log("Bought ValToken");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();