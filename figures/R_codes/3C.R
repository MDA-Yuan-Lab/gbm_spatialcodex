require(dplyr); require(caret); require(tidyr); require(stringr); require(yardstick)
library(ggplot2)
library(plotROC)

aucdf_agnostic<- read.csv('/figures/source_data/fig3C_spatialagnostic.csv')
aucdf_aware<- read.csv('/figures/source_data/fig3C_spatialaware.csv')


aucdf_aware %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other')), roi=factor(roi)) %>%
  ggplot(aes(m=probs, d= as.numeric(factor(gt, levels = c(0,1)))-1)) + 
  geom_roc(aes(group=roi, color=roi), n.cuts=0, linealpha=0.4, size=0.5) +
  #scale_color_manual(values = rep('gray80', length(unique(aucdf_aware$roi))))+
  geom_abline(aes(slope=1, intercept=0), lty=2)+
  geom_roc(aes(color= time, group=time), n.cuts=0) +
  scale_colour_manual(values = c(rep('gray80', length(unique(aucdf_aware$roi))),'#3DC2C1', '#C23D3E'))+
  facet_wrap(.~class, ncol = 4) +
  guides(color='none', colour='none') +
  theme_bw() + 
  theme(text = element_text(size=6, family = 'arial'))

aucdf_agnostic %>%
  mutate(class = factor(class, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other')), roi=factor(roi)) %>%
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


# Reviewed 25072024 - SPC

