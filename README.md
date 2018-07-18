# nmap-agent (client)

A container that performs NMAP scans and posts the results in JSON back to a central receiving node for post analysis

Inputs:
  - target(s)
  - scan options
  - reporting endpoint

Outputs
  - Simplified JSON result (based on NMAP XML) that posts to a rest API of ur choice

Benefits:
  - simplified format, extremely easy for post processing
  - deployable via docker
  - pass inputs via ENV vars
  - No running services
  - Multiple perspectives...
      * Scan from Docker => Prod Endpoint
      * Scan from Docker => Docker
      * Scan from Docker => VPC
      
# nmap-agent-server (server)

A simple receiving endpoint for Simplified JSON port scan data

# nmap2json (library)

turns NMAP XML => Simplified JSON for devops magic

# nmap-policy (library)

a library that compares NMAP results to a predefined policy or set of expectation for a given perspective.  Failure to meet policy/expectations results in a failure condition that may require further investigation.
