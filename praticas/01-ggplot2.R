# não deixar como número "científico"
options(scipen = 999)

# Carregar o pacote tidyverse
# install.packages("tidyverse")
library(tidyverse)

# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("readr")

library(ggplot2)
library(dplyr)
library(readr)

# Ler a base de dados

# atalho pipe: CTRL+SHIFT+M

imdb <- read_rds("dados/imdb.rds") |> # %>%
  mutate(lucro = receita - orcamento)

# Iniciando um gráfico

imdb |>
  ggplot()

# atributos estético - ex. eixo x e y
imdb |>
  ggplot() +
  aes(x = orcamento, y = receita)

# Gráfico de dispersão: geom_point()

imdb |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point()

# Atributo estético - cor

imdb |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucro))

# Categorizar o lucro para colocar na cor

imdb |>
  mutate(
    lucrou = if_else(lucro > 0, "Sim", "Não")
  ) |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucrou))

# Deixar transparência nos pontos em 20% (alpha)

imdb |>
  mutate(
    lucrou = if_else(lucro > 0, "Sim", "Não")
  ) |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucrou), alpha = 0.2)


# Listagem de pontos importantes

# 0 - O gráfico é construído a partir de camadas

# 1 - Para começar um gráfico, sempre começamos com a
# função ggplot()

# 2 - A partir da função ggplot(), usamos o + para
# adicionar camadas ao gráfico

# 3 - É necessário definir os atributos estéticos.

# 4 - Atributos estéticos podem ser os eixos (x e/ou y),
# cor, tamanho/size, preenchimento, transparência,
# tipo de linha, shape, entre outros.

# 5 - Quando colocamos dentro ou fora do aes()? Se formos
# mapear os valores de alguma coluna em um atributo, colocamos
# dentro do aes(). Se não formos usar o valor de alguma coluna,
# colocamos fora do aes() (e nesse caso fica um valor igual
# para todos os elementos da geometria).

# 6 - Adicionamos geometrias para criar os gráficos.
# As geometrias são criadas com as funções que começam
# com geom_*() . Ex. geom_point()

# 7 - Muitas vezes gastamos mais tempo na manipulação
# dos dados (dplyr), do que no gráfico.


# Dúvida
# tidyverse - pq usamos?


# Como salvar um gráfico?

grafico_lucro <- imdb |>
  mutate(
    lucrou = if_else(lucro > 0, "Sim", "Não")
  ) |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucrou), alpha = 0.2)

# função ggsave
ggsave(
  # nome do arquivo para salvar
  filename = "praticas/01-ggplot2-lucro.png",
  # gráfico para salvar
  plot = grafico_lucro,
  # resolução da imagem/qualidade
  # quanto maior o dpi, maior a qualidade
  # tomar cuidado, pois aumenta o tamanho da imagem
  dpi = 900,
  # largura
  width = 10,
  # altura
  height = 3
)

# outra forma: menos seguro!
#
imdb |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point()

ggsave("praticas/01-ggplo2-simples.png")


# Dúvida: não aparecer o NA

imdb |>
  mutate(
    lucrou = if_else(lucro > 0, "Sim", "Não")
  ) |>
  # removendo os NAs antes de criar o gráfico
  drop_na(lucrou) |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucrou), alpha = 0.2)



# Dúvida do Henrique: omitir eixos

imdb |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point()  +
  # omitindo os valores do eixo Y
  theme(axis.text.y = element_blank())
