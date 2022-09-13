library(rdryad)


# create directories
dir.create("data/")
dir.create("scripts/")

dir.create("data/url")
dir.create("data/dryad")
dir.create("data/github")

## download from a url
# downloaded on 2022-09-13
data.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrateDensity.csv"
metadata.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrate_metaEN.csv"

data.dest.file <- "/Users/sam/LDP/PROD_REPRO/Lesson3_tutorial/data/url/NRCAN_1995_2009_TLW_invert_density.csv"
metadata.dest.file <- "/Users/sam/LDP/PROD_REPRO/Lesson3_tutorial/data/url/NRCAN_1995_2009_TLW_invert_metadata.csv"

download.file(url = data.url, destfile = data.dest.file)
download.file(url = metadata.url, destfile = metadata.dest.file)

invert.density <- read.csv("data/url/NRCAN_1995_2009_TLW_invert_density.csv")

# dryad
# doi : https://doi.org/10.5061/dryad.8931zcrnh
rdryad::dryad_get_cache()

# setting custom cache location
# https://github.com/ropensci/rdryad/pull/36
rdryad_cache <- rdryad::dryad_get_cache()
rdryad_cache$cache_path_set(full_path = normalizePath("/Users/sam/LDP/PROD_REPRO/Lesson3_tutorial/data/dryad", mustWork = FALSE))
# mustWork = F because path does not (yet) exist
rdryad_cache$cache_path_get()

dryad_download(dois = "10.5061/dryad.8931zcrnh")

# github

dir.create("/Users/sam/LDP/PROD_REPRO/Beta_div/")
usethis::create_from_github(repo_spec = "https://github.com/kguidonimartins/betadiv-enp.git",
                            destdir="/Users/sam/LDP/PROD_REPRO/Beta_div/")
system("cp -r /Users/sam/LDP/PROD_REPRO/Beta_div/betadiv-enp/data/* data/github/.")
