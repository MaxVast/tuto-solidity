<template>
  <div id="app">
    <div class="container mx-auto pt-10 pb-8 justify-center">
      <div class="mx-auto max-w-md">
        <h1 style="text-align: center;">Welcome to my first Dapp</h1>
        <div class="mx-auto pt-10 pb-8 items-center justify-center">
          <button id="connectButton"
            v-if="!currentAccount"
            v-on:click="connectWallet"
            :disabled="connecting"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">{{ (!connecting) ? 'Connect Metamask' : 'Connecting ... '}}</button>

            <div v-if="currentAccount">You are connect <br/><br/>
              address : {{ currentAccount }} <br/><br/>
              wallet amount : {{ currentWalletAmount }} ETH
            </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {ethers} from "ethers";
import ContractAbi from '../artifacts/contracts/wallet.sol/wallet.json';
export default {
  name: 'IndexPage',
  components: {
  },
  data () {
    return {
      contract: null,
      loading: false,
      connecting: false,
      contractInitialised: false,
      currentAccount: null,
      currentBalance: 0,
      currentWalletAmount: 0,
      form: {
        depositAmount: 0,
        withdrawalAmount: 0
      }
    }
  },
  mounted () {
    // metamask
    const { ethereum } = window
    // initialise contract
    if (ethereum) {
      const provider = new ethers.providers.Web3Provider(ethereum)
      const signer = provider.getSigner()
      const contract = new ethers.Contract(
        '0x5FbDB2315678afecb367f032d93F642f64180aa3', // change this when deploy new contract
        ContractAbi.abi,
        signer
      )
      this.contract = Object.freeze(contract)
      console.log('Contract initialised')
    } else {
      this.contractInitialised = false
    }
  },
  methods: {
    // connect metamask wallet
    async connectWallet () {
      try {
        const { ethereum } = window
        // check if metamask is found
        if (!ethereum) {
          console.log('Metamask not detected')
          return
        }
        const provider = new ethers.providers.Web3Provider(ethereum)
        // get accounts
        this.connecting = true
        const accounts = await ethereum.request({method: 'eth_requestAccounts'})
        this.connecting = false
        console.log('Found account', accounts[0])
        this.currentAccount = accounts[0] // set first account to currentAccount
        // check balance of account
        provider.getBalance(this.currentAccount).then((balance) => {
          // convert a currency unit from wei to ether
          const balanceInEth = ethers.utils.formatEther(balance)
          console.log(`balance : ${balanceInEth} ETH`)
          this.currentWalletAmount = balanceInEth;
        })
        this.checkBalance()
      } catch (error) {
        this.connecting = false
        console.log('Error connecting to metamask', error)
      }
    },
    // get current balance of account
    async checkBalance () {
        this.loading = true
        // call contract balance method
        let balance = await this.contract.balance({
            from: this.currentAccount
        })
        
        // convert wei to ether
        this.currentBalance = ethers.utils.formatEther(balance) // 1000000000000 = 1 ETH
        console.log('balance :' + this.currentBalance)
        this.loading = false
    },
  }
  
}
</script>
