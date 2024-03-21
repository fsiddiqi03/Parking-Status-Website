import boto3

# Initialize Boto3 DynamoDB client
dynamodb = boto3.resource('dynamodb', region_name='us-east-2')

def main():
    table_name = 'GarageStatus'
    table = dynamodb.Table(table_name)


    try:
        # Retrieve item from DynamoDB table using partition key and sort key 
        response = table.get_item(
            Key={
                'GarageID': '01',
                'GarageName': 'Main'  
            }
        )

        # Extract the value of the "Status" attribute
        status = response.get('Item', {}).get('Status')

        if status:
            print("Current status:", status)
        else:
            print("Status not found.")

    except Exception as e:
        print("Error:", e)

main()

