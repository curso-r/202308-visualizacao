library(tidyverse)
library(dados)
library(gganimate)

grafico <- dados_gapminder |>
  ggplot() +
  aes(
    pib_per_capita / 1000,
    expectativa_de_vida,
    size = log10(populacao),
    colour = continente
  ) +
  geom_point() +
  scale_x_log10() +
  # facet_wrap(~continente) +
  facet_wrap(vars(continente)) +
  guides(
    colour = "none",
    size = guide_legend(reverse = TRUE)
  ) +
  scale_colour_viridis_d(begin = .1, end = .9) +
  labs(
    x = "PIB per capita (US$ 1000)",
    y = "Expectativa de vida",
    title = "Ano: {frame_time}"
  )

grafico_animado <- grafico +
  transition_time(ano)


animate(
  grafico_animado,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400
)

# install.packages("av")
# install.packages("gifski")
animate(
  grafico_animado,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400,
  renderer = gifski_renderer("praticas/07-gganimate.gif")
)

animate(
  grafico_animado,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400,
  renderer = av_renderer("praticas/07-gganimate.mp4")
)

# uma aplicação interessante

grafico <- dados_gapminder |>
  ggplot() +
  aes(
    pib_per_capita / 1000,
    expectativa_de_vida,
    size = log10(populacao),
    colour = continente
  ) +
  geom_point() +
  scale_x_log10() +
  gghighlight::gghighlight(
    pais == "Brasil",
    label_key = pais
  ) +
  guides(
    colour = "none",
    size = guide_legend(reverse = TRUE)
  ) +
  scale_colour_viridis_d(begin = .1, end = .9) +
  labs(
    x = "PIB per capita (US$ 1000)",
    y = "Expectativa de vida",
    title = "Ano: {frame_time}"
  )

grafico_animado <- grafico +
  transition_time(ano)


animate(
  grafico_animado,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400
)




