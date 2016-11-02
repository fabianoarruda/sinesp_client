require "spec_helper"

describe SinespClient do
  it "has a version number" do
    expect(SinespClient::VERSION).not_to be nil
  end

  it "gets a valid plate" do
    expect(SinespClient.search('ABC1234')).to be_a_kind_of Hash
  end

  it "gets a invalid plate" do
    result = SinespClient.search('9999999')
    expect(result["codigoRetorno"]).to eq "1"
  end
end
