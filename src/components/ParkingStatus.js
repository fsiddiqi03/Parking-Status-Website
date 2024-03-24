import React, { useEffect, useState } from 'react'
import {Card, CardHeader, CardBody, Image, Button} from "@nextui-org/react";
import park from '../images/Parking.jpg';




const ParkingStatus = () => {
  const [status, setStatus] = useState(null);
  const [isLoading, setIsLoading] = useState(false)

  const fetchStatus = () => {
    setIsLoading(true)
    fetch("https://yb86bbj90f.execute-api.us-east-2.amazonaws.com/serverless_lambda_stage/getStatus?GarageID=01&GarageName=Main")
      .then((res) => res.json())
      .then((data) => {
        setStatus(data.status)
        setIsLoading(false)
      })
      .catch((error) => {
        console.log('Error fetching status:', error);
        setStatus('Not Available');
      });
  };

  // Step 2: Call the fetchStatus function when the component mounts.
  useEffect(() => {
    fetchStatus();
  }, []);
    
  return (
    <div className="flex justify-center items-center min-h-screen" >
      <Card className="w-126 h-auto py-4">
      <CardHeader className="pb-0 pt-2 px-4 flex-col items-start">
        <p className="text-tiny uppercase font-bold">Garage</p>
        <small className="text-default-500">Main</small>
        <h4 className="font-bold text-large">{status ? status : 'Not Avialable'} </h4>
      </CardHeader>
      <CardBody className="overflow-visible py-2">
        <Image
          alt="Card background"
          className="object-cover rounded-xl"
          src={park}
          width={270}
        />
      </CardBody>
      <Button color='danger' variant='shadow' isLoading = {isLoading} onClick={fetchStatus}>Refresh</Button>
    </Card>
  </div>
);
}

export default ParkingStatus