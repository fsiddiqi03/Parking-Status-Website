import boto3
import json

dynamodb = boto3.resource('dynamodb', region_name='us-east-2')

def lambda_handler(event, context):
    try:
        table_name = 'GarageStatus'
        table = dynamodb.Table(table_name)

        body = json.loads(event['body'])

        garage_id = body.get('GarageID')
        new_status = body.get('Status')
        garage_name = body.get('Name')
        
        if not garage_id or not new_status or not garage_name:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'GarageID, Name, and Status are required fields'})
            }
        
        # Update the item in DynamoDB for the specified GarageID
        response = table.update_item(
            Key={
                'GarageID': garage_id,
                'GarageName': garage_name  
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

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }


