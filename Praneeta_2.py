import pandas as pd
import numpy as np
from pandas import DataFrame
import scipy.stats
from scipy.stats import kendalltau, spearmanr
import matplotlib.pyplot as plt
import plotly.graph_objs as go
#from scipy import stats


data1 = pd.read_csv('loan.csv')
x = pd.DataFrame()
y = pd.DataFrame()
z = pd.DataFrame()

#Replace the '%' sign with space in column term
data1['revol_util'] = data1['revol_util'].str.replace('%', '')
#avg = data1['revol_util'].mean(axis=None, skipna=None, level=None, numeric_only=None, **kwargs)
#print(revol_mean)
#data1['revol_util'] = data1['revol_util'].str.fillna("revol_mean")
#print(data1['revol_util'])

#Replace the 'years/year' with space in column term
data1['emp_length'] = data1['emp_length'].str.replace(' years', '')
data1['emp_length'] = data1['emp_length'].str.replace(' year', '')

data1['emp_length'] = data1['emp_length'].replace('n/a' ,"0")
#data1['emp_length'] data1['emp_length'].fillna(data1['emp_length'].mean(), inplace = True') 
#sub2['income'].fillna((sub2['income'].mean()), inplace=True) 

vals_emp_length = {'< 1':'0.5', '10+':'10.5', '0':'0', '1':'1', '2':'2', '3':'3', '4':'4', '5':'5', '6':'6', '7':'7', '8':'8', '9':'9', '10':'10'}
data1['emp_length'] = data1['emp_length'].map(vals_emp_length)
data1['emp_length'].fillna((data1['emp_length'].mean()))
#print(data1['emp_length'])

"""
#removing the column 'title'
data1 = data1.drop('title', axis = 1)

#One hot encoding for home_ownership column
data1 = pd.concat([data1,pd.get_dummies(data1['loan_status'], prefix = 'status')], axis = 1)

#converting all data to lower case
data1.columns = [x.lower() for x in data1.columns]

#correlation using kendall model
#x = data1.corr(method='pearson')
#print(x)
#y = data1.corr(method='spearman')
#print(y)
z = data1.corr(method='kendall')
#print(z)



#stats.kendalltau([1,3,2], [3,1,2]).correlation
#tau, p_value = stats.kendalltau(x1, x2)
#data1[''] = data1.groupby(data1['loan_status']).apply(lambda x: st.kendalltau(x['a'], x['Sum']))

"""
"""
listto = []
for i in data2: listto.append(i)
trace = go.Scatter(x=listto, y = data2['loan_status'])
data = [trace]


fig = plotly.graph_objs.Figure(data=data2(0,1))  
trace = go.Scatter(
    x = random_x,
    y = random_y
)

data = [trace] 
plot(data, filename='3d-scatter-colorscale_language.html')
plotly.graph_objs 
""" 
