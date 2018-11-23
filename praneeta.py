import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data1 = pd.read_csv('loan.csv')

#Replace the '%' sign with space in column term
data1['emp_length'] = data1['emp_length'].replace('n/a' ,"0")
data1['emp_length']=data1['emp_length'].fillna("0")
data1['emp_length'].to_csv('Check_2.csv')