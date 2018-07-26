require 'rspec'
require 'nmap_agent/version'

describe 'NmapAgent::VERSION' do
  it "NmapAgent::VERSION should be a string" do
    expect(NmapAgent::VERSION).to be_kind_of(::String)
  end

  it "NmapAgent::VERSION should have 3 levels" do
    expect(NmapAgent::VERSION.split('.').size).to eql(3)
  end

  it "NmapAgent::VERSION should have a number between 1-20 for each octet" do
    NmapAgent::VERSION.split('.').each do |octet|
      expect(octet.to_i).to be >= 0
      expect(octet.to_i).to be <= 40
    end
  end
end