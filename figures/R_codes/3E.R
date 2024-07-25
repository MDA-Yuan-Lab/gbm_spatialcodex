save(net.tidy.p, file='figures_datasource/fig3E.rdata')

require(ggraph)
print(ggraph(net.tidy.p, layout = "linear") + 
        geom_edge_arc(aes(width = weightratio, color=weightratio<1), alpha = 0.8, strength=-1) + 
        #scale_edge_width(limits = c(0, 10),range = c(0,3)) +
        geom_edge_loop(aes(width = weightratio,color=weightratio<1, direction=0, span=30),alpha = 0.8, force_flip = F)+ 
        scale_edge_color_manual(values = c('#3DC2C1', '#C23D3E'))+
        #scale_edge_color_gradient(low="gray", high="#3DC2C1",limits=c(0, 10)) +
        geom_node_text(aes(label = label), repel = F) +
        labs(edge_width = "Fold change", edge_color ='pGBM < rGBM') +
        theme_graph()
)
