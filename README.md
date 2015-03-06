# Overview 

Currently, this repository contains settings files for developing the [`globalbiocro.Rscript`](https://github.com/ebimodeling/pecan/blob/biocro-module2/models/biocro/inst/globalbiocro.Rscript) in the PEcAn.BIOCRO package.

There is a version of the script in `vignettes/globalbiocro.Rscript`, and branches for different machines.


## Inputs

These inputs were prepared for the MsTMIP runs, and we will need to comply with any restrictions on their use at time of publication.

Files are on ebi-forecast in `/home/share/data/`, on biocluster in `/home/groups/ebimodeling/`

* met driver data is in `met/cruncep/all.nc`
* soil data is in `soil/hwsd.nc`

There is a branch for use on biocluster and one for use on ebi-forecast. 

### Notse on driver files

(do this on a slave node `qsub -I`)

#### Rename variable

```sh
ncrename -v surface_pressure,air_pressure foo.nc 
```

#### subset US from global cruncep files on biocluster

```sh
cd /home/groups/ebimodeling/met/cruncep/
time ncks -d lon,-135.0,-67.0 -d lat,25.0,48.0 out/all_uncompressed.nc us_uncompressed.nc
```sh

#### subset specific year (2013)

Convert date to index 

* units are days since 1700-01-01

```r
library(lubridate)
ymd("2013-01-01") - ymd("1700-01-01")
ymd("2014-01-01") - ymd("1700-01-01") 
```

```sh
time ncea -F -d time,114321,114686 us_uncompressed.nc us_2013.nc
time ncea -F -d time,114321,114686 illinois.nc illinois_2013.nc
```

#### subset Central Illinois from MsTMIP-NARR drivers

```sh
cd /home/groups/ebimodeling/met/narr/threehourly
time ncks -d lon,-91.6,-87.4 -d lat,37.0,42.75 out/all.nc illinois.nc

time ncks -d lon,-88.8,-87.7 -d lat,39.8,40.5 out/all.nc champaign.nc

 rsync -routi *.nc ebi-forecast.igb.illinois.edu:.pecan/dbfiles/met/narr/
```


#### Create some example data for initial testing

```r
download.file("https://www.betydb.org/temp_models/miscanthus_yield_grid.csv", method = 'wget', destfile = 'mxg.csv')

library(data.table)
mxg <- fread('mxg.csv', skip = 1)

mxg[,
    `:=` (lcl = round(yield * 0.25, 2),
          ucl = round(yield * 0.5, 2),
          median = round(yield * 0.75, 2),
          yield = NULL)]
mxg_il <- mxg[lon < -87.4 & lon > -91.6 & lat < 42.75 & lat > 37]

write.csv(mxg_il, 'data/mxg_il_example.csv', row.names = FALSE)

```