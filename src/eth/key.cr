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

# Provides an Ethereum account that entirely inherits an `Secp256k1::Key` and
# extends it by an Ethereum `address` field.
#
# Ref: [q9f/secp256k1.cr/Secp256k1/Key](https://q9f.github.io/secp256k1.cr/Secp256k1/Key.html)
#
# Properties:
# * `address` (`Address`): the Ethereum address.
class Eth::Key < Secp256k1::Key
  # Returns the Ethereum account address.
  #
  # ```
  # prv = Num.new "d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51"
  # key = Key.new prv
  # key.address
  # # => #<Eth::Address:0x7f3719258be0
  # #           @address="0x2Ef1f605AF5d03874eE88773f41c1382ac71C239">
  # ```
  getter address : Address

  # Creates a new, random Ethereum account.
  #
  # ```
  # Key.new
  # # => #<Eth::Key:0x7f3719247b10
  # #           @private_key=#<Eth::Num:0x7f3719b4f500
  # #               @hex="d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51",
  # #               @dec=97149512268879514742361644313413872500736768173592718417281501971026009718353,
  # #               @bin=Bytes[214, 200, 172, 228, 112, 171, 12, 224, 49, 37, 202, 198, 171, 242, 119, 156, 25, 157, 33, 164, 125, 62, 117, 233, 60, 33, 43, 30, 194, 60, 254, 81]>,
  # #           @public_key=#<Secp256k1::Point:0x7f3719246420
  # #               @x=#<Secp256k1::Num:0x7f3719b4fa40
  # #                   @hex="bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc",
  # #                   @dec=86414673301778591173569328850396232566766657919369855130423318525027519376124,
  # #                   @bin=Bytes[191, 12, 248, 201, 52, 189, 60, 87, 233, 98, 253, 242, 164, 126, 153, 214, 19, 107, 4, 127, 152, 126, 226, 224, 203, 3, 17, 12, 175, 217, 42, 252]>,
  # #               @y=#<Secp256k1::Num:0x7f3719b4fa00
  # #                   @hex="981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04",
  # #                   @dec=68796526558321542419405677832866288094027461232937174622925256896107946151172,
  # #                   @bin=Bytes[152, 25, 116, 66, 143, 129, 98, 211, 248, 252, 226, 245, 141, 78, 86, 52, 20, 120, 232, 125, 9, 42, 235, 58, 14, 223, 138, 249, 125, 99, 141, 4]>>,
  # #           @address=#<Eth::Address:0x7f3719258be0
  # #               @address="0x2Ef1f605AF5d03874eE88773f41c1382ac71C239">>
  # ```
  def initialize
    super
    @address = get_address
  end

  # Creates an Ethereum account from an existing private key.
  #
  # Parameters:
  # * `priv` (`Num`): the private key for the Ethereum Account.
  #
  # ```
  # prv = Num.new "d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51"
  # Key.new prv
  # # => #<Eth::Key:0x7f3719247b10
  # #           @private_key=#<Eth::Num:0x7f3719b4f500
  # #               @hex="d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51",
  # #               @dec=97149512268879514742361644313413872500736768173592718417281501971026009718353,
  # #               @bin=Bytes[214, 200, 172, 228, 112, 171, 12, 224, 49, 37, 202, 198, 171, 242, 119, 156, 25, 157, 33, 164, 125, 62, 117, 233, 60, 33, 43, 30, 194, 60, 254, 81]>,
  # #           @public_key=#<Secp256k1::Point:0x7f3719246420
  # #               @x=#<Secp256k1::Num:0x7f3719b4fa40
  # #                   @hex="bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc",
  # #                   @dec=86414673301778591173569328850396232566766657919369855130423318525027519376124,
  # #                   @bin=Bytes[191, 12, 248, 201, 52, 189, 60, 87, 233, 98, 253, 242, 164, 126, 153, 214, 19, 107, 4, 127, 152, 126, 226, 224, 203, 3, 17, 12, 175, 217, 42, 252]>,
  # #               @y=#<Secp256k1::Num:0x7f3719b4fa00
  # #                   @hex="981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04",
  # #                   @dec=68796526558321542419405677832866288094027461232937174622925256896107946151172,
  # #                   @bin=Bytes[152, 25, 116, 66, 143, 129, 98, 211, 248, 252, 226, 245, 141, 78, 86, 52, 20, 120, 232, 125, 9, 42, 235, 58, 14, 223, 138, 249, 125, 99, 141, 4]>>,
  # #           @address=#<Eth::Address:0x7f3719258be0
  # #               @address="0x2Ef1f605AF5d03874eE88773f41c1382ac71C239">>
  # ```
  def initialize(priv : Num)
    super priv
    @address = get_address
  end

  # Generates the public address for this keypair.
  private def get_address : Address
    hash = Util.keccak public_bytes[1, 64]
    Address.new hash.to_zpadded_hex[24, 40]
  end
end
