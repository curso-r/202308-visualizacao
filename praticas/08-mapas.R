library(tidyverse)
library(sf)

library(geobr)

# Explorar o geobr!
geobr::list_geobr() |> View()


# Delimitação do Brasil, dos estados, dos municípios..

geo_brasil <- read_country(year = 2020)

geo_brasil |>
  ggplot() +
  geom_sf()


geo_sp <- read_state("SP")

ggplot() +
  geom_sf(data = geo_brasil) +
  geom_sf(data = geo_sp, color = "red")

geo_muni <- read_municipality()

glimpse(geo_muni)

class(geo_muni)

geo_guarulhos <- geo_muni |>
  dplyr::filter(name_muni == "Guarulhos")


ggplot() +
  #geom_sf(data = geo_brasil) +
  geom_sf(data = geo_sp, color = "red") +
  geom_sf(data = geo_guarulhos, fill = "blue")


geo_autazes <- read_municipality(1300300)

geo_autazes |>
  ggplot() +
  geom_sf()
