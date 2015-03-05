
## Rename variable
ncrename -v surface_pressure,air_pressure foo.nc 

## subset US from global cruncep files on biocluster
cd /home/groups/ebimodeling/met/cruncep/
time ncks -d lon,-135.0,-67.0 -d lat,25.0,48.0 out/all_uncompressed.nc us_uncompressed.nc

## subset specific year (2013)
## units are days since 1700-01-01
## library(lubridate)
## ymd("2013-01-01") - ymd("1700-01-01")
## ymd("2014-01-01") - ymd("1700-01-01") 
time ncea -F -d time,114321,114686 us_uncompressed.nc us_2013.nc
