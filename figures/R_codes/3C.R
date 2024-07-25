require(dplyr); require(caret); require(tidyr); require(stringr); require(yardstick)
library(ggplot2)
library(plotROC)

aucdf_agnostic<- read.csv('figures_datasource/fig3C_agnostic.csv')
aucdf_aware<- read.csv('figures_datasource/fig3C_aware.csv')


aucdf_agnostic %>%
  mutate(class = factor(class, levels= (c('Tumor', 'Lymphoid', 'Myeloid', 'Other')))) %>%
  filter(class== 'Other') %>%
  ggplot(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1, colour= time )) + 
  geom_roc(n.cuts=0) +
  theme_bw() +
  scale_colour_manual(values = c('#3DC2C1', '#C23D3E')) -> g

g + annotate("text", x=0.75, y=0.35, label=paste("AUC =", round((calc_auc(g))$AUC[1],3)),colour='#3DC2C1') +
  annotate("text", x=0.75, y=0.25, label=paste("AUC =", round((calc_auc(g))$AUC[2], 3)),colour='#C23D3E')

aucdf_agnostic %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  ggplot(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1)) + 
  geom_roc(aes(group=roi, color=roi), n.cuts=0, linealpha=0.4, size=0.5) +
  scale_color_manual(values = rep('gray80', length(unique(aucdf_agnostic$roi))))+
  geom_abline(aes(slope=1, intercept=0), lty=2)+
  geom_roc(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1, colour= time ), n.cuts=0) +
  scale_colour_manual(values = c(rep('gray80', length(unique(aucdf_agnostic$roi))),'#3DC2C1', '#C23D3E'))+
  facet_wrap(.~class, ncol = 4) +
  guides(color='none', colour='none') +
  theme_bw() + 
  theme(text = element_text(size=6, family = 'arial'))

aucdf_aware %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  ggplot(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1)) + 
  geom_roc(aes(group=roi, color=roi), n.cuts=0, linealpha=0.4, size=0.5) +
  scale_color_manual(values = rep('gray80', length(unique(aucdf_aware$roi))))+
  geom_abline(aes(slope=1, intercept=0), lty=2)+
  geom_roc(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1, colour= time ), n.cuts=0) +
  scale_colour_manual(values = c(rep('gray80', length(unique(aucdf_aware$roi))),'#3DC2C1', '#C23D3E'))+
  facet_wrap(.~class, ncol = 4) +
  guides(color='none', colour='none') +
  theme_bw() + 
  theme(text = element_text(size=6, family = 'arial'))
