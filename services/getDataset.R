getDataset <- function() {
    all_frames <- list()

    files_csv <- list.files(path="dataset/", pattern="\\.csv$", full.names=TRUE)

    for(csv_file in files_csv) {
        df <- read.csv(csv_file)

        filename = tools::file_path_sans_ext(basename(csv_file))

        all_frames[[filename]] <- df
    }

    return(all_frames)
}