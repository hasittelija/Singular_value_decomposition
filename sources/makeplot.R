create_plot <- function(matrix_values, circle_matrix, size = 5) {
    tr_matrix <- matrix(matrix_values, nrow = 2, byrow = T)
    
    circle_transformed <- t(tr_matrix %*% t(circle_matrix))
    colnames(circle_transformed) <- c("x", "y")
    
    
    # standard basis matrix
    sbasis <- matrix(c(1,0,0,1), nrow = 2)
    # make dataframe that maps where standard basis vectors get transformed
    dfr <-as.data.frame(cbind(sbasis, t(tr_matrix)))
    colnames(dfr) <- c("x_start", "y_start", "x_end", "y_end")
    rownames(dfr) <- c("e1", "e2")
    
    lab <- seq(-size, size)
    
    plotti <- ggplot(dfr, aes(x = x_end, y = y_end)) + geom_point(size = 5, color = "red") +
        geom_point(aes(x = x_start, y = y_start), color = "blue", size = 5) +
        geom_point(data = data.frame(circle_matrix), aes(x = x_locs, y = y_locs), color = "blue", size = 0.5) +
        geom_point(data = data.frame(circle_transformed), aes(x = x, y = y), color = "red", size = 0.5)
    
    # draw line for transform:
    plotti <- plotti + geom_segment(aes(x=x_start, y=y_start, xend=x_end, yend=y_end), arrow=arrow(), size=1, color="black", alpha = 0.5) 
    
    # fix axis and add Y/X axis lines:
    plotti <- plotti + scale_x_continuous(labels = lab, breaks = lab) + scale_y_continuous(labels = lab, breaks = lab) +
        geom_hline() + geom_vline() + expand_limits(x = c(-size, size), y = c(-size, size)) + coord_fixed(ratio = 1) +
        xlab("X") + ylab("Y")
    
    return(plotti)
}
