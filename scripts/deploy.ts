import { ethers } from "hardhat";

async function main() {
  // Deploy Lock contract
  const unlockTime = Math.floor(Date.now() / 1000) + 60 * 60 * 24; // Unlocks in 1 day
  const lock = await ethers.deployContract("Lock", [unlockTime], {
    value: ethers.parseEther("0.01"), // Sending 0.01 ETH to the contract
  });

  await lock.waitForDeployment();
  console.log(`Lock deployed to: ${await lock.getAddress()}`);

  // Deploy StudentManagementBoard contract
  const studentManagement = await ethers.deployContract("StudentManagementBoard");

  await studentManagement.waitForDeployment();
  console.log(`StudentManagementBoard deployed to: ${await studentManagement.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
