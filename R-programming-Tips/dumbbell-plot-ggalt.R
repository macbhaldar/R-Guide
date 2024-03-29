# ggalt: dumbbell plots

library(tidyverse)
library(tidyquant)
library(ggalt)

mpg

# DATA WRANGLING

mpg_by_year_tbl <- mpg %>%
  select(hwy, year, model, class) %>%
  pivot_wider(
    names_from   = year,
    values_from  = hwy,
    id_cols      = c(class, model),
    values_fn    = function(x) mean(x, na.rm = TRUE),
    names_prefix = "year_"
  ) %>%
  mutate(model = fct_reorder(model, year_2008)) %>%
  drop_na()

# VISUALIZATION

## Dumbbell Plot with ggalt
g1 <- mpg_by_year_tbl %>%
  ggplot(aes(x = year_1999, xend = year_2008, y = model, group = model)) +
  
  geom_dumbbell(
    colour="#a3c4dc",
    colour_xend="#0e668b",
    size=4.0,
    dot_guide=TRUE,
    dot_guide_size=0.15,
    dot_guide_colour = "grey60"
  )

g1

## Customize Theme with tidyquant
g2 <- g1 +
  labs(
    title = "Change Vehicle Fuel Economy between 1999 and 2008",
    x="Fuel Economy (MPG)", y = "Vehicle Model"
  ) +
  theme_tq() +
  theme(
    panel.grid.minor=element_blank(),
    panel.grid.major.y=element_blank(),
    panel.grid.major.x=element_line(),
    axis.ticks=element_blank(),
    panel.border=element_blank()
    
  )
