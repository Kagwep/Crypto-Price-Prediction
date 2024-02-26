import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import MinMaxScaler
import matplotlib.pyplot as plt
import os
from datetime import datetime
import onnxmltools

from giza_actions.model import GizaModel
from giza_actions.task import task
from giza_actions.action import Action, action

# Load the sample data
data = pd.read_csv('crypto_data.csv')

test_data = []

# Function to preprocess data based on user-selected source
def preprocess_data(data, source):
    data_filtered = data[data['VOLUME'] != 0]
    data_filtered = data_filtered[data_filtered['SOURCE'] == source]
    data_filtered['TIMESTAMP'] = pd.to_datetime(data_filtered['TIMESTAMP'], unit='s')
    return data_filtered

@task(name='Prediction with ONNX')
def prediction(prices):
    model = GizaModel(model_path="./forecast-model.onnx")
    result = model.predict(
        input_feed={"dense_input": prices}, verifiable=False
    )
    return result

@action(name='Execution: Prediction with ONNX', log_prints=True)
def execution():
    prices_data = test_data
    predicted_price = prediction(prices_data)
    print(f" Unverifiable inference Predicted Digit: {predicted_price}")
    return predicted_price

# Function to generate forecast using a feedforward neural network and plot
def generate_forecast(data, source, pair):
    global test_data
    # Preprocess the data based on the selected source
    data_source = preprocess_data(data, source)
    data_pair = data_source[data_source['NEW_PAIR_ID'] == pair]
    
    # Define the number of time steps for the forecast
    time_steps = 10
    
    # Number of actual price points to plot
    num_actual_points = 100
    
    # Preprocess the data for the selected pair
    prices = data_pair['PRICE'].values.reshape(-1, 1)
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaled_prices = scaler.fit_transform(prices)
    subset_prices = prices[-num_actual_points:]
    
    # Create sequences for the neural network
    X, y = [], []
    for i in range(len(scaled_prices) - time_steps):
        X.append(scaled_prices[i:i+time_steps, 0])
        y.append(scaled_prices[i + time_steps, 0])
    X, y = np.array(X), np.array(y)
    
    # Split data into train and test sets
    split = int(0.8 * len(X))
    X_train, X_test = X[:split], X[split:]
    y_train, y_test = y[:split], y[split:]
    
    # Define the neural network architecture
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(128, activation='relu', input_shape=(X_train.shape[1],)),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(32, activation='relu'),
        tf.keras.layers.Dense(16, activation='relu'),
        tf.keras.layers.Dense(8, activation='relu'),
        tf.keras.layers.Dense(1)
    ])

    
    # Compile the model
    model.compile(optimizer='adam', loss='mean_squared_error')
    
    # Train the model
    model.fit(X_train, y_train, epochs=100, batch_size=32, verbose=0)
    
    # Save the model to ONNX format
    onnx_model = onnxmltools.convert_keras(model, target_opset=11)
    onnx_model_path = 'forecast-model.onnx'
    onnxmltools.utils.save_model(onnx_model, onnx_model_path)
    
    # Make predictions for the next 10 minutes
    num_predictions = 10
    predicted_prices = []
    test_input = scaled_prices[-time_steps:].reshape(1, -1)
    
    np.save('test_input.npy', test_input)
    
    for _ in range(num_predictions):
        test_data = test_input.astype(np.float32)
        next_minute_price = execution()
        predicted_prices.append(next_minute_price[0, 0])
        test_input = np.append(test_input[:, 1:], next_minute_price.reshape(1, 1), axis=1)
    
    # Inverse transform the predicted prices
    predicted_prices = scaler.inverse_transform(np.array(predicted_prices).reshape(-1, 1))
    
    # Plot the results
    plt.figure(figsize=(10, 6))
    future_time_index = pd.date_range(start=data_pair['TIMESTAMP'].iloc[-1], periods=num_predictions + 1, freq='T')[1:]
    
    # Plot actual prices (subset)
    plt.plot(data_pair['TIMESTAMP'][-num_actual_points:], subset_prices, label='Actual', color='blue', linewidth=2)
    
    # Plot predicted prices
    plt.plot(future_time_index, predicted_prices, label='Predicted', color='red', linestyle='--', marker='o')
    
    plt.xlabel('Time')
    plt.ylabel('Price')
    plt.title(f'Forecast for Token Pair: {pair}')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    
    # Create the 'plots' directory if it doesn't exist
    if not os.path.exists('plots'):
        os.makedirs('plots')
    
    # Get the current date and time for the plot filename
    current_time = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    
    # Save the plot as an image in the 'plots' directory
    plot_filename = f'plots/plot_{current_time}.png'
    plt.savefig(plot_filename)
    
    # Close the plot
    plt.close()

# Call the function with desired inputs
source = 'COINBASE'
pair = 'ETH/USD'
generate_forecast(data, source, pair)
