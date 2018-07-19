# A mockup of a possible Lambda function that can do the post processing of raw NMAP XML into JSON format

import json
import xmltodict

# TODO: make this read from S3 bucket events
f = open("output.xml")
xml_content = f.read()
f.close()

# TODO: instead of printing, insert the JSONified version into the ./json folder
# TODO: instead of using entire XML => JSON translation, consider simplifying the schema
print(json.dumps(xmltodict.parse(xml_content), indent=4, sort_keys=True))