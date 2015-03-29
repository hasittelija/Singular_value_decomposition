transform_and_create_plot <- function(matrix_values, shape_matrix, size = 5, ...) {

    matrix_list <- transform_matrixes(matrix_values, shape_matrix, ...)

    gridsize <- seq(-size, size)
    create_only_plot(matrix_list$point_before, matrix_list$point_after, 
                     matrix_list$shape_before, matrix_list$shape_after, gridsize)
}

transform_matrixes <- function(transform_matrix, shape_matrix, point_matrix = NULL) {
    if (class(transform_matrix) == "matrix") {
        tr_matrix <- transform_matrix
    } else {
        tr_matrix <- matrix(transform_matrix, nrow = 2, byrow = T)
    }
    
    shape_matrix_transformed <- t(tr_matrix %*% t(shape_matrix))
    colnames(shape_matrix_transformed) <- c("x", "y")
    
    if (is.null(point_matrix)) {
        point_matrix <- diag(2)
    }
    
    colnames(point_matrix) <- c("x_start", "y_start")
    
    point_matrix_transformed <- t(tr_matrix %*% t(point_matrix))
    colnames(point_matrix_transformed) <- c("x_end", "y_end")
    
    return(list("shape_before" = shape_matrix, 
                "shape_after" = shape_matrix_transformed, 
                "point_before" = point_matrix, 
                "point_after" = point_matrix_transformed))
}


create_only_plot <- function(start_point_matrix, end_point_matrix, shape_matrix, shape_matrix_transformed, gridsize) {
    plotti <- ggplot(data = data.frame(start_point_matrix), aes(x = x_start, y = y_start)) + geom_point(size = 5, color = "red") +
        geom_point(data = data.frame(end_point_matrix), aes(x = x_end, y = y_end), color = "blue", size = 5) +
        geom_point(data = data.frame(shape_matrix), aes(x = x_locs, y = y_locs), color = "blue", size = 1) +
        geom_point(data = data.frame(shape_matrix_transformed), aes(x = x, y = y), color = "red", size = 1)
    
    # draw line for transform:
    plotti <- plotti + geom_segment(data = data.frame(cbind(start_point_matrix, end_point_matrix)), 
                                    aes(x=x_start, y=y_start, xend=x_end, yend=y_end), arrow=arrow(), size=1, color="black", alpha = 0.5) 
    
#     plotti <- plotti + geom_segment(data = data.frame(start_point_matrix),
#                                     aes(x = 0, y = 0, xend = x_start, yend = y_start), arrow = arrow(), size = 1, color = "orange", alpha = 0.5)
    
    # fix axis and add Y/X axis lines:
    plotti <- plotti + scale_x_continuous(labels = gridsize, breaks = gridsize) + scale_y_continuous(labels = gridsize, breaks = gridsize) +
        geom_hline() + geom_vline() + expand_limits(x = c(-gridsize, gridsize), y = c(-gridsize, gridsize)) + coord_fixed(ratio = 1) +
        xlab("X") + ylab("Y")
    
    return(plotti)
}