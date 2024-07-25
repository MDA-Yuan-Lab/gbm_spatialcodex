require(ggplot2); require(caret)

model= 'Spatial Aware'
# or 'Spatial Agnostic'

if(model == 'Spatial Aware'){
data<- read.csv('/figures/source_data/fig3B_spatialaware.csv')
data %>%
  filter(!str_extract(cellid, "IWP\\d{1,2}_reg\\d{3}")  %in% c('IWP07_reg008', 'IWP08_reg005', 'IWP09_reg001')) -> data
colcm<- '#2B388F' 
}

if(model == 'Spatial Agnostic'){
  data<- read.csv('/figures/source_data/fig3B_spatialagnostic.csv')
  data %>%
    filter(!str_extract(cellid, "IWP\\d{1,2}_reg\\d{3}")  %in% c('IWP07_reg008', 'IWP08_reg005', 'IWP09_reg001')) -> data
  colcm<-'#D6DE23'
}

data %>%
  filter(time =='P') %>%
  mutate(gt= factor(gt, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other')),
                    pred= factor(pred, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  dplyr::select(gt, pred)-> df_P

cm_P <- confusionMatrix(data=df_P$pred, reference = df_P$gt)
plt_P <- as.data.frame(round(prop.table(cm_P$table,2),4))
plt_P$Prediction <- factor(plt_P$Prediction, levels= (c('Tumor', 'Lymphoid', 'Myeloid', 'Other')))
plt_P$Reference <- factor(plt_P$Reference, levels= rev(c('Tumor', 'Lymphoid', 'Myeloid', 'Other')))

ggplot(plt_P, aes(Prediction,Reference, fill= Freq*100)) +
  geom_tile() + 
  geom_text(aes(label=Freq*100)) +
  scale_fill_gradient(low="white", high=colcm, limits=c(0, 85)) +
  labs(x = "Predicted",y = "Reference", fill='% Reference', title= paste0(model, ' model on pGBM'))+
  theme_minimal()

### Recurrent

data %>%
  filter(time =='R') %>%
  mutate(gt= factor(gt, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other')),
         pred= factor(pred, levels= c('Tumor', 'Lymphoid', 'Myeloid', 'Other'))) %>%
  dplyr::select(gt, pred)-> df_R

cm_R <- confusionMatrix(data=df_R$pred, reference = df_R$gt)
plt_R <- as.data.frame(round(prop.table(cm_R$table,2),4))
plt_R$Prediction <- factor(plt_R$Prediction, levels= (c('Tumor', 'Lymphoid', 'Myeloid', 'Other')))
plt_R$Reference <- factor(plt_R$Reference, levels= rev(c('Tumor', 'Lymphoid', 'Myeloid', 'Other')))

ggplot(plt_R, aes(Prediction,Reference, fill= Freq*100)) +
  geom_tile() + 
  geom_text(aes(label=Freq*100)) +
  scale_fill_gradient(low="white", high=colcm, limits=c(0, 85)) +
  labs(x = "Predicted",y = "Reference", fill='% Reference', title=paste0(model, ' model on rGBM'))+
  theme_minimal()

# Reviewed 25072024 - SPC

