# NFTs minting scripts for freeCodeCamp Patrick's course using foundry

![image](https://user-images.githubusercontent.com/5586894/185512341-e3ebe5e8-3b10-43e2-9478-2d77f891d200.png)

Source: https://github.com/smartcontractkit/full-blockchain-solidity-course-js

Video: https://www.youtube.com/watch?v=gyMwXuJrbJQ

## Run a test
```sh
source .env && TARGET=$TARGET_ADDRESS forge test --fork-url $RPC_ARBITRUM -vvvv --match-test testCallMeChallenge
```

## Run a script 
```sh
source .env && TARGET=$TARGET_ADDRESS forge script ./script/CallMeChallenge.s.sol -vvv --broadcast --private-key $PRIVATE_KEY --rpc-url $RPC_ARBITRUM
```

