# Exemplo reprodutivel do problema do echarts4r

# does not work
palmerpenguins::penguins |>
  dplyr::group_by(sex) |>
  echarts4r::e_chart(x = body_mass_g) |>
  echarts4r::e_scatter(serie = flipper_length_mm)

# works
palmerpenguins::penguins |>
  tidyr::drop_na(sex) |>
  dplyr::group_by(sex) |>
  echarts4r::e_chart(x = body_mass_g) |>
  echarts4r::e_scatter(serie = bill_depth_mm)

# ----


# Mapas com Leaflet -------------------------------------------------------

## Joe Cheng

### pacote {tmap}

library(tidyverse)
library(leaflet)

dados_geobr <- geobr::read_municipality("ES")

dados_com_pnud <- dados_geobr |>
  mutate(muni_id = as.character(code_muni)) |>
  inner_join(abjData::pnud_min, "muni_id") |>
  filter(ano == 2010)

dados_com_pnud |>
  leaflet() |>
  addTiles() |>
  # addProviderTiles("Stamen.Watercolor")
  addPolygons(
    color = "black",
    weight = 0.2,
    fillColor = "royalblue"
  ) |>
  addMarkers(
    lng = ~lon,
    lat = ~lat,
    clusterOptions = markerClusterOptions(),
    popup = ~muni_nm
  )

# Tabelas com Reactable ---------------------------------------------------

library(reactable)

tab <- diamante |>
  select(
    corte, cor, transparencia, preco, quilate
  ) |>
  reactable(
    columns = list(
      preco = colDef(
        "Preço",
        align = "center",
        format = colFormat(
          currency = "BRL"
        )
      )
    ),
    striped = TRUE,
    highlight = TRUE,
    compact = TRUE,
    pageSizeOptions = c(10,50,100),
    searchable = TRUE,
    sortable = TRUE,
    style = list(fontFamily = "Work Sans, sans-serif"),
    elementId = "diamante-download"
  )


htmltools::browsable(
  shiny::tagList(
    shiny::tags$button(
      shiny::tagList(fontawesome::fa("download"), "Download as CSV"),
      onclick = "Reactable.downloadDataCSV('diamante-download', 'diamante.csv')"
    ),
    tab
  )
)


