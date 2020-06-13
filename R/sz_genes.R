sz_genes <- function() {
  use_package("httr")
  use_package("readxl")
  use_package("stringr")
  use_package("dplyr")

  url <- "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5918692/bin/NIHMS958804-supplement-Supplementary_Table.xlsx"
  httr::GET(url, httr::write_disk(temp_file <- tempfile(fileext = ".xlsx"))) # downloads the .xlsx file
  df <- readxl::read_excel(temp_file, sheet = 4, skip = 3) # reads into a dataframe. First six rows of the excel file are just header
  unlink(temp_file)     # deletes the temporary file


  ##################################################################
  # makes sz_genes, a dataframe with a single column of the CLOZUK genes
  #######################################################################

  all_sz_genes <- df$`Gene(s) tagged` %>%
    stringr::str_split(",") %>%
    unlist() %>%
    as.data.frame() %>%
    dplyr::distinct()
  names(all_sz_genes) <- "genes"
  all_sz_genes
}
