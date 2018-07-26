# nmap-agent (client)

A container that performs NMAP scans and send results to S3 for post analysis

Inputs:
  - target(s)
  - scan options
  - reporting endpoint

Outputs
  - Raw NMAP XML results sent to S3

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

A receiving location for scan results

Inputs:
  - Uploads scan results via write only access (limit exposure if a single node is corrupted)
  
Outputs:
  - S3 bucket scan results via read-only access (limit exposure if policy node is corrupted)
  
Benefits:
  - No web application to secure/maintain
  - Easy access to raw data for alternative uses
  - Easy programmatics access to data store
  - AWS/DevOps friendly

# nmap2json post processing (Lambda function)

a simple lambda function, which is run on any file that changes in an S3 bucket ./xml folder and produces a simplified ./json equivalent.  JSON is simply an easier format to work with and reduces the barrier of entry for really anything to use this data, including the policy framework.

# nmap-policy (TBD)

a policy/expectations framework for decribing service expectations for a given perspective
