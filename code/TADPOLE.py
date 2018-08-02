
from __future__ import print_function
from __future__ import division
from sklearn.metrics import accuracy_score
from keras import optimizers
import time
from sklearn.svm import SVR
from sklearn.model_selection import GridSearchCV  
from sklearn.model_selection import learning_curve 

import numpy as np
import pandas as pd

from sklearn.datasets import load_boston
from sklearn.ensemble import RandomForestRegressor
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import Imputer
from sklearn.cross_validation import cross_val_score
from sklearn import preprocessing
import xlwt

import numpy as np
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM, Masking, Dropout
from keras.utils import np_utils

#from phased_lstm_keras.PhasedLSTM import PhasedLSTM


import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' #disable tensorflow warnings

#number of iterations
parp = 80
mask = 14

input_file = "./dataset5/input_train.csv"
df2 = pd.read_csv(input_file)

X = df2

#print(len(X.ix[0, :]))
x = np.random.rand(len(X.ix[:,0]), len(X.ix[0,:]) - 2 )

for i in range(0, len(X.ix[:,0])):
	for j in range(2, len(X.ix[0,:])):
		x[i, j-2] = X.iat[i, j]

X_scaled = preprocessing.scale(x)
input_file = "./dataset5/target_train.csv"
df_train_target = pd.read_csv(input_file)
Y_train = df_train_target.ADAS13

total_visit = mask * len(Y_train)
print(total_visit)
print(len(x[0,:]))
x_mask = np.random.rand(total_visit, len(x[0,:]))



input_file = "./dataset5/infor_train.csv"
df2 = pd.read_csv(input_file)
num_of_target_train = df2.Target
num_of_visit_train = df2.Visit
#print(num_of_target_train[0])
t1 = 0
t2 = 0
mask_row = np.ones(len(x[0,:])) * (-10)

for i in range(0, len(num_of_target_train)):
	for j in range(0, num_of_target_train[i]):
		for k in range(0, num_of_visit_train[i]):
			x_mask[t1, :] = X_scaled[t2, :]
			t1 = t1 + 1
			t2 = t2 + 1

		for k in range(0, mask - num_of_visit_train[i]):
			x_mask[t1, :] = mask_row
			#x_mask[t1, :] = X_scaled[t2-1, :]
			t1 = t1 + 1

y_train = np.random.rand(Y_train.size, 1)
for i in range(0, Y_train.size): #exclusive
	y_train[i, 0] = Y_train[i] / parp

X_mask = x_mask.reshape(len(Y_train), mask, 337)

epochs = 50

model = Sequential()
#model.add(Masking(mask_value=-10, input_shape=(mask, 337,)))
model.add(Masking(mask_value=-10, input_shape=(mask, 337,)))

model.add(LSTM(128, dropout=0.2, input_shape=(len(Y_train), mask)))
#model.add(PhasedLSTM(128, input_shape=(len(Y_train),mask)))

#model.add(LSTM(output_dim=16, dropout=0.2, input_shape=(len(Y_train), mask, 337)))
model.add(Dropout(0.8))
#model.add(Dense(128, activation='relu'))
model.add(Dense(y_train.shape[1], activation='relu'))


model.compile(loss='mae',#'mean_squared_error',
 	          optimizer='rmsprop')
#train the model with the train and validation data
model.fit(X_mask, y_train, validation_split=0.1, epochs=epochs, verbose=1)


y_train_result = model.predict(X_mask)
count = 0
for i in range(0, len(y_train_result[:,0])):
	count = count + abs(y_train_result[i,0] - y_train[i,0])
print("Result of Train: ", parp * count / len(y_train_result[:,0]))

####################################################################################

input_file = "./dataset5/input_test.csv"
df2 = pd.read_csv(input_file)

X_test = df2

#print(len(X.ix[0, :]))
x_test = np.random.rand(len(X_test.ix[:,0]), len(X_test.ix[0,:]) - 2 )

for i in range(0, len(X_test.ix[:,0])):
	for j in range(2, len(X_test.ix[0,:])):
		x_test[i, j-2] = X_test.iat[i, j]

X_scaled_test = preprocessing.scale(x_test)
input_file = "./dataset5/target_test.csv"
df_test_target = pd.read_csv(input_file)
Y_test = df_test_target.ADAS13

total_visit_test = mask * len(Y_test)
print(total_visit_test)
print(len(x_test[0,:]))
x_mask_test = np.random.rand(total_visit_test, len(x_test[0,:]))



input_file = "./dataset5/infor_test.csv"
df2 = pd.read_csv(input_file)
num_of_target_test = df2.Target
num_of_visit_test = df2.Visit
#print(num_of_target_train[0])
t1 = 0
t2 = 0
mask_row_test = np.ones(len(x_test[0,:])) * (-10)


for i in range(0, len(num_of_target_test)):
	for j in range(0, num_of_target_test[i]):
		for k in range(0, num_of_visit_test[i]):
			x_mask_test[t1, :] = X_scaled_test[t2, :]
			t1 = t1 + 1
			t2 = t2 + 1

		for k in range(0, mask - num_of_visit_test[i]):
			x_mask_test[t1, :] = mask_row_test
			t1 = t1 + 1

y_test = np.random.rand(Y_test.size, 1)
for i in range(0, Y_test.size): #exclusive
	y_test[i, 0] = Y_test[i] / parp

X_mask_test = x_mask_test.reshape(len(Y_test), mask, 337)

y_test_result = model.predict(X_mask_test)
count = 0
for i in range(0, len(y_test_result[:,0])):
	count = count + abs(y_test_result[i,0] - y_test[i,0])
print("Result of Test: ", parp * count / len(y_test_result[:,0]))




