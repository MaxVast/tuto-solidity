const FavoriteNumber = artifacts.require("./FavoriteNumber");

contract("FavoriteNumber", accounts => {
    it("Should change the favorite number in the blockchain", async function() {
        const Contract = await FavoriteNumber.deployed();
        const result = await Contract.setNumberFavory(477, {from: accounts[0]})
    })

    it("Should get the favorite number in the blockchain", async function() {
        const Contract = await FavoriteNumber.deployed();
        const result = await Contract.numberFavorite();
        assert.equal(result.words[0], 477, "Not equal to 47")
    })
})