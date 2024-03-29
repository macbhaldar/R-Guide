# ggalt: Lollipop Plots

library(tidyverse)
library(tidyquant)
library(ggalt)

mpg

# DATA WRANGLING

mpg_by_class_tbl <- mpg %>%
  select(hwy, model, class) %>%
  group_by(class) %>%
  summarise(mean_hwy = mean(hwy, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(class = fct_reorder(class, mean_hwy))

mpg_by_class_tbl

# VISUALIZATION 

## Basic Dumbbell Plot with ggalt
g1 <- mpg_by_class_tbl %>%
  ggplot(aes(x = mean_hwy, y = class)) +
  
  geom_lollipop(
    horizontal   = TRUE,
    point.colour = "dodgerblue",
    point.size   = 10,
    color        = "#2c3e50",
    size         = 1
  )

g1

## Customize Theme with geom_label and tidyquant theme_tq 
g2 <- g1 +
  geom_label(
    aes(label = str_glue("Vehicle Class: {toupper(class)}
                             mpg: {round(mean_hwy)}")),
    size    = 3,
    hjust   = "outward",
    nudge_x = 2
  ) +
  expand_limits(x = 45) +
  labs(
    title = "Vehicle Fuel Economy Lollipop Plot",
    x="Fuel Economy (MPG)", y = "Vehicle Class"
  ) +
  theme_tq() +
  theme(
    panel.grid.minor=element_blank(),
    panel.grid.major.y=element_blank(),
    panel.grid.major.x=element_line(),
    axis.ticks=element_blank(),
    panel.border=element_blank()
    
  )

g2
