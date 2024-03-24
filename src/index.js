import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import ParkingStatus from './components/ParkingStatus';
import {NextUIProvider} from "@nextui-org/react";
import Header from './components/Header';
import Footer from './components/Footer';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <NextUIProvider>
    <React.StrictMode>
      <Header/> 
      <ParkingStatus/>
      <Footer/>
    </React.StrictMode>
  </NextUIProvider>
  
);



