require(lme4); require(broom); require(multcomp); require(ggplot2)

col_reg = c('#3DC2C1', '#C23D3E')
wd = 2.5
hg = 2

df_2d <- read.csv('figures/source_data/fig2D.csv')

##### modularity

df_2d$time_dist = interaction(df_2d$time, df_2d$distance)
df_2d$time_pat = interaction(df_2d$time, df_2d$patient)

m= lmer(modularity ~ time_dist  + (1|patient) + (region|time_pat), data = df_2d, REML = FALSE); anova(m)

mcp1=summary(glht(m, mcp("time_dist"="Tukey")), test = adjusted('holm'))
ci_out <- confint(mcp1)
ci_df <- as.data.frame(ci_out$confint)
ci_df$group <- row.names(ci_df)

print(
ggplot(ci_df) +
  aes(x = Estimate, y = group) +
  geom_point() +
  geom_errorbar(aes(xmin = lwr, xmax = upr), width = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Difference in modularity", y = "Comparison")+
  theme_bw()+
  theme(axis.text = element_text(size=4))
)

##### degree_density

m= lmer(degree_density ~ time_dist  + (1|patient) + (region|time_pat), data = df_2d, REML = FALSE); anova(m)

mcp1=summary(glht(m, mcp("time_dist"="Tukey")), test = adjusted('holm'))
ci_out <- confint(mcp1)
ci_df <- as.data.frame(ci_out$confint)
ci_df$group <- row.names(ci_df)

print(ggplot(ci_df) +
  aes(x = Estimate, y = group) +
  geom_point() +
  geom_errorbar(aes(xmin = lwr, xmax = upr), width = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Difference in modularity", y = "Comparison")+
  theme_bw()+
  theme(axis.text = element_text(size=4))
)
# Reviewed 25072024 - SPC
