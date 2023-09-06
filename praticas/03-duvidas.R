# DÚVIDA FABIANO -----------------------------------
# como pesquisar a coordenada a partir de um endereço
# install.packages('tidygeocoder')
library(tidygeocoder)
library(tidyverse)

exemplo_enderecos <- tibble::tribble(
  ~nome, ~endereco,
  "Shopping Continental", "Parque Continental, São Paulo - State of São Paulo, 05328-020",
  "Shopping União", "Av. dos Autonomistas, 1400 - Vila Yara, Osasco - SP, 06020-010",
  "Super Shopping",  "Av. dos Autonomistas, 1828 - Vila Yara, Osasco - SP, 06020-010"
)


# https://cran.r-project.org/web/packages/tidygeocoder/readme/README.html
#
enderecos_lat_long <- exemplo_enderecos |>
  geocode(endereco, method = "arcgis")

# Outra opção para testar:
# https://github.com/dkahle/ggmap

# Outra opção:
# https://gist.github.com/jtrecenti/18f5ebfebaef7d224d8b93d26feccb02


# dúvida 1 do Henrique

# Dentro deste contexto, volumetria eu deixo em colunas e
#  as variáveis de taxa eu deixo como linhas.
# Se possível, eu gostaria de fazer um gráfico assim.

df <- tibble(
  VOLUMETRIA = c(400, 800, 200, 300, 600),
  TAXA_APROVACAO = c(0.6, 0.8, 0.7, 0.9, 0.4),
  TAXA_MAUS = c(0.2, 0.17, 0.22, 0.15, 0.20),
  MES = c(01, 02, 03, 04, 05)
)


df |>
  mutate(TAXA_APROVACAO = TAXA_APROVACAO * 500,
         TAXA_MAUS = TAXA_MAUS * 500) |>
  ggplot() +
  geom_col(aes(x = MES, y = VOLUMETRIA)) +
  geom_line(aes(x = MES, y = TAXA_APROVACAO)) +
  geom_line(aes(x = MES, y = TAXA_MAUS)) +
  scale_y_continuous(sec.axis = sec_axis(
    trans = ~.x/500,
    name = "taxa"
  ))

# Fizemos pela dúvida, mas o Hadley não recomenda
