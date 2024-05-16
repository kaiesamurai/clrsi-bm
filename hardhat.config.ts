import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  defender: {
    apiKey: process.env.DEFENDER_KEY as string,
    apiSecret: process.env.DEFENDER_SECRET as string,
  },
  networks: {
    scroll_sepolia: {
      url: "https://sepolia-rpc.scroll.io/",
      chainId: 534351
    },
  },
};

export default config;
