require(lme4); require(broom); require(multcomp); require(ggpubr); require(ggplot2)

col_reg = c('#3DC2C1', '#C23D3E')
df_2c <- read.csv('/figures/source_data/fig2C.csv')

#stats (example)
df_2cex = df_2c %>% filter(phenotype=='Tumor')
m= lmer(node_strength ~ time + (region|patient) + (1|patient), data = df_2cex); anova(m)
m= lmer(node_closeness ~ time + (region|patient) + (1|patient), data = df_2cex); anova(m) # if error try next line

m= lmer(node_strength ~ time + (1|patient), data = df_2cex); anova(m) 
m= lmer(node_closeness ~ time + (1|patient), data = df_2cex); anova(m) 

#node strength
df_2c%>%  
  ggplot(aes(time, node_strength))+
  geom_boxplot(aes(fill=time), outlier.shape = NA, width=0.5, alpha=0.7)+
  scale_fill_manual(values = col_reg)+
  theme_bw()+
  geom_quasirandom(colour= 'black',size=0.3, alpha=0.5, shape=16)+
  labs(x='', y = 'Node strength')+
  scale_y_log10()+
  guides(colour='none', fill='none')+
  facet_wrap(.~phenotype, nrow=1)+
  #stat_compare_means()+
  theme(axis.text = element_text(size=4))

df_2c%>%    
  ggplot(aes(time, node_closeness))+
  geom_boxplot(aes(fill=time), outlier.shape = NA, width=0.5, alpha=0.7)+
  scale_fill_manual(values = col_reg)+
  theme_bw()+
  geom_quasirandom(colour= 'black',size=0.3, alpha=0.5, shape=16)+
  labs(x='', y = 'Closeness')+
  guides(colour='none', fill='none')+
  facet_wrap(.~phenotype, nrow=1)+
  #stat_compare_means()+
  theme(axis.text = element_text(size=4))
