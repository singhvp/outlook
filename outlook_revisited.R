require(devtools)
devtools::install_github("thomasp85/ggraph")
require(ggplot2)
library(ggraph)
require(igraph)
require(tidyverse)

setwd("~/Desktop")

x <- read.csv("outlook.csv", header = TRUE)
colnames(x) <- c('subject', 'body', 'from_name', 'from_address', 'from_type', 
                'to_name', 'to_address', 'to_type', 'cc_name', 'cc_address', 
                'cc_type', 'bcc_name', 'bcc_address', 'bcc_type', 'billing_info', 
                'categories', 'importance', 'mileage', 'sensitivity')

y <- select(x, from_name, to_name, categories)

y$from_name <- as.numeric(y$from_name)
y$to_name <- as.numeric(y$to_name)
z <- graph_from_data_frame(y)



# perfect graph
ggraph(z, layout = 'linear', circular = TRUE) + 
  geom_edge_arc(aes(alpha = categories)) + scale_alpha(range = c(0.0, 0.9))

#  geom_node_text(aes(x = x*1.05, y=y*1.05, angle = nAngle(x, y)), 
#                     size=3, hjust='outward')
#  geom_node_label(aes(label = from_name))



# next step to do is filter message with high freq from or to

a <- ggraph(z, layout = 'linear', circular = TRUE) + 
  geom_edge_arc(aes(colour = categories), alpha = 0.1) 

a + scale_color_manual(values = c(" " = "white", "Education" = "red", 
                                  "MES" = "green", "MII" = "grey", 
                                  "novo" = "blue", "NOVO" = "blue", 
                                  "SharePoint" = "black"))

