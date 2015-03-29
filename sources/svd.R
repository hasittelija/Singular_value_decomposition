# grid size from -size, size
#circle_precision <- 100

# create unit circle
#circle <- get_circle(circle_precision)

#toplot <- create_plot(matrix_values, circle_matrix)

matrix_values <- c(4,2,3,1)

tr_matrix <- matrix(matrix_values, nrow = 2, byrow = T)

svd_tr <- svd(tr_matrix)

circle <- get_circle(200)
square <- get_square(200)

keijo <- create_plot(svd_tr$u, circle)
keijo <- create_plot(svd_tr$v, square)

plot(create_plot(matrix_values, circle))

