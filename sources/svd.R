# grid size from -size, size
#circle_precision <- 100

# create unit circle
#circle <- get_circle(circle_precision)

#toplot <- create_plot(matrix_values, circle_matrix)

#matrix_values <- c(4,2,3,1)

#tr_matrix <- matrix(matrix_values, nrow = 2, byrow = T)

# tr_matrix <- matrix(c(1,0,0,0,2,
#                       0,0,3,0,0,
#                       0,0,0,0,0,
#                       0,4,0,0,0), nrow = 4, byrow = T)
# 
# svd_tr <- svd(tr_matrix)
# 
# circle <- get_circle(200)
# square <- get_square(200)
# 
# plot(transform_and_create_plot(svd_tr$u, circle))
# plot(transform_and_create_plot(svd_tr$v, circle))
# plot(transform_and_create_plot(diag(svd_tr$d), circle))
# 
# plot(transform_and_create_plot(matrix_values, circle))
# 
# svd_tr$u %*% diag(svd_tr$d) %*% t(svd_tr$v)
# 
# first2 <- diag(svd_tr$d) %*% t(svd_tr$v)
# 
# plot(transform_and_create_plot(first2, circle))
# 
# testi <- transform_matrixes(matrix_values, circle)

perform_svd <- function(tr_matrix, svd_level) {
    if (svd_level == 0) {
        return(tr_matrix)
    }
    svd_tr <- svd(tr_matrix)
    
    if (svd_level == 1) {
        return(t(svd_tr$v))
    }
    
    if (svd_level ==2) {
        first_2_matrix <- diag(svd_tr$d) %*% t(svd_tr$v)
        return(first_2_matrix)
    }
}