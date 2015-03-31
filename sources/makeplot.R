transform_and_create_plot <- function(start_matrix, end_matrix, point_matrix, shape_matrix, size = 5, ...) {
    if (!is.null(start_matrix)) {
        point_matrix <- transform_matrix(start_matrix, point_matrix)
        shape_matrix <- transform_matrix(start_matrix, shape_matrix)
    }
    
    point_matrix_transformed <- transform_matrix(end_matrix, point_matrix)
    shape_matrix_transformed <- transform_matrix(end_matrix, shape_matrix)
    
    matrix_list <- name_columns(point_matrix, point_matrix_transformed, shape_matrix, shape_matrix_transformed)

    gridsize <- seq(-size, size)
    create_only_plot(matrix_list$point_before, matrix_list$point_after, 
                     matrix_list$shape_before, matrix_list$shape_after, gridsize)
}


# Apply linear mapping given by transformation matrix to points matrix
transform_matrix <- function(transformation_matrix, points_matrix) {
    if (class(transformation_matrix) == "matrix") {
        tr_matrix <- transformation_matrix
    } else {
        tr_matrix <- matrix(transformation_matrix, nrow = 2, byrow = T)
    }
    if (is.null(points_matrix)) {
        point_matrix <- diag(2)
    }
    point_matrix_transformed <- t(tr_matrix %*% t(points_matrix))
    return(point_matrix_transformed)
}


name_columns <- function(point_matrix, point_matrix_transformed, shape_matrix, shape_matrix_transformed) {
    colnames(shape_matrix_transformed) <- c("x", "y")
    colnames(shape_matrix) <- c("x_locs", "y_locs")
    
    colnames(point_matrix_transformed) <- c("x_end", "y_end")
    colnames(point_matrix) <- c("x_start", "y_start")
    
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
        xlab("") + ylab("")
    
    return(plotti)
}