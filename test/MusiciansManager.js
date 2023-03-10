const MusiciansManager = artifacts.require("./MusiciansManager");

contract("MusiciansManager", accounts => {
    it("Should add a musician in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        const result = await Contract.addMusician(accounts[3], "Grima", {from: accounts[0]})
        assert.equal(result.logs[0].args._artistName, "Grima", "Not equal to 'Grima'")
    })

    it("Should not add a musician if it already exists in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        let error = null;
        try{
            await Contract.addMusician(accounts[3], "Ultar", {from: accounts[0]})
        } catch(error) {
            err = error;
        }
        assert.ok(err instanceof Error);
    })

    it("Should add a track in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        const result = await Contract.addTrack(accounts[3], "Grom", 334, {from: accounts[0]})
        assert.equal(result.logs[0].args._title, "Grom", "Not equal to 'Grom'")
    })

    it("Should not add a track to an unknown artist in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        let error = null;
        try{
            await Contract.addTrack(accounts[4], "Enisey", 272, {from: accounts[0]})
        } catch(error) {
            err = error;
        }
        assert.ok(err instanceof Error);
    })

    it("Should get the track of an artist in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        const result = await Contract.getTracks(accounts[3]);
        assert.ok(Array.isArray(result.logs[0].args._tracks));
    })

    it("Should get the name of an artist in the blockchain", async function() {
        const Contract = await MusiciansManager.deployed();
        const result = await Contract.getMusician(accounts[3]);
        assert.ok(typeof result.logs[0].args._artistName == 'string');
    })
})