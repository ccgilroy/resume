library(igraph)
library(tidyverse)
library(tidygraph)
library(ggraph)
library(ggthemes)

set.seed(123)
# set.seed(42)
g <- sample_smallworld(dim = 1, size = 12, nei = 2, p = 0.1)

g <- as_tbl_graph(g)

g <- 
  g %>%
  activate(nodes) %>% 
  mutate(color = as_factor(sample(1:3, igraph::vcount(g), replace = TRUE)))
  
p <- 
  ggraph(g, layout = "nicely") + 
  geom_edge_link(color = "#073642", alpha = .5) + 
  geom_node_point(aes(color = color), size = 8) + 
  scale_color_solarized(accent = "magenta") +
  theme_graph(background = NA) +
  guides(color = FALSE)

ggsave(filename = "logo.png", plot = p, 
       width = 4, height = 4, 
       bg = "transparent")
