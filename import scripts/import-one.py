from sas7bdat import SAS7BDAT
import numpy as np
import pandas as pd
from numpy.random import randn
from pandas import Series, DataFrame, Index
from sqlalchemy import create_engine
engine = create_engine('postgresql://Mehrotra@localhost:5432/fars')

years = [2016]
vheaders= ['STATE','ST_CASE','VEH_NO','REG_STAT','MAKE','MODEL','MAK_MOD','BODY_TYP','MOD_YEAR','VIN','TRAV_SP','DEATHS',"DR_SF1", "DR_SF2", "DR_SF3", "DR_SF4", "P_CRASH2","ACC_YEAR"]
aheaders=['STATE','ST_CASE','COUNTY','CITY','DAY','MONTH','YEAR','HOUR','MINUTE','NHS','ROUTE','FATALS',"LATITUDE","LONGITUD"]
for year in years:
	print(year)

	accident_data = SAS7BDAT(str(year)+'/fars/accident.sas7bdat')
	vehicle_data = SAS7BDAT(str(year)+'/fars/vehicle.sas7bdat')
	accident = accident_data.to_data_frame()
	vehicle = vehicle_data.to_data_frame()
	vehicle["ACC_YEAR"] = year
	accident[aheaders].to_sql('accident', con=engine,if_exists='append') 
	vehicle[vheaders].to_sql('vehicle', con=engine,if_exists='append')
	