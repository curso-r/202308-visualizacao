library(tidyverse)
library(dados)
library(ggridges)

diamante |>
  ggplot() +
  aes(x = preco) +
  geom_density()

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    alpha = 0.6,
    quantile_lines = TRUE,
    # quantiles = c(0.25, 0.5, 0.75)
    quantiles = 0.5 # mediana
  )



diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    alpha = 0.6,
    quantile_lines = TRUE,
    # quantiles = c(0.25, 0.5, 0.75)
    quantiles = 0.5 # mediana
  ) +
  scale_x_continuous(limits = c(0, NA))

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    alpha = 0.6,
    quantile_lines = TRUE,
    # quantiles = c(0.25, 0.5, 0.75)
    quantiles = 0.5 # mediana
  ) +
  xlim(0, 10000)


diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    alpha = 0.6,
    quantile_lines = TRUE,
    # quantiles = c(0.25, 0.5, 0.75)
    quantiles = 0.5 # mediana
  ) +
  # DÁ UM ZOOM NO GRÁFICO
  coord_cartesian(xlim = c(0, 10000)) +
  # CORTA O GRAFICO
  xlim(c(0, NA))

# JULIO FAZ UM BLOG POST DISSO AQUI!


media_geral <- round(mean(diamante$preco))


diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    alpha = 0.6,
    quantile_lines = TRUE,
    # quantiles = c(0.25, 0.5, 0.75)
    quantiles = 0.5 # mediana
  ) +
  geom_vline(
    xintercept = media_geral,
    linetype = 2,
    color = "gray10",
    linewidth = 1
  ) +
  # Sugestão do Humberto
  annotate(label = paste0("Média geral: U$ ", media_geral),
           x = media_geral + 2200,
           y = 6.6,
           geom = "text", color = "gray10"
           ) +
  # DÁ UM ZOOM NO GRÁFICO
  coord_cartesian(xlim = c(0, 10000)) +
  # CORTA O GRAFICO
  xlim(c(0, NA)) +
  theme_light() +
  scale_fill_brewer()


