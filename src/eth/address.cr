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

# Provides an address object that ensures the address is valid and always
# checksummed according to EIP-55.
#
# Properties:
# * `address` (`String`): the Ethereum address.
class Eth::Address
  # Returns a checksummed string representation of the address.
  #
  # ```
  # Address.new("0x2ef1f605af5d03874ee88773f41c1382ac71c239").address
  # # => "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
  # ```
  getter address : String

  # Creates an address object that ensures the address is valid and always
  # checksummed according to EIP-55.
  #
  # Parameters:
  # * `addr` (`String`): the Ethereum address.
  #
  # Raises an exception if the address is invalid (no hex, of wrong size,
  # or the checksum is invalid).
  #
  # ```
  # Address.new "0x2ef1f605af5d03874ee88773f41c1382ac71c239"
  # # => #<Eth::Address:0x7fecd167a9c0
  # #           @address="0x2Ef1f605AF5d03874eE88773f41c1382ac71C239">
  # ```
  def initialize(addr : String)
    addr = assert_hexadecimal addr
    addr = assert_size addr
    unless is_valid? addr
      raise "Invalid address: '#{addr}' (checksum mismatch)."
    end
    @address = checksum addr
  end

  # Returns a checksummed string representation of the address.
  #
  # ```
  # Address.new("0x2ef1f605af5d03874ee88773f41c1382ac71c239").to_s
  # # => "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
  # ```
  def to_s : String
    @address
  end

  # Tells wether the valid is properly checksummed, all capital case,
  # or all lower case.
  private def is_valid?(addr : String) : Bool
    cksm = checksum addr
    upcs = addr.upcase
    dwcs = addr.downcase
    addr == remove_prefix(cksm) || addr == upcs || addr == dwcs
  end

  # Ensures the public address is checksummed.
  private def checksum(addr : String) : String
    addr = addr.downcase
    hash = Util.keccak(addr).to_zpadded_hex
    result = "0x"
    i = 0
    while i < addr.size
      k = hash[i].to_i 16
      if k >= 8
        result += "#{addr[i]}".upcase
      else
        result += "#{addr[i]}".downcase
      end
      i += 1
    end
    result
  end

  # Assists to determine wether a hex-string is prefixed.
  private def is_prefixed?(hex : String) : Bool
    prefix_match = /\A0x/.match hex
    unless prefix_match.nil?
      return true
    else
      return false
    end
  end

  # Assists to remove a `0x`-hex prefix.
  private def remove_prefix(hex : String) : String
    if is_prefixed? hex
      return hex[2..-1]
    else
      return hex
    end
  end

  # Assists to assert wether a `String` is hexadecimal or not.
  private def assert_hexadecimal(hex : String) : String
    if is_prefixed? hex
      hex = remove_prefix hex
    end
    hex_match = /\A[0-9a-fA-F]*\z/.match hex
    unless hex_match.nil?
      return hex_match.string
    else
      raise "Invalid hex data provided: '#{hex}'"
    end
  end

  # Assists to assert wether a Ethereum address is of correct size.
  private def assert_size(addr : String) : String
    if is_prefixed? addr
      addr = remove_prefix addr
    end
    if addr.size === 40
      return addr
    else
      raise "Invalid address: '#{addr}' (invalid size)."
    end
  end
end
