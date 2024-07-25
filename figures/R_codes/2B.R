require(igraph)

load( file='figures_datasource/2B_metanetwork_primary.rdata')
load(file='figures_datasource/2B_metanetwork_recurrent.rdata')

wtcP <- cluster_louvain(netP); plot(wtcP, netP); wtcP    
wtcR <- cluster_louvain(netR); plot(wtcR, netR); wtcR   
