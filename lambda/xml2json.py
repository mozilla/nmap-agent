# A mockup of a possible Lambda function that can do the post processing of raw NMAP XML into JSON format

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
     
    #TODO: only look for stuff in ./xml/*.xml
    #TODO: translate XML file to JSON and dump into ./json/*.json

    key = urllib.unquote_plus(event['Records'][0]['s3']['object']['key'])
    try:
        print("Using waiter to waiting for object to persist thru s3 service…")
        waiter = s3.get_waiter('object_exists')
        waiter.wait(Bucket=bucket, Key=key)
        response = s3.head_object(Bucket=bucket, Key=key)
        print("CONTENT TYPE: " + response['ContentType'])
        print("ETag: " + response['ETag'])
        print("Content-Length: ", response['ContentLength'])
        print("Keyname: " + key)
        print("Deleting object…" + key)
        s3.delete_object(Bucket=bucket, Key=key)
        return response['ContentType']
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist '
              'and your bucket is in the same region as this '
              'function.'.format(key, bucket))
    raise e