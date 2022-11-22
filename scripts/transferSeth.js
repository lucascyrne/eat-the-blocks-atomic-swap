module.exports = async (callback) => {
  await web3.eth.sendTransaction({
    from: "0xA819854c4778E3778713C510ce0C2c311CB5ED0f",
    to: "0x4603c34Ac31bc3130dFBBe52AFbAF9932fbF5c8B",
    value: web3.utils.toWei("100", "milli"),
  });
  callback();
};
