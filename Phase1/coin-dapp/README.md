# Coin DApp

Built a money transaction application with a minter who can create money to other accounts, and which they can transfer money to other accounts in the network.

<small> The smart contract used is based on the example in solidity docs </small>

## Software Tested On

1. Truffle: Truffle v4.1.5 (core: 4.1.5) & Solidity v0.4.21 (solc-js)
2. Metamask: 4.9.3


## Steps

1. Go into the working directory coin-dapp
2. Start the test environment: truffle develop
3. Open a new terminal in the same directory and execute the command truffle migrate --reset
4. Now that the contract is successfully deployed you need to start the server. Execute npm run dev (you should have done npm intall to intall the neccessary node modules)
5. Go the url in which the server has started
6. You should be able to see the front end of the application.
7. We will be using Metamask to manage different accounts. If you are have installed metamask, and have not used it before, you would have to set the metamask (refer Set up Metamask section)
8. Only the minter account has the permission to mint coins, for all other accounts minting will be disabled
9. In the top of the application, Minter account and the current account will be displayed.

## Set up Metamask
1. Go to https://metamask.io/ and install metamask
2. Click on the metamask icon and accept all terms and conditions
3. When the window prompts for entering password, dont enter the password. Instead click Import Existing DEN and copy paste the Mnemonic which you get after executing truffle develop in termial. It should look something like candy maple cake sugar pudding cream honey rich smooth crumble sweet treat.
4. Enter password and hit enter
5. Now change the network type by clicking top left corner (Main Network arrow mark) and choosing Custom RPC
6. In the box enter the url in which you got after executing truffle develop. Eg: Truffle Develop started at http://127.0.0.1:9545/
7. You should able to see close to 100 ETH in account 1
8. You can import accounts or create accounts. If you are using truffle develop environment both are same





## Important Notes

1. Current account is extracted using metamask web3 instance, if metamask web3 instance is not used and custom web3 is used (else part inside App.js where web3 is configured) then changing the account address in metamask will not change the Current Address.
2. Everytime you change the account in metamask, dont forget to refresh the screen else the address change will not be reflected in the User Interface
 

