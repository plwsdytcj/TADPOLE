# TADPOLE
 # A model in Python to forecast further measurements of Alzheimer’s disease based on historical measurements of   patients with Recurrent Neural Network model using Keras on a TensorFlow backend
 The files are categorized into four parts:
1. Data Processing
	--- Test_data
	--- Train_data
	--- Vaid_data
In this file, there are 3 sub files for preprocessing input data like delete blank variables and imputation. In each file, there is a step instruction about how to preprocess files.

2 Carry-forward
	--- input.xls
	--- targetvalid. xls
	--- targettest. xls
	--- targettrain. xls
	--- test.m
The first four xls files are the same as the given TADPOLE data renamed. The test.m implements the carry-forward algorithm.
How to run the CarryForward model:
To run the code, you need to set up Matlab and run the test.m in it. Details of codes can be found in the comments in test.m.

3. SVM
	--- SVR
	     --- SVR.py
	     --- dataset3
	           ---target_train.csv
	           ---input_train.csv
	           ---input_test.csv
	           ---input_valid.csv
	           ---target_test.csv
	           ---target_valid.csv
	--- SVC
	     --- SVC.py
	     --- target_test.csv
	     --- target_test.csv
	     --- target_test.csv
In SVM file, there are 2 sub files: SVR and SVC. In SVR, SVR.py can be used for regression prediction and preprocessed datasets are in dataset3. In SVC, SVC.py can be used for classification prediction and it has 3 preprocessed datasets. The details of data processing can be found in our report.
How to run the SVM models:
All parameters are set inside the SVR.py and SVC.py. To change to parameters, you will need to modify the parameters inside the code. Details of the SVM can be found in the comments of the code.
Example: call python SVR..py (SVC.py)

3. Data-modified LSTM
	--- LSTM_regression.py
	--- LSTM_classification.py
	--- dataset5
	--- dataset5copy
The LSTM_regression.py and dataset5 are used to predict 3 continuous variables while LSTM_classification.py and dataset5copy are used to make classification. The datasets in dataset5 and dataset5copy have been preprocessed.
How to run the D-LSTM::
All parameters are set inside the D-LSTM.py. To change to parameters, you will need to modify the parameters inside the code. Details of the data-modified LSTM can be found in the comments of the code.
Example: call python D-LSTM.py

4. Time-aware LSTM[1]
	--- T-LSTM-master
	     --- main.py
	     --- result_AD.mat
	     --- result_ADAS13.mat
	     --- result_Vent.mat
	     --- result_MMSE.mat
	---T-LSTM-master_Classification
	     --- main.py
	     --- result_AD.mat
	     --- result_test_AD.mat
	     --- result_valid_AD.mat
There are many similar datasets in T-LSTM-master because we have training, testing and validation datasets so we just list the sub flies of training datasets here. The original data needs to be transformed from CSV to the .mat format of MATLAB. The original information is decomposed into three .mat file. (i) Result_patient.mat:  1*12 cell, each cell yields[ number of patient * visit times+1* features] (ii)Result_types.mat 1*12 cell, if classification task, each cell yields[ number of patient * one-hot encoded output]. If regression task, each cell yields  [ number of patient *1 ](iii)Result_time.mat: 1*12 cell, each cell yields[ number of patient * 1*time elapse of visits].
How to run the T-LSTM:
Data is a list where each element is a 3 dimensional matrix which contains same length sequences.
Instead of zero padding, same length sequences are put in the same batch.
Example: L is the list containing all the batches with a length of N.
         L[0].shape gives [number of samples x sequence length x dimensionality]
Call python main.py 50 1028 512 2 0.6
For instance; number_epochs: 50, hidden_dim:1028, fully_connected dim: 512, output_dim: 2, training dropout prob: 0.6
Our code is refereed from [1]. It is used for classification and we modified this code to make it can be used for regression problem.

Reference:
[1] https://github.com/illidanlab/T-LSTM
