# Crypto Price Prediction with Verifiable Inference

This project utilizes Giza Actions to demonstrate verifiable inference for cryptocurrency price prediction using a feedforward neural network.

## Dependencies
- pandas
- numpy
- tensorflow
- sklearn
- matplotlib
- onnxmltools
- giza-actions

## Functionality

### Data Preprocessing:

- Loads data from a CSV file (`crypto_data.csv`).
- Filters data based on user-specified source (`source`) using the `preprocess_data` function.

### Prediction with ONNX:
- Defines a prediction task that takes prices as input and utilizes the `GizaModel` class to load a pre-trained model (`forecast-model.onnx`) for unverifiable inference.
- Defines an execution action that calls the prediction task and logs the predicted price.
- model endpoint: https://deployment-kagwe-369-2-3882209b-7i3yxzspbq-ew.a.run.app

### Forecast Generation:
- The `generate_forecast` function takes data, source, and pair as input.
- Preprocesses data based on the source and pair.
- Defines a neural network architecture using TensorFlow Keras.
- Trains the model on the selected data.
- Saves the trained model in ONNX format (`forecast-model.onnx`).
- Uses the execution action for sequential price predictions for the next 10 minutes.
- Inverts the scaled predictions back to original price values.
- Plots the actual and predicted prices.
- Saves the plot as an image.

![ETH/USD](https://github.com/Kagwep/Crypto-Price-Prediction/blob/main/plots/plot_2024-02-25_17-46-42.png)

![BTC/USD](https://github.com/Kagwep/Crypto-Price-Prediction/blob/main/plots/plot_2024-02-26_16-06-44.png)

## Usage
1. Install the required dependencies.
2. Place your pre-trained model in the same directory as the script (named `forecast-model.onnx`).
3. Update the `source` and `pair` variables in the `generate_forecast` call with your desired values.
4. Run the script. The script will generate a forecast plot and save it in the plots directory.

| Sources                                               | Pairs  |
|--------------------------------------------------------------|---------------|
| ASCENDEX, OKX, BITSTAMP, COINBASE, KAIKO, FLOWDESK, SKYNET_TRADING, GECKOTERMINAL, DEFILLAMA, CEX | ETH/USD, BTC/USD, USDC/USD, DAI/USD |

*The plots use the `COINBASE` source*


## Verifiable Inference

`verifiable_inference.py`

Key Steps:

### Import Necessary Libraries:
- numpy for numerical operations
- giza_actions.model for interacting with the  Cairo model
- giza_actions.task for defining tasks
- giza_actions.action for defining actions
- tensorflow (optional) for specific model interactions

### Define the prediction Function:
- Takes data, model ID, and version ID as input.
- Initializes a GizaModel instance.
- Calls the predict function with:
  - verifiable=True to enable verifiable prediction.
  - output_dtype="arr_fixed_point" to specify expected output format.
- Returns the prediction result and request ID.

### Define the execution Function:
- Loads input data from a NumPy array (test_input.npy).
- Calls the prediction function with data, model ID, and version ID.
- Returns prediction result and request ID.

### Execute the Prediction and Print Output:
- Calls the execution function.
- Prints the prediction result and request ID.

**IMPORTANT NOTE:**
Inverse Transformation: The predicted values will require inverse transformation before being used in further calculations or applications.

![Verifiable Inference](https://github.com/Kagwep/Crypto-Price-Prediction/blob/main/verifiiable_inverence.PNG)


 
## Data Acquisition Using Pragma Oracle (Optional)

If you need to gather a new set of data

### Prerequisites:
- Node.js and npm installed
- A Braavos or Argent wallet connected to the relevant blockchain network (clarify the specific network)
- Project dependencies installed

### Steps:
1. Navigate to the data-client directory:

    ```bash
    cd data-client
    ```

2. Install dependencies:

    ```bash
    npm install
    ```

3. Start development server:

    ```bash
    npm run dev
    ```

4. Connect your wallet:
   - Follow the on-screen instructions to connect your Braavos or Argent wallet.

5. Run the data service:
   - Access http://localhost:<port>/ in your browser (or the specified address).
   - Initiate data gathering and access download options as needed.

### Data Collection:
- The service fetches crypto data using a "pragma oracle," a mechanism for accessing off-chain data from a smart contract.
- It collects price information for specified token pairs at regular intervals.
- Data is stored in local storage for 10 minutes, allowing for both immediate and later retrieval.

### Downloading Data:
- "Download Data" button: Downloads data from local storage.
- "Download JSON" button: Downloads data as a JSON file for further analysis or integration.

* navigate into the data directory and use the `process_data.py` file to process the data.


# Crypto-Price-Prediction
