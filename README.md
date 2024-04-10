## A stablecoin tied to Ethereum, with staking and liquidity

<ol>
<li>1. Relative Stability: Anchored or Pegged ? Anchored -> $1
<ol>
<li>Chainlink Price Feed</li>
<li>Exchange ETH & BTC -> $$$</li>
</ol>
</li>
<li>Stability Mechanism (Minting): Algorithmic
<ol>
<li>only mint the coin with enough collateral (coded)</li>
</ol>
</li>
<li>Collateral: Exogenous (Crypto)
<ol>
<li>wETH</li>
<li>wBTC</li>
</ol>
</li>
</ol>

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
