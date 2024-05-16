import { ethers, defender } from "hardhat";

async function main() {
    const habbit = await ethers.getContractFactory("Habitude");

    const deployment = await defender.deployContract(habbit,{});
    await deployment.waitForDeployment();
    console.log(`Contract deployed to : ${await deployment.getAddress()}`);
}

main().catch((err) => {
    console.log(err);
    process.exitCode = 1;
}
);