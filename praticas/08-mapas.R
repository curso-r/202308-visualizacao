library(tidyverse)
library(sf) # simple features
library(geobr)

# Explorar o geobr!
geobr::list_geobr() |> View()


# Delimitação do Brasil, dos estados, dos municípios..

geo_brasil <- read_country(year = 2020)

head(geo_brasil)

geo_brasil |>
  ggplot() +
  geom_sf()


geo_brasil |>
  ggplot() +
  geom_sf(aes(fill = name_region))


geo_sp <- read_state("SP")

ggplot() +
  geom_sf(data = geo_brasil) +
  geom_sf(data = geo_sp, color = "red")


ggplot() +
  geom_sf(data = geo_brasil)

ggplot(data = geo_brasil) +
  geom_sf() +
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


# Continuação --------------

# leitura de arquivos externos
municipios_2017 <- sf::read_sf("dados/Shape-OD2017/Municipios_2017_region.shp")

dplyr::glimpse(municipios_2017)

municipios_2017 |>
  ggplot() +
  geom_sf()

# Join?
# unidade amostral das tabelas
# coluna de chave!

# install.packages("abjData")
pnud_uf <- abjData::pnud_uf #ano/uf

geo_brasil # uf

pnud_uf_sf <- geo_brasil |>
  dplyr::left_join(pnud_uf, by = c("code_state" = "uf"))



dplyr::glimpse(pnud_uf_sf)

pnud_uf_sf |>
  # filter(ano == 2010) |>
  ggplot() +
  geom_sf(aes(fill = espvida)) +
  # theme_void()
  theme_light() +
  facet_wrap(~ano)


# -------------------
pnud_muni <- abjData::pnud_min
dplyr::glimpse(pnud_muni)


# https://docs.ropensci.org/parzer/articles/parzer.html

pnud_muni_sf <- pnud_muni |>
  st_as_sf(coords = c("lon", "lat"))

pnud_muni_sf |>
  ggplot() +
  geom_sf(aes(color = idhm)) +
  facet_wrap(~ano)

# Exemplo Julio

dados_geobr <- geobr::read_municipality() |>
  dplyr::filter(abbrev_state == "AL")

dados_com_pnud_anos <- dados_geobr |>
  dplyr::mutate(muni_id = as.character(code_muni)) |>
  dplyr::inner_join(abjData::pnud_min, by = "muni_id") |>
  dplyr::mutate(ano = as.numeric(ano))

# remotes::install_github("thomasp85/transformr")

library(gganimate)
anim <- dados_com_pnud_anos |>
  ggplot(aes(fill = idhm)) +
  geom_sf(colour = "black", size = .1) +
  scale_fill_viridis_b(option = "A", begin = .1, end = .9) +
  theme_void() +
  ggspatial::annotation_scale() +
  ggspatial::annotation_north_arrow(location = "br") +
  labs(title = "Ano: {frame_time}") +
  gganimate::transition_time(ano) +
  gganimate::enter_fade()

