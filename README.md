# NFTs minting scripts for free code camp Patrick's course using foundry

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

