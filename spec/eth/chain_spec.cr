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

describe Chain do
  it "has eip155 chain ids for mainnets, testnets, and devnets" do
    # Chain IDs for selected mainnets
    Chain::ETHEREUM.should eq 1
    Chain::EXPANSE.should eq 2
    Chain::OPTIMISM.should eq 10
    Chain::CLASSIC.should eq 61
    Chain::POA_NET.should eq 99
    Chain::GNOSIS.should eq 100
    Chain::POLYGON.should eq 137
    Chain::ARBITRUM.should eq 42161

    # Chain IDs for selected testnets
    Chain::MORDEN.should eq 2
    Chain::ROPSTEN.should eq 3
    Chain::RINKEBY.should eq 4
    Chain::GOERLI.should eq 5
    Chain::KOTTI.should eq 6
    Chain::KOVAN.should eq 42
    Chain::MORDEN_CLASSIC.should eq 62
    Chain::MORDOR.should eq 63
    Chain::KOVAN_OPTIMISM.should eq 69
    Chain::XDAI_ARBITRUM.should eq 200
    Chain::GOERLI_OPTIMISM.should eq 420
    Chain::MUMBAI.should eq 80001
    Chain::RINKEBY_ARBITRUM.should eq 421611
    Chain::GOERLI_ARBITRUM.should eq 421613
    Chain::SEPOLIA.should eq 11155111
    Chain::HOLESKY.should eq 11166111

    # Chain IDs for selected private networks
    Chain::PRIVATE_GETH.should eq 1337
  end

  it "can detect ledger keys" do
    Chain.ledger?(-1).should be_false
    Chain.ledger?(0).should be_true
    Chain.ledger?(1).should be_true
    Chain.ledger?(2).should be_false
  end

  it "can detect legacy keys" do
    Chain.legacy?(26).should be_false
    Chain.legacy?(27).should be_true
    Chain.legacy?(28).should be_true
    Chain.legacy?(29).should be_false
  end

  it "can convert ethereum recovery ids to v" do
    Chain.to_v(0).should eq 27
    Chain.to_v(1).should eq 28
    Chain.to_v(0, Chain::ETHEREUM).should eq 37
    Chain.to_v(1, Chain::ETHEREUM).should eq 38
  end

  it "can convert other chain's recovery ids to v" do
    Chain.to_v(0, Chain::CLASSIC).should eq 157
    Chain.to_v(1, Chain::GNOSIS).should eq 236
    Chain.to_v(0, Chain::ARBITRUM).should eq 84357
    Chain.to_v(1, Chain::MORDEN_CLASSIC).should eq 160
    Chain.to_v(0, Chain::GOERLI_OPTIMISM).should eq 875
    Chain.to_v(1, Chain::RINKEBY_ARBITRUM).should eq 843258
    Chain.to_v(0, Chain::PRIVATE_GETH).should eq 2709
  end

  it "can recover v from ethereum recovery id" do
    Chain.to_recovery_id(0).should eq 0
    Chain.to_recovery_id(1).should eq 1
    Chain.to_recovery_id(27).should eq 0
    Chain.to_recovery_id(28).should eq 1
    Chain.to_recovery_id(37).should eq 0
    Chain.to_recovery_id(38).should eq 1
  end

  it "can recover v from other chain's recovery id" do
    Chain.to_recovery_id(157, Chain::CLASSIC).should eq 0
    Chain.to_recovery_id(236, Chain::GNOSIS).should eq 1
    Chain.to_recovery_id(84357, Chain::ARBITRUM).should eq 0
    Chain.to_recovery_id(160, Chain::MORDEN_CLASSIC).should eq 1
    Chain.to_recovery_id(875, Chain::GOERLI_OPTIMISM).should eq 0
    Chain.to_recovery_id(843258, Chain::RINKEBY_ARBITRUM).should eq 1
    Chain.to_recovery_id(2709, Chain::PRIVATE_GETH).should eq 0
  end

  it "raises an error for invalid v on chain ids" do
    expect_raises Exception, "Invalid v -1 value for chain ID 1. Invalid chain ID?" do
      Chain.to_recovery_id(-1)
    end
    expect_raises Exception, "Invalid v 36 value for chain ID 1. Invalid chain ID?" do
      Chain.to_recovery_id(36)
    end
    expect_raises Exception, "Invalid v 843258 value for chain ID 1337. Invalid chain ID?" do
      Chain.to_recovery_id(843258, Chain::PRIVATE_GETH)
    end
  end

  it "can recover chain ids from v" do
    Chain.to_chain_id(0).should be_nil
    Chain.to_chain_id(1).should be_nil
    Chain.to_chain_id(27).should be_nil
    Chain.to_chain_id(28).should be_nil
    Chain.to_chain_id(37).should eq Chain::ETHEREUM
    Chain.to_chain_id(38).should eq Chain::ETHEREUM
    Chain.to_chain_id(157).should eq Chain::CLASSIC
    Chain.to_chain_id(236).should eq Chain::GNOSIS
    Chain.to_chain_id(84357).should eq Chain::ARBITRUM
    Chain.to_chain_id(160).should eq Chain::MORDEN_CLASSIC
    Chain.to_chain_id(875).should eq Chain::GOERLI_OPTIMISM
    Chain.to_chain_id(843258).should eq Chain::RINKEBY_ARBITRUM
    Chain.to_chain_id(2709).should eq Chain::PRIVATE_GETH
  end
end
