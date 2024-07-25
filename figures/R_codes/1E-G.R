require(dplyr);require(stringr); require(ggradar); require(vegan); require(ggbeeswarm); require(tidyr); library(scales)
options(scipen = 999)
load("step0_output-qc/dataafterQC_CTIT_phenotyped_20231107.rdata")

alldata_afterQC %>%
  filter(path_region  != 'background', phenotype != 'NA') %>%
  group_by(acquisition_id, path_region) %>%
  summarise(sample = unique(sample),
            totalcells= n(),
            totalimmune =  length(phenotype[!phenotype %in% c('Tumor', 'Other')]),
            nTum = length(phenotype[phenotype =='Tumor']),
            nTCD4 = length(phenotype[phenotype=='TCD4']),
            nTCD8= length(phenotype[phenotype=='TCD8']),
            nMonocyte= length(phenotype[phenotype=='Monocyte']),
            nMacrophages= length(phenotype[phenotype=='Macrophage']),
            nDC= length(phenotype[phenotype=='DC']),
            nMicroglia= length(phenotype[phenotype=='Microglia'])) %>%
  ungroup()->summarycell_sample

# 
summarycell_sample$time= str_extract(summarycell_sample$sample, '[R,P]')
summarycell_sample$patient = str_extract(summarycell_sample$sample, '\\d{1,2}')
summarycell_sample$region = str_extract(summarycell_sample$acquisition_id, 'reg\\d{3}')
summarycell_sample$diversity = summarycell_sample %>%
  dplyr::select(nTCD4:nMicroglia)  %>% as.matrix() %>% diversity(index = 'simpson')





os_pre = 'QuPath/masks/'
num_ids = do.call(paste0, expand.grid( c('P','R'), str_pad(5:11, 2, pad='0')))
mask_measurements = data.frame()
for(num_id in num_ids){
  iwp11_masks <- Sys.glob(paste0(os_pre,'IW',num_id,'/*', '*.png'))
  pat_id <- paste0('IW',num_id)
  
  for(i in 1:length(iwp11_masks)){
    print(pat_id)
    target_region<-str_extract(iwp11_masks[i], 'reg\\d{1,3}')
    annot_path <- Sys.glob(paste0(os_pre, pat_id ,'/*', target_region, '*.txt'))
    annot_df <- read.csv(annot_path, sep="\t", header=T)
    pos_area = pmatch('Area', names(annot_df))
    if(nrow(annot_df) == 0) next
    
    print(target_region)
    
    if(names(annot_df)[pos_area] == 'Area.px.2'){
      annot_df = annot_df %>%
        mutate(Area.µm.2 = Area.px.2 * (0.3774039)^2 )
    }
    
    annot_df <- annot_df %>%
      dplyr::group_by(Class) %>%
      summarise(area= sum(Area.µm.2))
    
    
    annot_df = data.frame(patient = rep(pat_id,nrow(annot_df)) ,
                          region = rep(target_region,nrow(annot_df)),
                          annot_df)
    
    mask_measurements = rbind(mask_measurements, annot_df)
    
  }
}


summarycell = summarycell_sample %>%
  filter(path_region %in% c('Cellular tumor', 'Infiltrating tumor')) %>%
  mutate(combinedid = paste(sample, region, path_region, sep = '-'))

mask_measurements = mask_measurements %>%
  mutate(combinedid = paste(patient, region, Class, sep = '-'))


comb_summaryimmune = merge(summarycell, mask_measurements[, c('combinedid', 'area')], by = 'combinedid')



comb_summaryimmune %>%
  #filter(path_region == 'Cellular tumor', time == 'P') %>%
  mutate(across(totalcells:nMicroglia, ~ ./area)) %>%
  pivot_longer(totalcells:nMicroglia, names_to = "phenotype", values_to = "density") %>%
  filter(phenotype %in% c('nTCD4', 'nTCD8', 'nMacrophages', 'nMicroglia', 'nMonocyte', 'nDC')) %>%
  mutate(phenotype = str_remove(phenotype, 'n*')) %>%
  mutate(time = case_when(time == 'P' ~ 'pGBM', time =='R' ~ 'rGBM'))%>%
  filter(path_region == 'Cellular tumor', phenotype == 'DC') -> df_mm


### stats
require(lme4); require(lmerTest); require(multcomp)
summarycell_sample$time <- as.factor(summarycell_sample$time)
summarycell_sample$sample <- as.factor(summarycell_sample$sample)
summarycell_sample$patient <- as.factor(summarycell_sample$patient)
summarycell_sample$region <- as.factor(summarycell_sample$region)
summarycell_sample$path_region <- as.factor(summarycell_sample$path_region)

