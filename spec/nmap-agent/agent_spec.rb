require 'rspec'
require 'nmap_agent/agent'
require 'securerandom'

describe NmapAgent::Agent do
  it "NmapAgent::Agent should not raise when there are no expectations" do
    agent = NmapAgent::Agent.new()

    expect(agent.has_required_envs?([])).to be(true)
  end

  it "NmapAgent::Agent should raise when expectations are not met" do
    agent = NmapAgent::Agent.new()
    random_env_name = SecureRandom.uuid

    expect { agent.has_required_envs?([random_env_name]) }.to raise_error("Environment variable '#{random_env_name}' is not set, aborting")
  end

  it "NmapAgent::Agent.port_scan should raise when expectations are not met" do
    agent = NmapAgent::Agent.new()
    expect { agent.port_scan() }.to raise_error("Environment variable 'SCAN_NETWORK' is not set, aborting")
  end

  it "NmapAgent::Agent.send2s3 should raise when expectations are not met" do
    agent = NmapAgent::Agent.new()
    expect { agent.send2s3() }.to raise_error("Environment variable 'SCAN_NETWORK' is not set, aborting")
  end

end