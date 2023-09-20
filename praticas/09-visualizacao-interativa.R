library(tidyverse)
library(dados)
library(plotly)
library(highcharter)
library(echarts4r)

starwars <- dados_starwars |>
  filter(massa < 1000)

grafico_com_ggplot <- starwars |>
  ggplot() +
  geom_point(aes(x = massa, y = altura, color = genero)) +
  theme_light()

# plotly! gráfico de pontos -----------

ggplotly(grafico_com_ggplot) # jeito mais fácil

starwars |>
  plot_ly(mode = "markers",
          type = "scatter",
          x = ~ massa,
          y = ~ altura,
          color = ~ genero)


#
starwars_contagem <- dados_starwars |>
  count(sexo_biologico)

ggplot_starwars_contagem <- starwars_contagem |>
  ggplot() +
  geom_col(aes(x = n, y = sexo_biologico, fill = sexo_biologico)) +
  theme_light()

ggplotly(ggplot_starwars_contagem)

starwars_contagem |>
  plot_ly(
    x = ~n,
    y = ~sexo_biologico,
    color = ~sexo_biologico,
    type = "bar"
  )


# highcharts ------

starwars |>
  hchart(type = "scatter",
         mapping = hcaes(x = massa,
                         y = altura,
                         group = genero))

starwars_contagem |>
  drop_na(sexo_biologico) |>
  arrange(n) |>
  hchart(type = "bar",
         mapping = hcaes(y = n,
                         x = sexo_biologico,
                         color = sexo_biologico))

starwars_contagem |>
  drop_na(sexo_biologico) |>
  arrange(n) |>
  hchart(type = "column",
         mapping = hcaes(y = n,
                         x = sexo_biologico,
                         color = sexo_biologico)) |>
  hc_title(text = list("Quantidade de personagens no Starwars segundo o sexo biológico"))


# echarts -----

starwars |>
  tidyr::drop_na(genero) |>
  group_by(genero) |>
  e_charts(x = massa) |>
  e_scatter(serie = altura, symbol_size = 10) |>
  e_tooltip()


# gráfico de colunas
starwars_contagem |>
  tidyr::drop_na(sexo_biologico) |>
  arrange(n) |>
  e_charts(x = sexo_biologico) |>
  e_bar(serie = n, name = "Quantidade") |>
  e_flip_coords()
