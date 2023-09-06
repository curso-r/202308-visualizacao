library(tidyverse)

dados <- tibble(
  x = c("A", "B", "C", "D"),
  y = c(.1, .2, .3, .4)
)

dados |>
  ggplot(aes(x = x, y = y)) +
  geom_col()

dados |>
  mutate(
    ymin = cumsum(lag(y, default = 0)),
    ymax = cumsum(y)
  ) |>
  ggplot(aes(xmin = 0, xmax = 1, ymin = ymin, ymax = ymax, fill = x)) +
  geom_rect() +
  xlim(c(-1, 1)) +
  coord_polar(theta = "y") +
  theme_void()

