require(ggplot2); require(dplyr); require(tidyr)
matrix_expression<- read.csv('/Users/spcastillo/Documents/GitHub/gbm_spatiailcodex_yuanlab/Untitled/figures/source_data/fig1D.csv')

matrix_expression %>%
  select(!X) %>%
  pivot_longer(!phenotype, names_to = "variable", values_to = "value") %>%
  mutate(variable = factor(variable, levels = c('CD45',"CD3e", "CD4", "CD8", "CD68", "CD14", "CD16", "CD11c", "CD370", "CD1c", "CX3CR1", "Olig2", "Nestin")),
         phenotype = factor(phenotype, levels = c('TCD4', "TCD8", "Monocyte", "Macrophage", "Microglia", "DC","Tumor", "Other")) ) %>%
  ggplot( aes(x = variable, y = phenotype)) + 
 geom_raster(aes(fill=(value))) +
 scale_fill_gradientn(colours = c("white","lightskyblue2", "blue", "blue4"),
                      breaks = c(0, 1, 2, 3),
                      label = c(0, 1, 2, 3),
                      guide = guide_colourbar(nbin = 1000))+
  scale_y_discrete(limits=rev)+
#scale_fill_fermenter(direction = 1) +
  labs(x="Marker", y="Phenotype", title="", fill='z-score') +
  theme_bw() + 
  theme(axis.text.x=element_text(size=9, angle=0, vjust=0.3),
                     axis.text.y=element_text(size=9),
                     plot.title=element_text(size=11))


