require(ggplot2); require(dplyr); require(ggExtra); require(svglite); require(scales)

topological_clinical<- read.csv('source_data/figS1AB.csv')

cols_sex <- c('blue', '#dd3706')

#Fig S1A

      #Stats
      glm1 = glm(days_to_relapse ~ sex , data = topological_clinical, family = 'poisson'); anova(glm1, test = "F")
      glm1 = glm(age ~ sex, data = topological_clinical, family = 'poisson'); anova(glm1, test = "F")
      glm1 = glm(days_to_relapse ~ sex * age, data = topological_clinical, family = 'poisson');Anova(glm1, test = "LR"); summary(glm1)
      
      # Calculate R-squared
      deviance <- summary(glm1)$deviance
      null_deviance <- summary(glm1)$null.deviance
      rsquared <- 1 - (deviance / null_deviance)
      
      #plot
      topological_clinical%>%
        ggplot(aes(primary_degree_density, days_to_relapse, color=sex))+
        geom_point()+
        geom_smooth(method = 'glm',se = F)+
        scale_color_manual(values=cols_sex)+
        scale_fill_manual(values=cols_sex)+
        scale_y_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        scale_x_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        guides(color='none')+
        theme_bw()->p; ggMarginal(p,groupFill =T, type = 'boxplot',size = 4)

#Fig S1B
      
      #Stats
      require(betareg); library(rcompanion)
      model.beta = betareg(primary_degree_density ~ sex * age, data=topological_clinical);Anova(model.beta);summary(model.beta)
      
      #plot
      topological_clinical%>%
        ggplot(aes(y=primary_degree_density, age, color=sex))+
        geom_point()+
        geom_smooth(method = 'glm',se = F)+
        scale_color_manual(values=cols_sex)+
        scale_fill_manual(values=cols_sex)+
        scale_y_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        scale_x_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        guides(color='none')+
        theme_bw()->p; ggMarginal(p,groupFill =T, type = 'boxplot',size = 4)


#Fig S1C
      
      #Stats
      require(betareg); library(rcompanion)
      model.beta = betareg(primary_modularity ~ sex * age, data=topological_clinical);Anova(model.beta);summary(model.beta)
      
      #plot
      topological_clinical%>%
        ggplot(aes(primary_modularity, days_to_relapse, color=sex))+
        geom_point()+
        geom_smooth(method = 'glm',se = F)+
        scale_color_manual(values=cols_sex)+
        scale_fill_manual(values=cols_sex)+
        scale_y_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        scale_x_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        guides(color='none')+
        theme_bw()->p; ggMarginal(p,groupFill =T, type = 'boxplot',size = 4)

#Fig S1D

      #Stats
      glm1 = glm(days_to_relapse ~ sex * primary_degree_density, data = topological_clinical, family = 'poisson');Anova(glm1, test = "LR"); summary(glm1)
      
      # Calculate R-squared
      deviance <- summary(glm1)$deviance
      null_deviance <- summary(glm1)$null.deviance
      rsquared <- 1 - (deviance / null_deviance)

      #plot
      topological_clinical%>%
        ggplot(aes(y=primary_modularity, age, color=sex))+
        geom_point()+
        geom_smooth(method = 'glm',se = F)+
        scale_color_manual(values=cols_sex)+
        scale_fill_manual(values=cols_sex)+
        scale_y_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        scale_x_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        guides(color='none')+
        theme_bw()->p; ggMarginal(p,groupFill =T, type = 'boxplot',size = 4)

#Fig S1E

      #Stats
            glm1 = glm(days_to_relapse ~ sex * primary_modularity, data = topological_clinical, family = 'poisson');Anova(glm1, test = "LR"); summary(glm1)
            
            # Calculate R-squared
            deviance <- summary(glm1)$deviance
            null_deviance <- summary(glm1)$null.deviance
            rsquared <- 1 - (deviance / null_deviance)
      #plot
      topological_clinical%>%
        ggplot(aes(age, days_to_relapse,color=sex))+
        geom_point()+
        geom_smooth(method = 'glm',se = F)+
        scale_color_manual(values=cols_sex)+
        scale_fill_manual(values=cols_sex)+
        scale_y_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        scale_x_continuous(breaks = trans_breaks(identity, identity, n = 4))+
        guides(color='none')+
        theme_bw()->p; ggMarginal(p,groupFill =T, type = 'boxplot',size = 4)
      
      
# Reviewed 25072024 - SPC
      
