# pacotes ----
library(ggplot2) # para fazer os gráficos
library(readr) # ler os dados
library(dplyr) # manipulação de dados
library(tidyr) # arrumar e transformar a base

# importação -------
imdb <- read_rds("dados/imdb.rds") |>
  mutate(lucro = receita - orcamento)

glimpse(imdb)

# Relembrando

# gráfico de pontos
# x = orcamento, y = nota

imdb |>
  ggplot() +
  aes(x = orcamento, y = nota_imdb) +
  geom_point(aes(color = lucro))

# também é possível resumir assim:
imdb |>
  ggplot() +
  geom_point(aes(x = orcamento,
                 y = nota_imdb,
                 color = lucro))


# geom_line() --------------------------------
# nota média dos filmes, ao longo do tempo!

imdb |>
  drop_na(ano) |>
  filter(ano >= 1912) |>
  group_by(ano) |>
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) |>
  ggplot() +
  aes(x = ano, y = nota_media) +
  geom_line() +
  # dúvida
  scale_x_continuous(limits = c(1913, 2020),
                     # usando a funcao de sequencia
                     breaks = seq(1910, 2020, by = 10)
                    # manual:
                    #breaks = c(1910, 1950, 1990, 2020)
                    )


# dúvida: remover NAs

imdb |>
  drop_na(lucro)

imdb |>
  filter(!is.na(lucro))

# Número de filmes por ano
imdb |>
  # faz a contagem de linhas por categoria
  count(ano) |>
  ggplot() +
  aes(x = ano, y = n) +
  geom_line(linetype = "dashed",
            # linetype = 2,
            color = "blue")


vetor_produtoras_famosas <- imdb |>
  count(producao, sort = TRUE) |>
  drop_na(producao) |>
  dplyr::filter(n > 500) |>
  pull(producao)

# Número de filmes por ano
imdb |>
  # faz a contagem de linhas por categoria
  count(ano, producao) |>
  filter(producao %in% vetor_produtoras_famosas) |>
  ggplot() +
  aes(x = ano, y = n) +
  geom_line(aes(groups = producao, color = producao),
            linetype = "dashed")




# Gráfico de barras ----------------------
# geom_bar() , geom_col()
# recomendo usar o geom_col()

imdb |>
  count(direcao, sort = TRUE) |>
  slice_head(n = 10) |>
  ggplot() +
  aes(x = n, y = direcao) +
  geom_col()


# Colorindo as barras...
imdb |>
  count(direcao, sort = TRUE) |>
  slice_head(n = 10) |>
  ggplot() +
  aes(x = n, y = direcao) +
  geom_col(aes(fill = direcao),
           color = "black",
           show.legend = FALSE)

# ordenar as barras segundo o numero de filmes
imdb |>
  count(direcao, sort = TRUE, name = "quantidade") |>
  slice_head(n = 10) |>
  mutate(direcao_fator = forcats::fct_reorder(direcao, quantidade)) |>
  # arrange(direcao_fator) |>
  ggplot() +
  aes(x = quantidade, y = direcao_fator) +
  geom_col(aes(fill = direcao),
           color = "black",
           show.legend = FALSE)


# Exemplo geom_bar()

imdb |>
  filter(producao %in% vetor_produtoras_famosas) |>
  mutate(producao_fator = forcats::fct_infreq(producao)) |>
  ggplot() +
  aes(y = producao_fator) +
  geom_bar(aes(fill = producao), show.legend = FALSE)


# o fct_infreq você vai usar para quando a base não estiver agregada.
# O fct_reorder você vai usar quando já tiver feito alguma agregação
# (no caso, nós fizemos aquele count(),
# que agregou a base para contagens)


# Geom_label ------

imdb |>
  count(direcao, sort = TRUE, name = "quantidade") |>
  slice_head(n = 10) |>
  mutate(direcao_fator = forcats::fct_reorder(direcao, quantidade)) |>
  ggplot() +
  aes(x = quantidade, y = direcao_fator) +
  geom_col(aes(fill = direcao),
           color = "black",
           show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2))


# geom_histogram() / geom_density()

imdb |>
  ggplot() +
  aes(x = nota_imdb) +
  geom_histogram(
    #bins = 10
  #  binwidth = 1
    )

imdb |>
  ggplot() +
  aes(x = nota_imdb) +
  geom_density()

imdb |>
  ggplot() +
  aes(x = nota_imdb) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density()

# geom_boxplot() - não agregar!!

imdb |>
  filter(producao %in% vetor_produtoras_famosas) |>
  mutate(producao_fator = forcats::fct_infreq(producao)) |>
  ggplot() +
  aes(y = producao, x = lucro) +
  geom_boxplot()


# Labs ------------------------------

imdb |>
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point(aes(color = lucro)) +
  labs(
    x = "Orçamento (US$)",
    y = "Receita (US$)",
    color = "Lucro (US$)",
    # nao dependem de aes
    title = "Receita x Orçamento do filmes",
    subtitle = "Gráfico de dispersão",
    caption = "Fonte: IMDB"
  )


imdb |>
  drop_na(lucro) |>
  select(titulo, orcamento, receita, lucro) |>
  mutate(orcamento_milhoes = orcamento/1e6,
         receita_milhoes = receita/1e6,
         lucro_milhoes = lucro/1e6) |>
  ggplot() +
  aes(x = orcamento_milhoes, y = receita_milhoes) +
  geom_point(aes(color = lucro_milhoes)) +
  labs(
    x = "Orçamento (US$ milhões)",
    y = "Receita (US$ milhões)",
    color = "Lucro (US$ milhões)",
    # nao dependem de aes
    title = "Receita x Orçamento do filmes",
    subtitle = "Gráfico de dispersão",
    caption = "Fonte: IMDB"
  )
