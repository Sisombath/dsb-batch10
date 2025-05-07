import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt 
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn import metrics

data = pd.read_csv("D:\python_vs\csv_example_data\Weather.csv")

# print(data.describe())

# data.plot(x= "MinTemp", y = "MaxTemp",style = "o")
# plt.title("min and max temp")
# plt.xlabel("min temp")
# plt.ylabel("max temp")
# plt.show() 

## train test split set
x = data["MinTemp"].values.reshape(-1,1)
y = data["MaxTemp"].values.reshape(-1,1)

## split (80:20)
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.2,random_state=0)

## train model
model = LinearRegression()
model.fit(x_train,y_train)

## test model
y_pred = model.predict(x_test)

# #plot graph
# plt.scatter(x_test,y_test)
# plt.plot(x_test,y_pred,color = "red", linewidth=2)
# plt.show()

## compare true data and predict data

# df = pd.DataFrame({'Actually': y_test.flatten(),'Predicted': y_pred.flatten()}) ## flatten() change to 1D

# df1 = df.head(20)
# df1.plot(kind = 'bar' , figsize= (16,10))
# plt.show()

## MAE, MSE, RMSE, R-square

print("MAE = ", metrics.mean_absolute_error(y_test,y_pred))
print("MSE = ", metrics.mean_squared_error(y_test,y_pred))
print("RMSE = ", np.sqrt(metrics.mean_squared_error(y_test,y_pred)))
print("score = ", metrics.r2_score(y_test,y_pred))