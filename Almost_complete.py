import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
import plotly.graph_objs as go
from plotly.figure_factory import create_distplot
import plotly as py

data1 = pd.read_csv('loan.csv')

#Slice file to delete columns
data1.drop(data1.columns[49:105], axis = 1, inplace = True)
data1.drop(data1.columns[50:], axis = 1, inplace = True)

#Concatenate id and member_id columns
data1['id'] = data1['id'].astype(str) + data1['member_id'].astype(str)

#Replace months keyword with space in column term
data1['term'] = data1['term'].str.replace('months', '')

#Replace the 'years/year' with space in column term
data1['emp_length'] = data1['emp_length'].str.replace(' years', '')
data1['emp_length'] = data1['emp_length'].str.replace(' year', '')
#data1['emp_length'] = data1['emp_length'].replace('n/a' ,"0")

vals_emp_length = {'< 1':'0.5', '10+':'10.5', '0':'0', '1':'1', '2':'2', '3':'3', '4':'4', '5':'5', '6':'6', '7':'7', '8':'8', '9':'9', '10':'10'}
data1['emp_length'] = data1['emp_length'].map(vals_emp_length)
data1['emp_length'] = data1['emp_length'].astype("float")

#Replacing na with average of the column 'emp_length'
data1['emp_length'].fillna(str(data1['emp_length'].mean()), inplace=True) 

#Replace the '%' sign with space in column term
data1['revol_util'] = data1['revol_util'].str.replace('%', '')
data1['revol_util'] = data1['revol_util'].astype("float")

#Replacing na with average of the column 'revol_util'
data1['revol_util'].fillna(str(data1['revol_util'].mean()), inplace = True)

#Replace % keyword with space in int_rate term
data1['int_rate'] = data1['int_rate'].str.replace('%', '')

#Replace xx keyword with space in column zip_code
data1['zip_code'] = data1['zip_code'].str.replace(r'\D+', '')


#Cleaned file
'''
Generated SQL: 
SELECT TOP 200 "NAME", "ROWNUMBER", "ERROR", "Event ID", "Persons Involved"
FROM "SAM_EHS"."suncor.sam.private.ehs::TBL_SRC_SAPPROACT_PERSINV" 
'''

#Replace grade and sub_grade with numeric values
vals_to_replace = {'A':'1', 'B':'2', 'C':'3', 'D':'4', 'E':'5', 'F':'6', 'G':'7'}
data1['grade'] = data1['grade'].map(vals_to_replace)
data1['sub_grade'] = data1['sub_grade'].replace(vals_to_replace, regex = True)


#Delete loan status column with value 'Current'
data1 = data1[data1.loan_status != 'Current']

#Added new column which is montly income
data1['monthly_inc'] = data1.apply(lambda row: row.annual_inc/12, axis = 1)

#Count for distinct values in loan_status
data2 = []

data2 = data1['loan_status'].value_counts().reset_index()

#column2 for ratio of monthly income and installment
data1['column2'] = data1.apply(lambda row: row.monthly_inc/row.installment, axis = 1)

#Map loan_status to 0/1
data1['loan_status'] = data1['loan_status'].map({'Fully Paid': 1, 'Charged Off':0})

#One hot encoding applied to relevant columns
categorical = ['home_ownership','verification_status','purpose','addr_state']
data1 = pd.get_dummies(data1, columns = categorical)

#Remove spaces between column names ans replace with underscore
data1.columns = data1.columns.str.replace(' ', '_')

#Convert all column names to lowercase
data1.columns = [x.lower() for x in data1.columns]
        

#Public rec bankruptcies NA value change ---- logic not working currently


data1['annual_1'] = data1['annual_inc']/data1['annual_inc'].max()
data1['column3'] = data1.apply(lambda row: 10 - (row.delinq_2yrs*0.175 + row.loan_status*0.5 + row.annual_1*0.325), axis = 1)
data1['pub_rec_bankruptcies'] = data1['pub_rec_bankruptcies'].fillna(data1['column3']) 

#Cleaned file
data1['out_prncp'].to_csv('Cleansed_out.csv', index = False)
data1['out_prncp_inv'].to_csv('Cleansed_out_inv.csv', index = False)




data1 = data1.drop('emp_title', axis = 1)
data1 = data1.drop('pymnt_plan', axis = 1)
data1 = data1.drop('url', axis = 1)
data1 = data1.drop('title', axis = 1)
data1 = data1.drop('initial_list_status', axis = 1)
data1 = data1.drop('member_id', axis = 1)

data1 = data1.drop('total_pymnt', axis = 1)
data1 = data1.drop('total_pymnt_inv', axis = 1)
data1 = data1.drop('total_rec_prncp', axis = 1)
data1 = data1.drop('total_rec_late_fee', axis = 1)
data1 = data1.drop('recoveries', axis = 1)
data1 = data1.drop('collection_recovery_fee', axis = 1)
data1 = data1.drop('last_pymnt_amnt', axis = 1)

#Cleaned file
data1.to_csv('Cleansed.csv', index = False)

#Corelation
data2 = data1.corr(method = 'spearman')
data2.to_csv('spearman.csv', index = False)

listto = []
for i in data2:
    listto.append(i)

trace= go.Scatter(x=listto, y=data2['loan_status'])
data=[trace] 
plot(data,filename='Graph1.html')
