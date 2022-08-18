## Run a test
```sh
source .env && forge test --fork-url $RPC_ROPSTEN -vvvv --match-test testCallMeChallenge
```

## Run a script 
```sh
source .env && forge script ./script/CallMeChallenge.s.sol -vvv --broadcast --private-key $PRIVATE_KEY --rpc-url $RPC_ROPSTEN
```

