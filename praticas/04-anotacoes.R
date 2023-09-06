## Anotação Manual

library(dados)
library(tidyverse)

theme_set(theme_gray())

jabba <- dados_starwars |>
  filter(massa > 1000)

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point()

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  geom_label(
    aes(label = nome),
    data = jabba,
    nudge_y = 20,
    nudge_x = -200
  )

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  geom_label(
    aes(label = nome),
    data = jabba,
    hjust = 1.2,
    vjust = -1
  )

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  geom_text(
    aes(label = nome),
    data = jabba,
    nudge_y = 20,
    nudge_x = -200
  )

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  annotate(
    "label",
    x = jabba$massa,
    y = jabba$altura,
    label = jabba$nome
  )

# gghighlight
# install.packages("gghighlight")

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 3) +
  gghighlight::gghighlight(
    altura > 220 | massa > 1000,
    label_key = nome
  )

# ggrepel

dados_starwars |>
  filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 3) +
  ggrepel::geom_label_repel(
    aes(label = nome),
    max.overlaps = 3
  )

# ggalt

library(ggalt)
dados_starwars |>
  # filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 3) +
  ggalt::geom_encircle(
    data = jabba,
    colour = "red",
    s_shape = 0,
    expand = 0,
    spread = .02,
    size = 2
  )


dados_starwars |>
  # filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 3) +
  ggalt::geom_encircle(
    data = dados_starwars |>
      filter(altura > 220),
    colour = "red",
    s_shape = 1,
    expand = 0.05,
    spread = 1,
    size = 2
  )

dados_starwars |>
  # filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 3) +
  stat_ellipse(
    type = "norm",
    geom = "polygon",
    alpha = .05,
    level = .95,
    colour = "red",
    data = dados_starwars |>
      filter(altura > 220),
  )

pinguins |>
  drop_na() |>
  ggplot(aes(
    x = comprimento_bico,
    y = profundidade_bico,
    shape = especie,
    group = especie
  )) +
  geom_point() +
  theme_minimal(12) +
  theme(legend.position = "bottom") +
  stat_ellipse(
    type = "norm",
    geom = "polygon",
    alpha = .05,
    level = .95,
    colour = "transparent"
  )






