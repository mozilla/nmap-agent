# nmap-agent (starting point - containerized thing)

A tool that performs NMAP scans and posts the results in JSON back to a central receiving node for analysis

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


# nmap-2-json (library it uses)

turns NMAP XML => JSON

# nmap-unit-tests/nmap-policy (library) (after we have the data, we can process it, but maybe you want that locally, maybe it's live on the agent, I dunno)

A tool to build unit-tests for NMAP expectations and alert when those expectations are not met