get_circle <- function(how_many) {
    jono <- seq(0,(2*pi)*(how_many -1)/how_many , length = how_many)
    
    x_locs <- sapply(jono, sin)
    y_locs <- sapply(jono, cos)
    
    zapsmall(cbind(x_locs, y_locs))
    
    return(cbind(x_locs, y_locs))
}

