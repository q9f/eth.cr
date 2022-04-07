# eth.cr

[![Build Status](https://img.shields.io/github/workflow/status/q9f/eth.cr/Crystal)](https://github.com/q9f/eth.cr/actions)
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

## Documentation

The full library documentation can be found here: [q9f.github.io/eth.cr](https://q9f.github.io/eth.cr/)

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
