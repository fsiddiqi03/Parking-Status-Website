import React from 'react'
import {Card, CardHeader, CardBody, Image} from "@nextui-org/react";
import heroCardCompleteImage from '../images/hero-card-complete.jpeg';


const ParkingStatus = () => {
  return (
    <Card className="py-4" style={{ width: '300px' }}>
    <CardHeader className="pb-0 pt-2 px-4 flex-col items-start">
      <p className="text-tiny uppercase font-bold">Garage</p>
      <small className="text-default-500">Main</small>
      <h4 className="font-bold text-large">Status</h4>
    </CardHeader>
    <CardBody className="overflow-visible py-2">
      <Image
        alt="Card background"
        className="object-cover rounded-xl"
        src={heroCardCompleteImage}
        width={270}
      />
    </CardBody>
  </Card>
);
}

export default ParkingStatus