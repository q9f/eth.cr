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

describe Address do
  it "creates checksummed addresses" do
    Address.new("0x2Ef1f605AF5d03874eE88773f41c1382ac71C239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
    Address.new("0x2EF1F605AF5D03874EE88773F41C1382AC71C239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
    Address.new("0x2ef1f605af5d03874ee88773f41c1382ac71c239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
    Address.new("2Ef1f605AF5d03874eE88773f41c1382ac71C239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
    Address.new("2EF1F605AF5D03874EE88773F41C1382AC71C239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
    Address.new("2ef1f605af5d03874ee88773f41c1382ac71c239").to_s.should eq "0x2Ef1f605AF5d03874eE88773f41c1382ac71C239"
  end

  it "does not permit invalid addresses" do
    expect_raises Exception, "Invalid address: '5aaeb6053f3e94c9b9a09f33669435e7ef1beae' (invalid size)." do
      Address.new("0x5aaeb6053f3e94c9b9a09f33669435e7ef1beae")
    end
    expect_raises Exception, "Invalid address: 'fb6916095ca1df60bb79ce92ce3ea74c37c5d359d' (invalid size)." do
      Address.new("0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359d")
    end
    expect_raises Exception, "Invalid address: '5AAEB6053F3E94C9B9A09F33669435E7EF1BEAE' (invalid size)." do
      Address.new("0x5AAEB6053F3E94C9B9A09F33669435E7EF1BEAE")
    end
    expect_raises Exception, "Invalid address: 'FB6916095CA1DF60BB79CE92CE3EA74C37C5D359D' (invalid size)." do
      Address.new("0xFB6916095CA1DF60BB79CE92CE3EA74C37C5D359D")
    end
  end

  it "does not permit invalid checksums" do
    expect_raises Exception, "Invalid address: '5AAeb6053F3E94C9b9A09f33669435E7Ef1BeAed' (checksum mismatch)." do
      Address.new("0x5AAeb6053F3E94C9b9A09f33669435E7Ef1BeAed")
    end
    expect_raises Exception, "Invalid address: 'FB6916095ca1df60bB79Ce92cE3Ea74c37c5d359' (checksum mismatch)." do
      Address.new("0xFB6916095ca1df60bB79Ce92cE3Ea74c37c5d359")
    end
    expect_raises Exception, "Invalid address: 'DbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB' (checksum mismatch)." do
      Address.new("0xDbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB")
    end
    expect_raises Exception, "Invalid address: 'd1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb' (checksum mismatch)." do
      Address.new("0xd1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb")
    end
  end
end
