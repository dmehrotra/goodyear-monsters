from sas7bdat import SAS7BDAT
import numpy as np
import pandas as pd
from numpy.random import randn
from pandas import Series, DataFrame, Index
from sqlalchemy import create_engine
engine = create_engine('postgresql://Mehrotra@localhost:5432/fars')

years = [2007,2006,2005,2004,2003,2002,2001]
# vheaders= ['STATE','ST_CASE','VEH_NO','REG_STAT','MAKE','MODEL','MAK_MOD','BODY_TYP','MOD_YEAR','VIN','TRAV_SP','DEATHS',"DR_SF1", "DR_SF2", "DR_SF3", "DR_SF4", "P_CRASH2","ACC_YEAR"]
vheaders= ['STATE','ST_CASE','VEH_NO','REG_STAT','MAKE','MODEL','MAK_MOD','BODY_TYP','MOD_YEAR','VIN','TRAV_SP','DEATHS',"DR_CF1", "DR_CF2", "DR_CF3", "DR_CF4","ACC_YEAR"]
aheaders=['STATE','ST_CASE','COUNTY','CITY','DAY','MONTH','YEAR','HOUR','MINUTE','NHS','ROUTE','FATALS']
#for 1996-2009 VEH_CF1, VEH_CF2', tires = 1 This data element records factors related to this vehicle expressed by the
# investigating officer. DR_CF1, DR_CF2, DR_CF3, DR_CF4 for 1996 - 2009 = 80...dr_SF for after 2009
for year in years:
	print(year)

	accident_data = SAS7BDAT(str(year)+'/fars/accident.sas7bdat')
	vehicle_data = SAS7BDAT(str(year)+'/fars/vehicle.sas7bdat')
	accident = accident_data.to_data_frame()
	vehicle = vehicle_data.to_data_frame()
	vehicle["ACC_YEAR"] = year
	vehicle[vheaders].to_sql('vehicle', con=engine,if_exists='append')
	accident[aheaders].to_sql('accident', con=engine,if_exists='append') 
