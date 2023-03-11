<template>
  <div id="app">
    <div class="container mx-auto pt-10 pb-8">
      <div class="mx-auto max-w-screen-lg">
        <h1 style="text-align: center;">Welcome to my first Dapp</h1>
        <div class="mx-auto pt-10 items-center justify-center">
          <div class="row flex items-center justify-center">
            <img src="/Ethereum.png" alt="Logo Ethereum" max-height="50" max-width="50" style="width: 15%;"/>
          </div>
          <div v-if="!currentAccount" class="row items-center justify-center">
            <div class="flex justify-center columns-12 columns-md-9 columns-sm-6 align-center">
              <button id="connectButton"
                v-on:click="connectWallet"
                :disabled="connecting"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">{{ (!connecting) ? 'Connect Metamask' : 'Connecting ... '}}</button>
            </div>
          </div>
          
          <div v-if="currentAccount">
            <div  class="row items-center justify-center">
              <div id="withdraw-all-eth" class="flex justify-center columns-12 columns-md-9 columns-sm-6 align-center">
                <p>Address : {{ currentAccount }} <br/><br/>
                Wallet amount : {{ currentWalletAmount }} ETH <br/> <br/>
                Bank amount : {{ currentBalance }} ETH </p>
              </div>
              
            </div>

            <div class="row items-center justify-center pt-8 pb-5">
              <div id="withdraw-all-eth" class="flex justify-center columns-12 columns-md-9 columns-sm-6 align-center">
                <button @click="withdrawAllToken" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded">Withdraw all ETH</button>
              </div>
            </div>
            
            <div class="row items-center justify-center pt-8 pb-5">
              <div  class="flex justify-between columns-12 columns-md-9 columns-sm-6 pt-5 pb-5 align-center">
                <div id="deposit-eth" class="row items-center justify-center pt-8">
                  <h3 style="text-align: center;">Deposit ETHEREUM</h3>
                  <div  class="flex justify-center columns-12 columns-md-9 columns-sm-6 pt-5 pb-5 align-center">
                    <div class="flex items-center columns-md-6 pr-1">
                        <input type="text" placeholder="Deposit ETH" class="block w-full text-sm text-slate-500 border-4" v-model="form.depositAmount"/>
                    </div>
                    <div class="flex items-center columns-md-6 pl-1">
                      <button @click="deposit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-6 rounded">Deposit ETH</button>
                    </div>
                  </div>
                </div>

                <div id="deposit-eth" class="row items-center justify-center pt-8">
                  <h3 style="text-align: center;">Withdraw ETHEREUM</h3>
                  <div  class="flex justify-center columns-12 columns-md-9 columns-sm-6 pt-5 pb-5 align-center">
                    <div class="flex items-center columns-md-6 pr-1">
                      <input type="text" placeholder="Withdraw ETH" class="block w-full text-sm text-slate-500 border-4" v-model="form.withdrawalAmount"/>
                    </div>
                    <div class="flex items-center columns-md-6 pl-1">
                      <button @click="withdrawToken" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-6 rounded">Withdraw ETH</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {ethers} from "ethers";
import ContractAbi from '../artifacts/contracts/wallet.sol/Wallet.json';
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
        depositAmount: null,
        withdrawalAmount: null
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
        // get accounts
        this.connecting = true
        const accounts = await ethereum.request({method: 'eth_requestAccounts'})
        this.connecting = false
        console.log('Found account', accounts[0])
        this.currentAccount = accounts[0] // set first account to currentAccount
        // check balance of account
        this.checkBalance()
        this.checkWallet()
      } catch (error) {
        this.connecting = false
        console.log('Error connecting to metamask', error)
      }
    },
    async checkWallet() {
      this.loading = true
      try {
        const { ethereum } = window
        // check if metamask is found
        if (!ethereum) {
          console.log('Metamask not detected')
          return
        }
        const provider = new ethers.providers.Web3Provider(ethereum)
        provider.getBalance(this.currentAccount).then((balance) => {
            // convert a currency unit from wei to ether
            const balanceInEth = ethers.utils.formatEther(balance)
            console.log(`balance : ${balanceInEth} ETH`)
            this.currentWalletAmount = balanceInEth;
          })
      }catch (e) {
        console.log(e)
        this.loading = false
        alert('Failed to check wallet')
      }
    },
    // get current balance of account
    async checkBalance () {
        this.loading = true
        // call contract balance method
        let balance = await this.contract.getbalance({
            from: this.currentAccount
        })
        // convert wei to ether
        this.currentBalance = ethers.utils.formatEther(balance) // 1000000000000 = 1 ETH
        console.log('balance :' + this.currentBalance)
        this.loading = false
    },
    // deposit ether to bank
    async deposit () {
      try {
        this.loading = true
        const { ethereum } = window
        // check if metamask is found
        if (!ethereum) {
          console.log('Metamask not detected')
          return
        }
        const provider = new ethers.providers.Web3Provider(ethereum)
        const accounts = await ethereum.request({method: 'eth_requestAccounts'})
        const signer = provider.getSigner()
        const tx = {
          from: accounts[0],
          to: '0x5FbDB2315678afecb367f032d93F642f64180aa3', 
          value: ethers.utils.parseEther(parseFloat(this.form.depositAmount).toString())
        }
        // call contract deposit method
        const transaction = await signer.sendTransaction(tx)
        let txnResults = await transaction.wait() // await for transaction to be mined
        console.log(txnResults)
        alert(`Successfully deposited ${this.form.depositAmount} ETH to bank`)
        this.checkBalance() // initiate check balance
        this.checkWallet()
        this.loading = false
        this.form.depositAmount = 0
      } catch (e) {
        console.log(e)
        this.loading = false
        alert('Failed to deposit')
      }
    },
    // withdraw all ether from bank
    async withdrawAllToken () {
      try {
        const options = {
          from: this.currentAccount
        }
        this.loading = true
        // call contract withdraw method
        let txn = await this.contract.withdrawAllToken(this.currentAccount)
        let txnResults = await txn.wait() // await for transaction to be mined
        console.log(txnResults)
        alert(`Successfully withdrew ETH from bank`)
        this.checkBalance()
        this.checkWallet() // initiate check balance
        this.loading = false
        this.form.withdrawalAmount = null
      } catch (e) {
        console.log(e)
        this.loading = false
        alert('Failed to withdraw')
      }
    },
    // withdraw ether from bank
    async withdrawToken () {
      try {
        this.loading = true
        // call contract withdraw method
        let txn = await this.contract.withdrawToken(this.currentAccount, 
           ethers.utils.parseEther(parseFloat(this.form.withdrawalAmount).toString()),
        )
        let txnResults = await txn.wait() // await for transaction to be mined
        console.log(txnResults)
        alert(`Successfully withdrew ${this.form.withdrawalAmount} ETH from bank`)
        this.checkBalance() // initiate check balance
        this.checkWallet()
        this.loading = false
        this.form.withdrawalAmount = null
      } catch (e) {
        console.log(e)
        this.loading = false
        alert('Failed to withdraw')
      }
    },
  }
}
</script>
