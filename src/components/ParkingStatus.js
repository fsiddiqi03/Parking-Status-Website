import React, { useEffect, useState } from 'react'
import {Card, CardHeader, CardBody, Image} from "@nextui-org/react";
import park from '../images/Parking.jpg';




const ParkingStatus = () => {
  const [status, setStatus] = useState(null)

  useEffect(() => {
    fetch("https://yb86bbj90f.execute-api.us-east-2.amazonaws.com/serverless_lambda_stage/getStatus?GarageID=01&GarageName=Main")
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        setStatus(data.status)
      })
      .catch((error) => {
        console.log('Error fetching status:', error)
        setStatus('Not Avialable')
      })

  }, [])
    
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
    </Card>
  </div>
);
}

export default ParkingStatus