## Dependencies:

### System Utilities

modules: netcdf4, udunits2, R/3.2.0, ...
XML:  libxml2/2.9.1
  * (older versions of libxml cause segfault https://github.com/PecanProject/pecan/issues/476)


Add to `~/.bash_profile` ([example](https://github.com/dlebauer/dotfiles/blob/master/bash_profile))

```sh
export R_LIBS_USER=~/R/library
module load netcdf4 gdal R udunits2
```

## Git Repositories 

need to setup ssh-key, and be able to access either
* github.com/ebimodeling/biocro (public, has miscanthus, switchgrass)
* github.com/ebimodeling/biocro-dev (private, also has willow, sugarcane)


All of the following are public, but to use the `git@` url, need to setup an ssh key ...



```sh
git clone git@github.com:ebimodeling/biocro
git clone git@github.com:pecanproject/pecan
git clone git@github.com:ebimodeling/regional_biocro
```

Alternatively, can use `git clone https://github.com/path-to/repository/`

## R dependencies


netcdf and udunits packages are tricky. Install them first:

```r
install.packages('ncdf4', configure.args = "--with-nc-config=/sw/netcdf-4.3.3.1/bin/nc-config")

install.packages("udunits2", configure.args='--with-udunits2=/sw/udunits-2.1.24/ --with-udunits2-include=/sw/udunits-2.1.24/include')
```

```sh
cd path/to/pecan
./scripts/install.dependencies.R
./scripts/build.sh
```
