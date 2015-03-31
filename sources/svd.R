perform_svd <- function(tr_matrix, svd_level) {
    svd_tr <- svd(tr_matrix)
    
    if (svd_level == 0) {
        return(NULL)
    } else if (svd_level == 1) {
        return(t(svd_tr$v))
    } else if (svd_level == 2) {
        first_2_matrix <- diag(svd_tr$d) %*% t(svd_tr$v)
        return(first_2_matrix)
    } else if (svd_level == 3) {
        return(tr_matrix)
    }
    
}