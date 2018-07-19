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

  def send2s3(upload_file='latest.xml')
    key = "xml/" + ENV['SCAN_NETWORK'].gsub(/\//,"_") + ".xml"

    puts "[+] Started uploading #{key} to S3"

    client = Aws::S3::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    resp = client.put_object({
      bucket: ENV['AWS_S3_BUCKET'],
      key: key,
      body: File.read(upload_file),
    })

    puts "[+] Finished uploading #{key} to S3"
  end

end