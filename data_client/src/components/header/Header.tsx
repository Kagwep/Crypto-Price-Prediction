import React, {useState,useEffect} from 'react'
import './header.css'
import "slick-carousel/slick/slick.css"; 
import "slick-carousel/slick/slick-theme.css";
import Slider from "react-slick";
import seller1 from '../../assets/profile.png'
import seller2 from '../../assets/profile.png'
import seller3 from '../../assets/profile.png'
import seller4 from '../../assets/profile.png'
import seller5 from '../../assets/profile.png'
import seller6 from '../../assets/profile.png'
import verify from '../../assets/verify.png'
import coin from '../../assets/coin.png'
import starkpay from '../../assets/starkpay.png'
import { Link  } from 'react-router-dom';
import { BigNumber } from "bignumber.js"
import {
  bigintToLongStr,
  bigintToLongStrAddress,
  bigintToShortStr,
  encoder,
  generateShortWalletAddress,
  getRealPrice,
  TOKENS,
  Token
} from "../../config/utils";
import { useAppContext } from "../../providers/AppProvider";
import { CairoCustomEnum } from "starknet"

const Header = () => {
  var settings = {
    dots: false,
    infinite: false,
    speed: 500,
    slidesToShow: 5,
    slidesToScroll: 1,
    initialSlide: 0,
    swipeToSlide:true,
    responsive: [
      {
        breakpoint: 1160,
        settings: {
          slidesToShow: 4,
          slidesToScroll: 1,
          swipeToSlide:true,
        }
      },
      {
        breakpoint: 950,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1,
          swipeToSlide:true,
        }
      },
      {
        breakpoint: 750,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
          initialSlide: 2,
        }
      },
      {
        breakpoint: 550,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1
        }
      },
      {
        breakpoint: 470,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 400,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
          variableWidth: true,
        }
      }
    ]
  };

  const { account, contract,pragma_contract,address } = useAppContext();

  const [allPrices, setPrices] = useState({});
  const [ media_prices, setMedianPrices] =useState({});
  const dataObjects: any[] = [];

    async function getService() {
      // const contract = new Contract(CONTRACT_ABI, CONTRACT_ADDRESS, account);

      // console.log("this is the list");
      if (contract) {

        
        async function fetchPricesForTokens(tokens: Token[]): Promise<{ [pair_id: string]: number }> {
          const prices: { [pair_id: string]: number } = {};
      
          // Create an array of promises for fetching prices
          const pricePromises: Promise<void>[] = tokens.map(async (token) => {
              const SPOTENTRY_ENUM = new CairoCustomEnum({
                  SpotEntry: token.pair_id
              });


      
              try {
                  const res = await pragma_contract.get_data_entries(SPOTENTRY_ENUM);
                  const get_data = await pragma_contract.get_data_median(SPOTENTRY_ENUM);
              
                  res.forEach((item: any) => {
                    // Process each item here
                    const data = item.variant.Spot; // For example, logging each item

                    const publisher = bigintToShortStr(data.base.publisher)

                    const decimals = BigNumber(get_data.decimals).toNumber()

                    const price = BigNumber(data.price).dividedBy(10 ** decimals).toNumber();

                    const timestamp = BigNumber(data.base.timestamp).toNumber();

                    const new_pair_id = bigintToShortStr(data.pair_id);

                    const source = bigintToShortStr(data.base.source)

                    const volume  = BigNumber(data.volume).toNumber()

                    const dataObject = {
                      PUBLISHER: publisher,
                      DECIMALS: decimals,
                      PRICE: price,
                      TIMESTAMP: timestamp,
                      NEW_PAIR_ID: new_pair_id,
                      SOURCE: source,
                      VOLUME: volume
                  };

                  dataObjects.push(dataObject);
                    // You can perform any operations you need with each item here
                });

              } catch (error) {
                  console.error(`Error fetching data for token ${token.pair_id}:`, error);
              }
          });
      
          // Wait for all promises to resolve
          await Promise.all(pricePromises);


      
          return prices;
      }
  

       await fetchPricesForTokens(TOKENS);
  
      }
      // contract ? console.log(contract) : "contract not yet loaded";
    }

let data_point_count = 0;
// Define a function to run getService every minute for 10 minutes
function runServiceForTenMinutes() {
  // Call getService immediately (for the first time)
 


  

  if (data_point_count < 181){
    console.log("Data point ",data_point_count);
  }

  data_point_count = data_point_count + 1

  
  getService();

  // Stop calling getService after 10 minutes (600,000 milliseconds)
  setTimeout(() => {
      console.log('Service stopped after 5 hours.');
      const jsonFileContent = JSON.stringify(dataObjects);
      localStorage.setItem('dataObjects.json', jsonFileContent);
  }, 18000000); // 10 minutes
}

setInterval(runServiceForTenMinutes, 60000);

const downloadJsonFile = () => {
  const jsonStr = JSON.stringify(dataObjects, null, 2);
  const blob = new Blob([jsonStr], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  
  const a = document.createElement('a');
  a.href = url;
  a.download = 'blobdata.json';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
};

  function downloadDataFromLocalStorage() {
    // Retrieve the data from localStorage
    const jsonData = localStorage.getItem('dataObjects.json');

    if (jsonData) {
        // Convert the JSON data to a Blob
        const blob = new Blob([jsonData], { type: 'application/json' });

        // Create a temporary anchor element
        const downloadLink = document.createElement('a');
        downloadLink.href = URL.createObjectURL(blob);
        downloadLink.download = 'l_data.json';

        // Simulate a click on the anchor element to trigger the download
        downloadLink.click();

        // Clean up by revoking the object URL
        URL.revokeObjectURL(downloadLink.href);
    } else {
        // Handle the case when no data is found in localStorage
        console.error('No data found in localStorage');
    }
}

// Example usage: Trigger the download when a button is clicked
<button onClick={downloadDataFromLocalStorage}>Download Data</button>


  return (
    <div className='header section__padding'>
      <div className="header-content">
        <div>
          <h1>Get Data Entries</h1>
          <img className='shake-vertical' src={"starkpay"} alt="" />
        </div>
      </div>
      <div className='break'>

      </div>
      <div className="">

        <>

        <button className='create-service-button' onClick={downloadDataFromLocalStorage}>Download Data</button>
        <div className='break'>
        </div>
        <button className='create-service-button' onClick={downloadJsonFile}>Download JSON</button>
        
        </>
       
      </div>
    </div>
  )
}

export default Header
function setLink(arg0: string) {
  throw new Error('Function not implemented.');
}

