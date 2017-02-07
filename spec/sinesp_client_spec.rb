require "spec_helper"

describe SinespClient do
  it "has a version number" do
    expect(SinespClient::VERSION).not_to be nil
  end

  it "gets a valid plate" do
    result = SinespClient.search('ABC1234')
    expect(result).to be_a_kind_of Hash
    expect(result["codigoRetorno"]).to eq "0"
  end

  it "gets a invalid plate" do
    result = SinespClient.search('9999999')
    expect(result["codigoRetorno"]).to eq "1"
  end
end
