require(ggplot2); require(ggbeeswarm); require(dplyr);require(lme4); require(lmerTest); require(multcomp)

### Plots
col_reg = c('#3DC2C1', '#C23D3E')

# Fig 1E
df_1e <- read.csv('/figures/source_data/fig1E.csv')
      # stats
      m= lmer(diversity ~ tHTI + (region|patient) + (1|patient), data = df_1e); anova(m)
      summary(glht(m, mcp("tHTI"="Tukey")), test = adjusted('holm'))
      
      #plot
            print(df_1e %>%
              ggplot(aes(tHTI, diversity)) +
              geom_boxplot(aes(fill= tHTI), outlier.shape = NA,alpha=0.7, width=0.5)+
              scale_fill_manual(values = rep(col_reg, each=2))+
              geom_quasirandom(colour= 'black',size=0.2)+
              theme_bw() +
              scale_y_continuous(limits = c(0, 1))+
              guides(colour = 'none', fill = 'none')+
              labs(y = 'Immune diversity (Gini-Simpson index)', x= '')
            )

# Fig 1F
df_1f <- read.csv('/figures/source_data/fig1F.csv')
      
      #stats (example)
      df_1fex = df_1f %>% filter(phenotype=='TCD8')
      m= lmer(density ~ time + (region|patient) + (1|patient), data = df_1fex); anova(m) # if error try next line
      m= lmer(density ~ time + (1|patient), data = df_1fex); anova(m) 
      
      #plot
      print( df_1f %>%
              ggplot(aes(time, density*1000000)) +
              geom_boxplot(aes(fill= time), outlier.shape = NA, width=0.5, alpha=0.7) +
              scale_fill_manual(values = col_reg)+
              geom_quasirandom(colour= 'black',size=0.2)+
              theme_bw() +
              guides(colour = 'none', fill = 'none')+
              labs(y = 'Cell density (cells/ mm2)')+
              scale_y_log10()+
              facet_wrap(. ~ phenotype, nrow = 1)
      )


# Fig 1G
df_1g <- read.csv('/figures/source_data/fig1G.csv')

#stats (example)
df_1Gex = df_1g %>% filter(phenotype=='TCD8')
m= lmer(density ~ time + (region|patient) + (1|patient), data = df_1Gex); anova(m) # if error try next line
m= lmer(density ~ time + (1|patient), data = df_1Gex); anova(m)

#plot
print(df_1g %>%
        ggplot(aes(time, density*1000000)) +
        geom_boxplot(aes(fill= time), outlier.shape = NA, width=0.5, alpha=0.7) +
        scale_fill_manual(values = col_reg)+
        geom_quasirandom(colour= 'black',size=0.2)+
        theme_bw() +
        guides(colour = 'none', fill = 'none')+
        labs(y = 'Cell density (cells/ mm2)')+
        scale_y_log10()+
        facet_wrap(. ~ phenotype, nrow = 1)
)

# Reviewed 25072024 - SPC


