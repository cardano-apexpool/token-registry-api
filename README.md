# Cardano Token Registry API 
A simple API for the [Cardano Token Registry](https://github.com/cardano-foundation/cardano-token-registry)

## Components
This project has 2 components:
1. A script that will populate and update a small Sqlite3 database with the information from the Cardano Token Registry. The Cardano Token Registry repository was added as a git submodule in the "files" folder (configurable in `config.py`). Then the `update.py` script must be executed, to populate the database. The repository must be updated from time to time and the `update.py` script should be run if there are changes to the repository files. This script can be run with the command: `python3 update.py`.
2. The API script, `main.py`, which starts a daemon running on a configurable port (8050 is the default port, it can be configured in `config.py`). This script can be run with the command: `python3 main.py`.

In order to also update the Cardano Token Registry submodule, the repository should be initially cloned with the command:
`git clone --recurse-submodules`
When updating it, the update should be done with the following command:
`git pull --recurse-submodules`

## Endpoints
There are 4 API endpoints:
1. /api/v0/ticker/{ticker}
The ticker is case-sensitive. A GET request to: `/api/v0/ticker/cNETA` will return the following result:

```
[
  {
    "policy_id": "b34b3ea80060ace9427bda98690a73d33840e27aaa8d6edb7f0c757a",
    "name_hex": "634e455441",
    "name": "anetaBTC",
    "ticker": "cNETA",
    "description": "AnetaBTC is a fully on-chain, decentralized protocol that allows Bitcoin to be directly wrapped on the Ergo and Cardano blockchains. This token serves as a Cardano governance token for anetaBTC.",
    "decimals": 0
  }
]
```

If the ticker is not found, the result will be (code 406):

```
[
  {
    "error": "Ticker <ticker> not found"
  }
]
```

2. /api/v0/ticker/{ticker}/all
The ticker is case-sensitive. A GET request to: `/api/v0/ticker/cNETA/all` will return the following result:

```
[
  {
    "policy_id": "b34b3ea80060ace9427bda98690a73d33840e27aaa8d6edb7f0c757a",
    "name_hex": "634e455441",
    "name": "anetaBTC",
    "ticker": "cNETA",
    "url": "https://www.anetabtc.io",
    "logo": "iVBORw0KGgoAAAANSUhEUgAAAf4AAAHpCAM.......",
    "description": "AnetaBTC is a fully on-chain, decentralized protocol that allows Bitcoin to be directly wrapped on the Ergo and Cardano blockchains. This token serves as a Cardano governance token for anetaBTC.",
    "decimals": 0
  }
]
```
This is similar to the first endpoint, but the url and the logo are also returned.

If the ticker is not found, the result will be (code 406):

```
[
  {
    "error": "Ticker <ticker> not found"
  }
]
```

3. /api/v0/token/{token_policy}/{token_name}
A GET request to `/api/v0/token/b34b3ea80060ace9427bda98690a73d33840e27aaa8d6edb7f0c757a/634e455441` will return the following result:

```
[
  {
    "name": "anetaBTC",
    "ticker": "cNETA",
    "description": "AnetaBTC is a fully on-chain, decentralized protocol that allows Bitcoin to be directly wrapped on the Ergo and Cardano blockchains. This token serves as a Cardano governance token for anetaBTC.",
    "decimals": 0
  }
]
```

4. /api/v0/tokens
A POST request to `/api/v0/tokens` with the parameter `[{"policy_id": "b34b3ea80060ace9427bda98690a73d33840e27aaa8d6edb7f0c757a", "token_name": "634e455441"}, {"policy_id": "6ac8ef33b510ec004fe11585f7c5a9f0c07f0c23428ab4f29c1d7d10", "token_name": "4d454c44"}]` will return the following result:

```
[
  {
    "policy_id": "6ac8ef33b510ec004fe11585f7c5a9f0c07f0c23428ab4f29c1d7d10",
    "name_hex": "4d454c44",
    "name": "MELD",
    "ticker": "MELD",
    "description": "The governance token of the MELD protocol.",
    "decimals": 6
  },
  {
    "policy_id": "b34b3ea80060ace9427bda98690a73d33840e27aaa8d6edb7f0c757a",
    "name_hex": "634e455441",
    "name": "anetaBTC",
    "ticker": "cNETA",
    "description": "AnetaBTC is a fully on-chain, decentralized protocol that allows Bitcoin to be directly wrapped on the Ergo and Cardano blockchains. This token serves as a Cardano governance token for anetaBTC.",
    "decimals": 0
  }
]
```

#### Support or donations
I created this script and made it open source because I thought it might be useful for some people.
I do not expect any compensation for it. But in case someone finds it very useful and wants to support me, the best way to do it is to delegate a Cardano wallet to APEX Stake pool (ticker: `APEX`, pool ID: `538299a358e79a289c8de779f8cd09dd6a6bb286de717d1f744bb357`).
And in case someone really wants to make a donation in ADA or other Cardano native tokens, this is the address that can be used: ```addr1vy923jc5f2gck5eqzwyl8nkn4a8rc6s6w2td83egm4malns79qumx```. Thank you!
