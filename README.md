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
```

#### subset Central Illinois from MsTMIP-NARR drivers

```sh
cd /home/groups/ebimodeling/met/narr/threehourly
time ncks -d lon,-91.5,-87.5 -d lat,37.0,41.5 out/all.nc illinois.nc
```
