# Generic FA2

Experiment with generic FA2 contracts.

Original contracts code:

-   <https://gitlab.com/ligolang/contract-catalogue>
-   <https://github.com/pewulfman/Tezos-TZIP-implementation>

### Token metadata

Because temple wallet and better call dev platform follows a FA2 standard (with multiple assets), the single_asset follows the same type definition of the token metadata than multi_asset.
Thus the single asset handles only one asset, it defines the token metadata as a `big_map` which contains a single entry.
For example:
```
  Big_map.literal ([
    (0n, { token_id = 0n; token_info = Map.literal([ ("", 0x03) ]) })
  ]) 
```

## How to use this library

Install the library with ligo CLI (with docker)
```
ligo install ligo-extendable-fa2
```
This command will add a dependency in a `package.json` file. 

Here is an example of the resulting `package.json` file.
```
{ "dependencies": { "@ligo/fa": "^1.0.4", "ligo-extendable-fa2": "^1.0.1" } }
```




