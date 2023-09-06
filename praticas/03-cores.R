library(tidyverse)
library(dados)

dados_starwars |>
  glimpse()

dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point()

dados_starwars |>
  filter(massa > 1000)

# sem o jabba
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5)

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5) +
  scale_colour_brewer(
    palette = "Set2",
    na.value = "#FF4444"
  )

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5) +
  scale_colour_hue(
    h = c(0, 360) + 100,
    c = 100,
    l = 65
  )

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5) +
  scale_colour_manual(
    values = c("darkturquoise", "royalblue"),
    na.value = "red"
  )

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5) +
  scale_colour_manual(
    values = hcl.colors(2, palette = "Vik"),
    na.value = "red"
  )

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 5) +
  scale_colour_viridis_d(
    option = "E",
    begin = 0.2,
    end = 0.8,
    na.value = "red"
  )

dados_starwars |>
  filter(massa < 1000) |>
  mutate(
    cor = case_when(
      genero == "Masculino" ~ "darkgreen",
      genero == "Feminino" ~ "royalblue"
    )
  ) |>
  # select(genero, cor)
  ggplot() +
  aes(x = massa, y = altura, colour = cor) +
  geom_point(size = 5) +
  scale_colour_identity(
    guide = "legend",
    labels = c("Masculino", "Feminino")
  )


# cor numérica
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5)

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5) +
  scale_colour_distiller(palette = "RdPu")

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5) +
  scale_colour_fermenter(palette = "RdPu")

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5) +
  scale_colour_viridis_c(begin = .1, end = .8)

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5) +
  scale_colour_viridis_b(begin = .1, end = .8)


# pacotes com escalas -----------------------------------------------------


# pacote ggthemes (sério) -------------------------------------------------

# install.packages("ggthemes")

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 5) +
  ggthemes::theme_stata()

dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = sexo_biologico) +
  geom_point(size = 5) +
  ggthemes::scale_color_gdocs()

# pacote tvthemes (não tão sério) -----------------------------------------

# install.packages("tvthemes")
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = sexo_biologico) +
  geom_point(size = 3) +
  tvthemes::scale_colour_spongeBob() +
  tvthemes::theme_spongeBob(text.font = "Times New Roman") +
  labs(title = "Duas horas depois...")

# install.packages("extrafont")
extrafont::font_import(
  "exemplos_de_aula/fontes/",
  prompt = FALSE
)
extrafont::font_import(
  "C:\\Windows\\Fonts",
  prompt = FALSE
)
extrafont::loadfonts("win")


# Gráfico Vader -----------------------------------------------------------

tema <- theme(
  plot.title = element_text(
    family = "Jokerman",
    colour = "yellow",
    hjust = .5,
    size = 30
  ),
  plot.subtitle = element_text(
    family = "Star Jedi",
    colour = "yellow",
    hjust = .5
  ),
  axis.title = element_text(
    family = "Star Jedi",
    colour = "yellow"
  ),
  axis.text = element_text(
    family = "Star Jedi",
    colour = "yellow"
  ),
  panel.background = element_rect(
    fill = "black"
  ),
  plot.background = element_rect(
    fill = "black"
  ),
  # panel.grid.major.x = element_blank(),
  # panel.grid.minor.x = element_blank(),
  panel.grid = element_blank(),
  axis.ticks = element_blank()
)

theme_set(tema)

vader <- dados_starwars |>
  filter(nome == "Darth Vader") |>
  mutate(nome = tolower(nome))

grafico <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura) +
  geom_point(
    shape = 23,
    colour = "yellow",
    fill = "yellow",
    alpha = 0.8,
    size = 3
  ) +
  geom_point(
    shape = 23,
    colour = "red",
    fill = "red",
    alpha = 1,
    size = 3,
    data = vader
  ) +
  geom_label(
    aes(label = nome),
    colour = "black",
    fill = "red",
    alpha = 1,
    size = 3,
    family = "Star Jedi",
    data = vader,
    nudge_x = -10,
    nudge_y = 10
  ) +
  # xlim(c(0, 200)) + # vamos ver a diferença no futuro ggridges
  coord_cartesian(xlim = c(0, 200)) +
  labs(
    title = "Star Wars",
    subtitle = "May the force be with you"
  )

grafico

# install.packages("ggimage")

image <- "https://wallpaperaccess.com/full/11836.jpg"

ggimage::ggbackground(
  gg = grafico,
  background = image
)
