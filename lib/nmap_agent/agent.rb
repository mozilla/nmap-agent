require 'json'
require 'nmap/program'
require 'nmap/xml'

module NmapAgent
  class Agent
    # Verify at an array of ENV vars are present and set, if not raise an exception with what we're missing
    def has_required_envs?(env_names=[])
      env_names.each do |env_name|
        raise "Environment variable '#{env_name}' is not set, aborting" if ENV[env_name].nil? || ENV[env_name].empty?
      end

      return true
    end

    def port_scan(output_file='latest.xml')
      has_required_envs?(
        [
          'SCAN_TCP_PORTS',
          'SCAN_NETWORK'
        ]
      )

      # Suppressing output is helpful to stop noise, however, it has potential to miss real issues...
      # suppress_output do

        # See Nmap::Task for options setting help...
        # 
        # https://github.com/sophsec/ruby-nmap/blob/master/lib/nmap/task.rb
        #
        Nmap::Program.scan do |nmap|
          nmap.service_scan = false
          nmap.os_fingerprint = false
          nmap.xml = output_file
          nmap.ports = ENV['SCAN_TCP_PORTS'].split(",")
          nmap.targets = ENV['SCAN_NETWORK']
          nmap.skip_discovery
        end

      # end
    end

    def send2s3(upload_file='latest.xml')
      has_required_envs?(
        [
          'SCAN_NETWORK',
          'SCAN_PERSPECTIVE_ID',
          'AWS_ACCESS_KEY_ID',
          'AWS_SECRET_ACCESS_KEY',
          'AWS_S3_BUCKET'
        ]
      )

      key = "xml/" + ENV['SCAN_PERSPECTIVE_ID'] + "/" + ENV['SCAN_NETWORK'].gsub(/\//,"_") + ".xml"
      client = Aws::S3::Client.new(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      )

      resp = client.put_object({
        bucket: ENV['AWS_S3_BUCKET'],
        key: key,
        body: File.read(upload_file),
      })
    end

  end
end