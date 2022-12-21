# Copyright 2021-2023 Afr Schoe @q9f
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Encapsulates `Eth::Chain` IDs and utilities for EIP-155 compatibility.
#
# Ref: <https://eips.ethereum.org/EIPS/eip-155>
module Eth::Chain
  extend self

  # Chain ID for Ethereum mainnet.
  ETHEREUM = 1

  # Chain ID for Expanse mainnet.
  EXPANSE = 2

  # Chain ID for Optimistic Ethereum mainnet.
  OPTIMISM = 10

  # Chain ID for Ethereum Classic mainnet.
  CLASSIC = 61

  # Chain ID for POA Network mainnet.
  POA_NET = 99

  # Chain ID for Gnosis mainnet.
  GNOSIS = 100

  # Chain ID for the Polygon Matic mainnet.
  POLYGON = 137

  # Chain ID for Arbitrum mainnet.
  ARBITRUM = 42161

  # Chain ID for Morden (Ethereum) testnet.
  MORDEN = 2

  # Chain ID for Ropsten testnet.
  ROPSTEN = 3

  # Chain ID for Rinkeby testnet.
  RINKEBY = 4

  # Chain ID for Goerli testnet.
  GOERLI = 5

  # Chain ID for Kotti testnet.
  KOTTI = 6

  # Chain ID for Kovan testnet.
  KOVAN = 42

  # Chain ID for Morden (Classic) testnet.
  MORDEN_CLASSIC = 62

  # Chain ID for Mordor testnet.
  MORDOR = 63

  # Chain ID for Optimistik Kovan testnet.
  KOVAN_OPTIMISM = 69

  # Chain ID for Arbitrum xDAI testnet.
  XDAI_ARBITRUM = 200

  # Chain ID for Optimistic Goerli testnet.
  GOERLI_OPTIMISM = 420

  # Chain ID for the Polygon Mumbai testnet.
  MUMBAI = 80001

  # Chain ID for Arbitrum Rinkeby testnet.
  RINKEBY_ARBITRUM = 421611

  # Chain ID for Arbitrum Nitro Goerli testnet.
  GOERLI_ARBITRUM = 421613

  # Chain ID for Sepolia testnet.
  SEPOLIA = 11155111

  # Chain ID for Holesovice testnet.
  HOLESOVICE = 11166111

  # Chain ID for the geth private network preset.
  PRIVATE_GETH = 1337

  # Checks if a provided `v` belongs to a Ledger wallet signature without
  # EIP-155 replay protection.
  #
  # Parameters:
  # * `v` (`Int32`): the signature's `v` value.
  #
  # ```
  # Chain.ledger? 0
  # # => true
  # ```
  def ledger?(v : Int32)
    0 === v || 1 === v
  end

  # Checks if a provided `v` belongs to a legacy signature without
  # EIP-155 replay protection.
  #
  # Parameters:
  # * `v` (`Int32`): the signature's `v` value.
  #
  # ```
  # Chain.legacy? 27
  # # => true
  # ```
  def legacy?(v : Int32)
    27 === v || 28 === v
  end

  # Converts a provided `v` value to an ECDSA recovery ID for the
  # given EIP-155 chain ID.
  #
  # Parameters:
  # * `v` (`Int32`): the signature's `v` value.
  # * `chain_id` (`Int32`): the chain ID the signatrue was generated on
  #   (default: `ETHEREUM`).
  #
  # Raises an exception if the `v` value does not match the chain ID.
  #
  # ```
  # Chain.to_recovery_id 38
  # # => 1
  # ```
  def to_recovery_id(v : Int32, chain_id : Int32 = ETHEREUM)
    e : Int32 = 0 + 2 * chain_id + 35
    i : Int32 = 1 + 2 * chain_id + 35
    if ledger?(v)
      # for ledger devices recovery id equals v
      return v
    elsif legacy?(v)
      # for pre-eip-155 cases, we just subtract 27 (legacy)
      return v - 27
    elsif e === v || i === v
      # this is the eip-155 case
      return v - 35 - 2 * chain_id
    else
      raise "Invalid v #{v} value for chain ID #{chain_id}. Invalid chain ID?"
    end
  end

  # Converts a provided recovery ID to the according `v` for legacy
  # signatures without EIP-155 replay protection.
  #
  # Parameters:
  # * `recovery_id` (`Int32`): the recovery ID.
  #
  # ```
  # Chain.to_v 1
  # # => 28
  # ```
  def to_v(recovery_id : Int32)
    return 27 + recovery_id
  end

  # Converts a provided recovery ID to the according `v` for signatures
  # with EIP-155 replay protection.
  #
  # Parameters:
  # * `recovery_id` (`Int32`): the recovery ID.
  # * `chain_id` (`Int32`): the chain ID the signatrue was generated on.
  #
  # ```
  # Chain.to_v(1, Chain::ETHEREUM)
  # # => 38
  # ```
  def to_v(recovery_id : Int32, chain_id : Int32)
    if chain_id < 1
      return to_v(recovery_id)
    else
      return 2 * chain_id + 35 + recovery_id
    end
  end

  # Converts a provided `v` value to an EIP-155 chain ID. This does not
  # work for legacy signatures with `v < 36` and return `nil` in that
  # case.
  #
  # Parameters:
  # * `v` (`Int32`): the signature's `v` value.
  #
  # ```
  # Chain.to_chain_id 38
  # # => 1
  # ```
  def to_chain_id(v : Int32)
    return nil if v < 36
    chain_id = (v - 35) // 2
    return nil if chain_id < 1
    return chain_id
  end
end
