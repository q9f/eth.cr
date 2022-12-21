# eth.cr

[![Build Status](https://img.shields.io/github/actions/workflow/status/q9f/eth.cr/crystal.yml?branch=main)](https://github.com/q9f/eth.cr/actions)
[![Language](https://img.shields.io/github/languages/top/q9f/eth.cr?color=black)](https://github.com/q9f/eth.cr/search?l=crystal)
[![License](https://img.shields.io/github/license/q9f/eth.cr.svg?color=black)](LICENSE)

## Installation

Add the `Eth` library to your `shard.yml`.

```yaml
dependencies:
  eth:
    github: q9f/eth.cr
    version: "~> 0.1"
```

Run `shards install`.

## Usage

```crystal
require "eth"
```

Create an Ethereum account:

```crystal
key = Key.new
# => #<Eth::Key:0x7f3719247b10
#           @private_key=#<Eth::Num:0x7f3719b4f500
#               @hex="d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51",
#               @dec=97149512268879514742361644313413872500736768173592718417281501971026009718353,
#               @bin=Bytes[214, 200, 172, 228, 112, 171, 12, 224, 49, 37, 202, 198, 171, 242, 119, 156, 25, 157, 33, 164, 125, 62, 117, 233, 60, 33, 43, 30, 194, 60, 254, 81]>,
#           @public_key=#<Secp256k1::Point:0x7f3719246420
#               @x=#<Secp256k1::Num:0x7f3719b4fa40
#                   @hex="bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc",
#                   @dec=86414673301778591173569328850396232566766657919369855130423318525027519376124,
#                   @bin=Bytes[191, 12, 248, 201, 52, 189, 60, 87, 233, 98, 253, 242, 164, 126, 153, 214, 19, 107, 4, 127, 152, 126, 226, 224, 203, 3, 17, 12, 175, 217, 42, 252]>,
#               @y=#<Secp256k1::Num:0x7f3719b4fa00
#                   @hex="981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04",
#                   @dec=68796526558321542419405677832866288094027461232937174622925256896107946151172,
#                   @bin=Bytes[152, 25, 116, 66, 143, 129, 98, 211, 248, 252, 226, 245, 141, 78, 86, 52, 20, 120, 232, 125, 9, 42, 235, 58, 14, 223, 138, 249, 125, 99, 141, 4]>>,
#           @address=#<Eth::Address:0x7f3719258be0
#               @address="0x2Ef1f605AF5d03874eE88773f41c1382ac71C239">>

key.private_hex
# => "d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51"

key.public_hex
# => "04bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04"

key.address.to_s
# => "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
```

## Documentation

Generate a local copy with:

```shell
crystal docs
```

## Testing

The library is entirely specified through tests in `./spec`; run:

```shell
crystal spec --verbose
```

## Contribute

Create a pull request, and make sure tests and linter pass.

This pure crystal implementation is based on the ruby implementation [q9f/eth.rb](https://github.com/q9f/eth.rb) which is also used as reference to write tests against.

License: Apache License v2.0

Contributors: [**@q9f**](https://github.com/q9f/)
