ABA_wide <- function(data, genes = "SZ", stage = 5) {
  use_package("dplyr")
  use_package("tidyr")
  use_package("tibble")

  dataset_5_stages <- data

  genes <- ifelse(genes == "SZ",
                  TUD4SZ::sz_genes()$genes %>% trimws(),
                  genes)
  data("dataset_5_stages")
  dataset_5_stages %>%
    dplyr::filter(hgnc_symbol %in% genes) %>%
    dplyr::filter(age_category == stage) %>%
    dplyr::select(-c(entrezgene, ensembl_gene_id, age_category)) %>%
    tidyr::pivot_wider(names_from = structure, values_from = signal) %>%
    tibble::column_to_rownames(var = "hgnc_symbol")%>%
    t() %>%
    scale() %>%
    t()
}
