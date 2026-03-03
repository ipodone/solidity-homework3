import { expect } from "chai";
import { network } from "hardhat";

const { ethers } = await network.connect();

describe("Counter", function () {
  this.beforeEach(async function () {
    // deploy the contract before each test
    this.counter = await ethers.deployContract("Counter");
    console.log(`Counter deployed to: ${this.counter.target}`);
  });

  it("Should emit the Increment event when calling the inc() function", async function () {
    // const counter = await ethers.deployContract("Counter");
    const counter = this.counter;

    await expect(counter.inc()).to.emit(counter, "Increment").withArgs(1n);
  });

  it("The sum of the Increment events should match the current value", async function () {
    // const counter = await ethers.deployContract("Counter");
    const counter = this.counter;
    const deploymentBlockNumber = await ethers.provider.getBlockNumber();

    // run a series of increments
    for (let i = 1; i <= 10; i++) {
      await counter.incBy(i);
    }

    const events = await counter.queryFilter(
      counter.filters.Increment(),
      deploymentBlockNumber,
      "latest",
    );

    // check that the aggregated events match the current value
    let total = 0n;
    for (const event of events) {
      total += event.args.by;
    }

    expect(await counter.x()).to.equal(total);
  });
});
