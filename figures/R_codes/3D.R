require(ggplot2); require(ggpubr); library(ggthemes);library(ggbeeswarm)


perclass_df_agnostic<- read.csv('statistics/perclass_df_agnostic.csv')
perclass_df_aware <- read.csv('statistics/perclass_df_aware.csv')

perclass_df_agnostic %>%
  ggplot(aes(class, F1))+
  geom_boxplot()+
  facet_wrap(.~model)

perclass_df_aware %>%
  ggplot(aes(class, F1))+
  geom_boxplot()+
  facet_wrap(.~model) +
  stat_compare_means(comparisons = list(c('Lymphoid', 'Tumor'), c('Lymphoid', 'Other'), 
                                        c('Lymphoid', 'Myeloid'), c('Myeloid', 'Other'),
                                        c('Myeloid', 'Tumor')))


print(
rbind(perclass_df_aware, perclass_df_agnostic) %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  ggplot(aes(model, F1))+
  geom_boxplot(aes(fill=model), width=.5, outliers = F)+
  geom_quasirandom(shape=16, alpha=0.5, size=0.5)+
  scale_fill_manual(values=c('#2B388F', '#D6DE23'))+
  facet_grid(test~class) +
  labs(y='F1 score')+
  guides(fill='none')+
  stat_compare_means(method = 'wilcox') +
  geom_rangeframe() + theme_bw() +
  theme(axis.text = element_text(size=4))
)
