library(tidyverse)
library(dados)

dados_starwars

p1 <- dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point()

p2 <- dados_starwars |>
  ggplot() +
  aes(x = massa) +
  geom_histogram()

p3 <- dados_starwars |>
  ggplot() +
  aes(x = altura) +
  geom_histogram()

p4 <- dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n) +
  geom_col()


# podemos começar a usar o patchwork!

p1 + p2
# Error in `ggplot_add()`:
#   ! Can't add `p2` to a <ggplot> object.
# Run `rlang::last_trace()` to see where the error occurred.


library(patchwork)

# experimentando configurações simples!
p1 + p2

p1 + p2 + p3

p1 + p2 + p3 + p4

p1 / p2


p1 + p2 + plot_layout(ncol = 2)
p1 + p2 + plot_layout(nrow = 2)

# ANOTAÇÕES

p1 + p2 + p3 + p4 + plot_annotation(tag_levels = "A")


p1 + p2 + p3 + p4 + plot_annotation(tag_levels = "1")


p1 + p2 + p3 + p4 + plot_annotation(tag_levels = "I")


p1 + p2 + p3 + p4 + plot_annotation(tag_levels = "A",
                                    tag_suffix = ")")

imagem <- p1 + p2 + p3 + p4 +
  plot_annotation(tag_levels = "A",
                  title = "Relação da massa e altura",
                  subtitle = "em personagens de Star Wars",
                  caption = "Dados do pacote em R {dados}.")

# dúvida do Humberto
# tema - aplicar um tema em todos os plots
imagem & theme_light()

# Dúvida do Henrique
p1 + grid::textGrob('Some really important text')

# composições diferentes!

(p1 + p2) / p1

layout_design <- "
#AA
BCD
#CD
"

p1 + p2 + p3 + p4 + plot_layout(design = layout_design)

# - VAZIO
# A, B, C, D - Representa os gráficos na ordem
# pular linha representa outra linha na imagem

# LEGENDA

p5 <- dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point(aes(color = genero))

p6 <- dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n) +
  geom_col(aes(fill = genero), show.legend = FALSE)


p5 +
#  plot_spacer() + # Adiciona área em branco no gráfico
  p6 + plot_layout(guides = "collect")

