getMode <- function(v) {
    uniqv <- unique(v)
    x <- uniqv[which.max(tabulate(match(v, uniqv)))]

    print(x)
    return(x)
}