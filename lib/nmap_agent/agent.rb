require 'json'
require 'nmap_agent'
require 'nmap/program'
require 'nmap/xml'

class Agent
  def port_scan(output_file='latest.xml')
    puts "[+] Started scanning #{ENV['SCAN_NETWORK']}"
    
    suppress_output do
      Nmap::Program.scan do |nmap|
        nmap.service_scan = false
        nmap.os_fingerprint = false
        nmap.xml = output_file

        # Example: 20,21,22,23,25,80,110,443,512,522,8080,1080
        nmap.ports = ENV['SCAN_TCP_PORTS'].split(",")

        # Example: 192.168.0.*
        nmap.targets = ENV['SCAN_NETWORK']

        # -Pn
        nmap.skip_discovery
      end
    end

    puts "[+] Finished scanning #{ENV['SCAN_NETWORK']}"
  end

  def parse(input_file='latest.xml')
    scan = {}

    ::Nmap::XML.new(input_file) do |xml|
      xml.each_host do |host|
        # Don't list a host if it doesn't have open ports
        next if host.open_ports.empty?
        scan[host.ip] = []
        host.each_port do |port|
          # Require port state to be open, we don't care about non-open ports
          if port.state == :open
            scan[host.ip] << {:port => port.number, :protocol => port.protocol, :state => port.state}
          end
        end
      end
    end

    scan
  end

  def send2s3(upload_file='latest.xml')
    key = ENV['SCAN_NETWORK'].gsub(/\//,"_") + ".json"

    puts "[+] Started uploading #{key} to S3"

    client = Aws::S3::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    resp = client.put_object({
      bucket: ENV['AWS_S3_BUCKET'],
      key: key,
      body: parse(upload_file).to_json,
    })

    puts "[+] Finished uploading #{key} to S3"
  end

end