d0=summarycell_sample %>%
  filter(path_region %in% c('Cellular tumor', 'Infiltrating tumor')) %>%
  mutate(path_region = factor(path_region),
         time = factor(time))
d0$int = interaction(d0$time, d0$path_region)


m= lmer(diversity ~ int + (region|patient) + (1|patient), data = d0); anova(m)
summary(glht(m, mcp("int"="Tukey")), test = adjusted('holm'))





comb_summaryimmune %>%
  mutate(across(totalcells:nMicroglia, ~ ./area)) %>%
  pivot_longer(totalcells:nMicroglia, names_to = "phenotype", values_to = "density") %>%
  filter(phenotype %in% c('nTCD4', 'nTCD8', 'nMacrophages', 'nMicroglia', 'nMonocyte', 'nDC')) %>%
  mutate(phenotype = str_remove(phenotype, 'n*')) %>%
  mutate(phenotype = factor(phenotype, levels=c('TCD4', 'TCD8', 'Monocyte', 'Macrophages', 'Microglia', 'DC')))%>%
  mutate(time = case_when(time == 'P' ~ 'pGBM', time =='R' ~ 'rGBM'))%>%
  filter(path_region == 'Cellular tumor') -> d1

d12 = d1 %>% filter(phenotype=='TCD8')
m= lmer(density ~ time + (region|patient) + (1|patient), data = d12); anova(m)
m= lmer(density ~ time + (1|patient), data = d12); anova(m)



summary(glht(m, mcp("time"="Tukey")), test = adjusted('holm'))

df_1e<- summarycell_sample %>%
  filter(path_region %in% c('Cellular tumor', 'Infiltrating tumor')) %>%
  mutate(tHTI = paste0(time, path_region)) %>%
  dplyr::select(sample, region, tHTI, diversity)


comb_summaryimmune %>%
  mutate(across(totalcells:nMicroglia, ~ ./area)) %>%
  pivot_longer(totalcells:nMicroglia, names_to = "phenotype", values_to = "density") %>%
  filter(phenotype %in% c('nTCD4', 'nTCD8', 'nMacrophages', 'nMicroglia', 'nMonocyte', 'nDC')) %>%
  mutate(phenotype = str_remove(phenotype, 'n*')) %>%
  mutate(phenotype = factor(phenotype, levels=c('TCD4', 'TCD8', 'Monocyte', 'Macrophages', 'Microglia', 'DC')))%>%
  mutate(time = case_when(time == 'P' ~ 'pGBM', time =='R' ~ 'rGBM'))%>%
  filter(path_region == 'Cellular tumor') %>%
  dplyr::select(sample, region, time, density, phenotype)-> df_1f

comb_summaryimmune %>%
  mutate(across(totalcells:nMicroglia, ~ ./area)) %>%
  pivot_longer(totalcells:nMicroglia, names_to = "phenotype", values_to = "density") %>%
  filter(phenotype %in% c('nTCD4', 'nTCD8', 'nMacrophages', 'nMicroglia', 'nMonocyte', 'nDC')) %>%
  mutate(phenotype = str_remove(phenotype, 'n*')) %>%
  mutate(phenotype = factor(phenotype, levels=c('TCD4', 'TCD8', 'Monocyte', 'Macrophages', 'Microglia', 'DC')))%>%
  mutate(time = case_when(time == 'P' ~ 'pGBM', time =='R' ~ 'rGBM'))%>%
  filter(path_region == 'Infiltrating tumor')%>%
  dplyr::select(sample, region, time, density, phenotype) -> df_1g

write.csv(df_1e, file='figures_datasource/fig1E.csv')
write.csv(df_1f, file='figures_datasource/fig1F.csv')
write.csv(df_1g, file='figures_datasource/fig1G.csv')


### Plots
col_reg = c('#3DC2C1', '#C23D3E')


## Immune diversity

#svglite(filename = "/Users/spcastillo/Library/CloudStorage/OneDrive-InsideMDAnderson/from_Yinyin/yuanlab/Manuscripts/GBM_mda/Rplots/density.svg", width = 3, height = 2)
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
#dev.off()

#cell density
#svglite(filename = "/Users/spcastillo/Library/CloudStorage/OneDrive-InsideMDAnderson/from_Yinyin/yuanlab/Manuscripts/GBM_mda/Rplots/CT-density.svg", width = 6.5, height = 2.5)
print( df1_f %>%
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
#dev.off()



svglite(filename = "/Users/spcastillo/Library/CloudStorage/OneDrive-InsideMDAnderson/from_Yinyin/yuanlab/Manuscripts/GBM_mda/Rplots/IT-density.svg", width = 6.5, height = 2.5)
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
dev.off()


