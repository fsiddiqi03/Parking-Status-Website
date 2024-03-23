import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import ParkingStatus from './components/ParkingStatus';
import {NextUIProvider} from "@nextui-org/react";


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <NextUIProvider>
    <React.StrictMode>
      <ParkingStatus/>
    </React.StrictMode>
  </NextUIProvider>
  
);



