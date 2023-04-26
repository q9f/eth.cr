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

# Provides constants for common Ethereum units.
module Eth::Unit
  extend self

  # Ethereum unit 1 wei := 0.000000000000000001 Ether.
  WEI = Num.new BigInt.new 1

  # Ethereum unit 1 babbage := 0.000000000000001 Ether or 1_000 wei.
  BABBAGE = Num.new BigInt.new 1e3

  # Ethereum unit 1 lovelace := 0.000000000001 Ether or 1_000_000 wei.
  LOVELACE = Num.new BigInt.new 1e6

  # Ethereum unit 1 shannon := 0.000000001 Ether or 1_000_000_000 wei.
  SHANNON = Num.new BigInt.new 1e9

  # Ethereum unit 1 szabo := 0.000_001 Ether or 1_000_000_000_000 wei.
  SZABO = Num.new BigInt.new 1e12

  # Ethereum unit 1 finney := 0.001 Ether or 1_000_000_000_000_000 wei.
  FINNEY = Num.new BigInt.new 1e15

  # Ethereum unit 1 Ether := 1_000_000_000_000_000_000 wei.
  ETHER = Num.new BigInt.new 1e18

  # Ethereum unit 1 Gwei := 0.000000001 Ether or 1_000_000_000 wei.
  # Same as shannon, but more commonly used (billion wei).
  GWEI = SHANNON

  # Ethereum unit 1 ETH := 1 Ether or 1_000_000_000_000_000_000 wei.
  # Same as Ether, but more commonly used abbreviation.
  ETH = ETHER
end
