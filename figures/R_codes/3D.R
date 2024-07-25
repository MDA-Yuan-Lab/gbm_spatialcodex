require(ggplot2); require(ggpubr); library(ggthemes);library(ggbeeswarm)


perclass_df_agnostic<- read.csv('/figures/source_data/fig3D_spatialagnostic.csv')
perclass_df_aware <- read.csv('/figures/source_data/fig3D_spatialaware.csv')

print(
rbind(perclass_df_aware, perclass_df_agnostic) %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  ggplot(aes(model, F1))+
  geom_boxplot(aes(fill=model), width=.5, outliers = F)+
  geom_quasirandom(shape=16, alpha=0.5, size=0.5)+
  scale_fill_manual(values=c( '#D6DE23','#2B388F'))+
  facet_grid(test~class) +
  labs(y='F1 score')+
  stat_compare_means(method = 'wilcox') +
  geom_rangeframe() + theme_bw() +
  theme(axis.text = element_text(size=4))
)

# Reviewed 25072024 - SPC
