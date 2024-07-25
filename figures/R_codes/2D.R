col_reg = c('#3DC2C1', '#C23D3E')
wd = 3.5
hg = 1.3
metrics_net <- read.csv('step2_output-network/metrics_networks.csv')

require(lme4); require(broom); require(multcomp)
metrics_net$time <- as.factor(metrics_net$time)
metrics_net$sam <- as.factor(metrics_net$sam)
metrics_net$pat <- as.factor(metrics_net$pat)
metrics_net$d <- as.factor(metrics_net$d)
metrics_net$reg <- as.factor(metrics_net$reg)
#metrics_net$phenotype <- as.factor(metrics_net$X)

metrics_net$int = interaction(metrics_net$time, metrics_net$d)
metrics_net$timepat = interaction(metrics_net$time, metrics_net$pat)

m= lmer(mod ~ int  + (1|pat) + (reg|timepat), data = metrics_net[!metrics_net$d %in% c(10, 50), ], REML = FALSE); anova(m)
mcp1=summary(glht(m, mcp("int"="Tukey")), test = adjusted('holm'))
plot(mcp1)
ci_out <- confint(mcp1)
ci_df <- as.data.frame(ci_out$confint)
ci_df$group <- row.names(ci_df)

ggplot(ci_df) +
  aes(x = Estimate, y = group) +
  geom_point() +
  geom_errorbar(aes(xmin = lwr, xmax = upr), width = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Difference in modularity", y = "Comparison")+
  theme_bw()+
  theme(axis.text = element_text(size=4))
#####
#####
#####

m= lmer(dens ~ int  + (1|pat) + (reg|timepat), data = metrics_net[!metrics_net$d %in% c(10, 50), ], REML = FALSE); anova(m)
summary(glht(m, mcp("int"="Tukey")), test = adjusted('holm'))
mcp1=summary(glht(m, mcp("int"="Tukey")), test = adjusted('holm'))
plot(mcp1)
ci_out <- confint(mcp1)
ci_df <- as.data.frame(ci_out$confint)
ci_df$group <- row.names(ci_df)

svglite('/Users/spcastillo/Downloads/gbm_fromseadragon_20231109/plots/net_density.svg', width = 3.5/2, height = 1.5)
ggplot(ci_df) +
  aes(x = Estimate, y = group) +
  geom_point() +
  geom_errorbar(aes(xmin = lwr, xmax = upr), width = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Difference in degree density", y = "Comparison")+
  theme_bw()+
  theme(axis.text = element_text(size=4))
dev.off()
