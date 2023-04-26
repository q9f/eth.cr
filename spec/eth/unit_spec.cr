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

describe Unit do
  it "understands Ethereum units" do
    Unit::WEI.dec.should eq 1
    Unit::BABBAGE.dec.should eq 1_000
    Unit::LOVELACE.dec.should eq 1_000_000
    Unit::SHANNON.dec.should eq 1_000_000_000
    Unit::SZABO.dec.should eq 1_000_000_000_000
    Unit::FINNEY.dec.should eq 1_000_000_000_000_000
    Unit::ETHER.dec.should eq 1_000_000_000_000_000_000

    Unit::GWEI.dec.should eq 1_000_000_000
    Unit::ETH.dec.should eq 1_000_000_000_000_000_000
  end
end
