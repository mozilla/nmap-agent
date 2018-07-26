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
end