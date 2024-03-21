import boto3
import json


dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    table_name = 'GarageStatus'
    table = dynamodb.Table(table_name)

    body = json.loads(event['body'])


    garage_id = body['GarageID']
    new_status = body['Status']
    garage_name = body['Name']
    
    # Update the item in DynamoDB for the specified GarageID
    response = table.update_item(
        Key={
            'GarageID': garage_id,
            'GarageName': 'Main'  
        },
        UpdateExpression='SET #status = :status',
        ExpressionAttributeNames={
            '#status': 'Status'
        },
        ExpressionAttributeValues={
            ':status': new_status
        },
        ReturnValues="UPDATED_NEW"
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Update successful')
    }

