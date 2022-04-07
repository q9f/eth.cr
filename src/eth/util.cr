# Copyright 2021-2022 Afr Schoe @q9f
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

# Provides a collection of utilities for convenience, e.g., to bind
# relevant hashing algorithms.
module Eth::Util
  extend self

  # Operating a Keccak hash on a binary/number or string literal.
  #
  # Parameters:
  # * `data` (`Num | Bytes | String`): the binary numeric or string literal to be hashed.
  # * `entropy` (`Int32`): the required entropy (default `256`).
  #
  # Returns a `Num` representing the Keccak hash.
  #
  # ```
  # Util.keccak(Num.new "0xdeadbeef").hex
  # # => "d4fd4e189132273036449fc9e11198c739161b4c0116a9a2dccdfa1c492006f1"
  #
  # Util.keccak("0xdeadbeef").hex
  # # => "4f440a001006a49f24a7de53c04eca3f79aef851ac58e460c9630d044277c8b0"
  # ```
  def keccak(data : Num | Bytes | String, entropy = 256) : Num
    keccak = Digest::Keccak3.new entropy
    if data.is_a? Num
      return Num.new keccak.update(data.to_bytes).hexdigest
    else
      return Num.new keccak.update(data).hexdigest
    end
  end
end
