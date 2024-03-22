import boto3
import json

# Initialize Boto3 DynamoDB client
dynamodb = boto3.resource('dynamodb', region_name='us-east-2')

def lambda_status_handler(event, context):
    table_name = 'GarageStatus'
    table = dynamodb.Table(table_name)


    GarageID = event['queryStringParameters'].get('GarageID')
    GarageName = event['queryStringParameters'].get('GarageName')

    if not GarageID or not GarageName:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'GarageID and Name are required fields'})
        }
    
    try:
        # Retrieve item from DynamoDB table using partition key and sort key 
        response = table.get_item(
            Key={
                'GarageID': GarageID,
                'GarageName': GarageName  
            }
        )

        # Extract the value of the "Status" attribute
        status = response.get('Item', {}).get('Status')

        if status:
            return {
                'statusCode': 200,
                'body': json.dumps({'status' : status})
            }
        else:
            return {
                'statusCode': 404,
                'body': json.dumps({'error': 'Status not found'})
            }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }



