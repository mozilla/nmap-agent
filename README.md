# nmap-agent (client)

A container that performs NMAP scans and send results in JSON back to a central data store for post analysis

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
      
# S3 bucket (server)

A simple receiving location for Simplified JSON port scan data

Inputs:
  - Uploads of Simplified JSON scan results via write only access (limit exposure if a single node is corrupted)
  
Outputs:
  - S3 bucket of Simplified JSON scan results via read-only access (limit exposure if policy node is corrupted)
  
Benefits:
  - No web application to secure/maintain
  - Easy access to raw data for alternative uses
  - Easy programmatics access to data store
  - AWS/DevOps friendly

# nmap-policy (library) - TO BE BUILT

a library that compares Simplified NMAP JSON results to a predefined policy or set of expectation for a given perspective.  Failure to meet policy/expectations results in a failure condition.  User can wrap whatever they want around this to integrate with their escalation preferences.
