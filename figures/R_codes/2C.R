require(lme4); require(broom); require(multcomp)
metrics_node<- read.csv('step2_output-network/metrics_node.csv')


metrics_node$time <- as.factor(str_extract(metrics_node$sample, "[R,P]"))
metrics_node$sam <- as.factor(metrics_node$sample)
metrics_node$pat <- as.factor(str_extract(metrics_node$sample, "\\d{1,3}"))
metrics_node$d <- as.factor(metrics_node$d)
metrics_node$reg <- as.factor(metrics_node$reg)
metrics_node$phenotype <- as.factor(metrics_node$names.V.net..)

metrics_node$int = interaction(metrics_node$time, metrics_node$d)
metrics_node$timepat = interaction(metrics_node$time, metrics_node$pat)
metrics_node$timepheno = interaction(metrics_node$time, metrics_node$phenotype)

m= lmer(str ~ phenotype + (1|sample) + (reg|sample), data = metrics_node[metrics_node$d==50 & metrics_node$time=='P',], REML = F); anova(m)
summary(glht(m, mcp("phenotype"="Tukey")), test = adjusted('holm'))
cld(summary(glht(m, mcp("phenotype"="Tukey")), test = adjusted('holm')))


m= lmer(clos ~ phenotype + (1|sample) + (reg|sample), data = metrics_node[metrics_node$d==50 & metrics_node$time=='R',], REML = F); anova(m)
summary(glht(m, mcp("phenotype"="Tukey")), test = adjusted('holm'))
cld(summary(glht(m, mcp("phenotype"="Tukey")), test = adjusted('holm')))

require(svglite)
svglite('/Users/spcastillo/Downloads/gbm_fromseadragon_20231109/plots/node_stregth.svg', width = 3.5, height = 1.5)
metrics_node[metrics_node$d==50,]%>%  
  ggplot(aes(time, str))+
  geom_boxplot(aes(fill=phenotype), outlier.shape = NA, width=0.5, alpha=0.7)+
  theme_bw()+
  geom_quasirandom(colour= 'black',size=0.3, alpha=0.5, shape=16)+
  labs(x='', y = 'Node strength')+
  scale_y_log10()+
  #theme(axis.text.x = element_blank())+
  guides(colour='none', fill='none')+
  facet_wrap(.~phenotype, ncol= 3)+
  theme(axis.text = element_text(size=4))+
  stat_compare_means()
dev.off()

svglite('/Users/spcastillo/Downloads/gbm_fromseadragon_20231109/plots/node_closeness.svg', width = 3.5, height = 1.5)
metrics_node[metrics_node$d==50,]%>%  
  ggplot(aes(time, clos))+
  geom_boxplot(aes(fill=phenotype), outlier.shape = NA, width=0.5, alpha=0.7)+
  theme_bw()+
  geom_quasirandom(colour= 'black',size=0.3, alpha=0.5, shape=16)+
  labs(x='', y = 'Closeness')+
  #theme(axis.text.x = element_blank())+
  guides(colour='none', fill='none')+
  facet_wrap(.~phenotype, ncol= 3)+
  theme(axis.text = element_text(size=4))+
  stat_compare_means()
dev.off()

