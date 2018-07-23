
from sas7bdat import SAS7BDAT
import sys
import numpy as np
import pandas as pd
from numpy.random import randn
from pandas import Series, DataFrame, Index
from sqlalchemy import create_engine

engine = create_engine(sys.argv[1])

years = sys.argv[2:]
pheaders= ['STATE','ST_CASE','AGE','SEX',"ACC_YEAR"]
 

for year in years:
 
 print("importing "+year)

 
 person_data = SAS7BDAT("data/"+str(year)+'/fars/person.sas7bdat')
	person = person_data.to_data_frame()
	person["ACC_YEAR"] = year
	person[pheaders].to_sql('person', con=engine,if_exists='append') 
	

