# nmap-agent (client)

A container that performs NMAP scans and posts the results in JSON back to a central data store for post analysis

Inputs:
  - target(s)
  - scan options
  - reporting endpoint

Outputs
  - Simplified JSON result (based on NMAP XML) to a centralized data store

Benefits:
  - simplified format
  - deployable via docker
  - pass inputs via ENV vars
  - No running services
  - Multiple perspectives...
      * Scan from Docker => Prod Endpoint
      * Scan from Docker => Docker Network
      * Scan from Docker => VPC
      
# nmap-agent-server (server) / S3 bucket

A simple receiving endpoint for Simplified JSON port scan data

Inputs:
  - Uploads of Simplified JSON scan results via write only access (limit exposure if a single node is corrupted)
  
Outputs:
  - S3 bucket of Simplified JSON scan results via read-only access (limit exposure if policy node is corrupted)
  
Benefits:
  - No web application to secure/maintain
  - Easy access to raw data for alternative uses
  - Easy programmatics access to data store
  - AWS/DevOps friendly

# nmap2json (library)

Inputs:
  - NMAP scan XML
  
Outputs:
  - Simplified scan result JSON

Benefits:
  - Removes the burden of NMAP XML parsing for downstream processing
  - JSON is easily parsable by just about any programming lang

# nmap-policy (library)

a library that compares NMAP results to a predefined policy or set of expectation for a given perspective.  Failure to meet policy/expectations results in a failure condition.  User can wrap whatever they want around this to integrate with their escalation preferences.
