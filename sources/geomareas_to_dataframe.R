get_circle <- function(how_many) {
    jono <- seq(0,(2*pi)*(how_many -1)/how_many , length = how_many)
    
    x_locs <- sapply(jono, sin)
    y_locs <- sapply(jono, cos)
    
    return(cbind(x_locs, y_locs))
}

get_square <- function(how_many) {
    how_many <- how_many %% 4 + how_many # pad how many to be multiple of 4
    zeroes <- rep(0, how_many/4)
    ones <- rep(1, how_many/4)
    between <- seq(0, 1, length = how_many/4)
    
    x_locs <- c(zeroes, between, ones, 1 - between)
    y_locs <- c(between, ones, 1 - between, zeroes)
    
    return(cbind(x_locs, y_locs))
}
