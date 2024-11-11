## Overview

This MATLAB script implements a Radial Basis Function (RBF) network for classification, using the k-means clustering algorithm to determine the RBF centers. The script processes a dataset from a CSV file, splits it into training and testing sets, trains the RBF network, and evaluates its performance based on the accuracy of the predictions.

This code was developed as part of my Artificial Neural Networks (ANN) course project at IASBS.

## Features

- **Data Handling**: Reads the dataset from a CSV file (`iris.csv`).
- **Data Splitting**: Divides the dataset into training and testing sets based on user-specified percentage.
- **K-Means Clustering**: Determines cluster centers for both training and testing phases.
- **RBF Network**: Computes the RBF activation (phi matrix) and calculates weights for the network.
- **Performance Evaluation**: Compares the predicted outputs with true labels using a specified tolerance and computes the accuracy.

## Usage

### Prerequisites

- MATLAB installed on your system.
- `iris.csv` dataset placed in the same directory as the script.

### Steps

1. **Run the script**: Open the script in MATLAB and execute it.
2. **Provide inputs**:
   - Enter the percentage of the dataset to use for training when prompted.
   - Enter the number of centers (clusters) for the k-means algorithm.
3. **View results**:
   - The script displays the accuracy of the model as a percentage of correctly labeled validation inputs.

### Key Output

- The final accuracy of the model, displayed as:
  ```
  True Labeled validation inputs equals X%
  ```

## How It Works

1. **Data Loading**: Reads `iris.csv` into a matrix.
2. **Data Splitting**: Randomly partitions the dataset into training and testing sets.
3. **Training Phase**:
   - Applies k-means clustering to determine RBF centers.
   - Computes the phi matrix and calculates weights using the pseudoinverse method.
4. **Testing Phase**:
   - Applies k-means clustering on the test set.
   - Computes the phi matrix for testing and predicts outputs.
5. **Accuracy Calculation**:
   - Compares the predicted outputs to actual test data within a tolerance of 9%.
   - Displays the final accuracy.

## Customization

- **Dataset**: Replace `iris.csv` with any other dataset, ensuring it matches the expected format.
- **Tolerance**: Adjust the `ismembertol` tolerance value to change the accuracy evaluation criteria.
- **Number of Centers**: Experiment with different values for k-means centers to optimize performance.

## Limitations

- Assumes the dataset has at least two features for computing distances.
- Performance depends on the chosen number of centers and tolerance.