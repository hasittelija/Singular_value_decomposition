transform_and_create_plot <- function(matrix_values, shape_matrix, size = 5) {
    if (class(matrix_values) == "matrix") {
        tr_matrix <- matrix_values
    } else {
        tr_matrix <- matrix(matrix_values, nrow = 2, byrow = T)
    }
    
    shape_matrix_transformed <- t(tr_matrix %*% t(shape_matrix))
    colnames(shape_matrix_transformed) <- c("x", "y")
    
    
    # standard basis matrix
    sbasis <- matrix(c(1,0,0,1), nrow = 2)
    # make dataframe that maps where standard basis vectors get transformed
    dfr <-as.data.frame(cbind(sbasis, t(tr_matrix)))
    colnames(dfr) <- c("x_start", "y_start", "x_end", "y_end")
    rownames(dfr) <- c("e1", "e2")
    
    gridsize <- seq(-size, size)
    create_only_plot(dfr, shape_matrix, shape_matrix_transformed, gridsize)
}

create_only_plot <- function(dfr, shape_matrix, shape_matrix_transformed, gridsize) {
    plotti <- ggplot(dfr, aes(x = x_end, y = y_end)) + geom_point(size = 5, color = "red") +
        geom_point(aes(x = x_start, y = y_start), color = "blue", size = 5) +
        geom_point(data = data.frame(shape_matrix), aes(x = x_locs, y = y_locs), color = "blue", size = 1) +
        geom_point(data = data.frame(shape_matrix_transformed), aes(x = x, y = y), color = "red", size = 1)
    
    # draw line for transform:
    plotti <- plotti + geom_segment(aes(x=x_start, y=y_start, xend=x_end, yend=y_end), arrow=arrow(), size=1, color="black", alpha = 0.5) 
    
    # fix axis and add Y/X axis lines:
    plotti <- plotti + scale_x_continuous(labels = gridsize, breaks = gridsize) + scale_y_continuous(labels = gridsize, breaks = gridsize) +
        geom_hline() + geom_vline() + expand_limits(x = c(-gridsize, gridsize), y = c(-gridsize, gridsize)) + coord_fixed(ratio = 1) +
        xlab("X") + ylab("Y")
    
    return(plotti)
}