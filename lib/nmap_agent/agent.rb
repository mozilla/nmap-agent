require 'json'
require 'nmap_agent'
require 'nmap/program'
require 'nmap/xml'
require 'nmap_agent/output_helper'

class Agent
  def run(file='latest.xml')
    port_scan(file)
    parse(file)
  end

  def port_scan(output_file='latest.xml')
    #suppress_output do
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
    #end
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
end