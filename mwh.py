import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data1 = pd.read_csv('loan.csv')
data1['emp_length'] = data1['emp_length'].str.replace('years', '')
data1['emp_length'] = data1['emp_length'].str.replace('year', '')
print(data1['emp_length'])
vals_emp_length = {'< 1':'0.5', '10+':'10.5', '1':'1', '2':'2', '3':'3', '4':'4', '5':'5', '6':'6', '7':'7', '8':'8', '9':'9', '10':'10'}
data1['emp_length'] = data1['emp_length'].map(vals_emp_length)
#data1['emp_length'] = data1['emp_length'].replace(vals_emp_length, regex = True)