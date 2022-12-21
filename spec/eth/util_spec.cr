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

require "../spec_helper"

describe Util do
  it "can hash keccak correctly" do
    # keccak-256 hash taken from the crystal-sha3 readme
    # ref: https://github.com/OscarBarrett/crystal-sha3/blob/7b6f6e02196b106ecf0be01da207dbf1e269009b/README.md
    keccak = Util.keccak "abc123"
    keccak.to_hex.should eq "719accc61a9cc126830e5906f9d672d06eab6f8597287095a2c55a8b775e7016"

    # hash the previous hash again as bytes array instead of a string input
    keccak = Util.keccak keccak
    keccak.to_hex.should eq "438a3f652b00153f899189d56c7a70d0b3906b5a6ca4f585de47ac159b630bc0"
  end
end
