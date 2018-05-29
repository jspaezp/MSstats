context("maxquant_workflow")

if (!requireNamespace("MSstatsmaterial")) {
    try({
        devtools::install_git("https://github.rcac.purdue.edu/jpaezpae/MSstatsmaterial")
    })
}

test_that("Vignette example works", {
  expect_equal({
      skip_if_not_installed("MSstatsmaterial")
      # 1. First, get protein ID information
      
      proteinGroups <- data.table::fread(
          system.file(
              "extdata/DDA_ControlledMixture2014", 
              "proteinGroups.txt", 
              package = "MSstatsmaterial"), 
          sep = "\t",
          header = TRUE)
      data.table::setnames(
          proteinGroups,
          colnames(proteinGroups),
          make.names(colnames(proteinGroups), unique = TRUE))
      
      # 2. Read in annotation including condition and biological replicates: annotation.csv
      annot <- as.data.frame(data.table::fread(
          system.file(
              "extdata/DDA_ControlledMixture2014", 
              "annotation.csv", 
              package = "MSstatsmaterial"), 
          header=TRUE))
      
      # however, evidence.RData is available in MSstats material github due to limit of file size
      load(
          system.file(
              "extdata/DDA_ControlledMixture2014", 
              "evidence.RData", 
              package = "MSstatsmaterial"))
      
      
      # reformat for MSstats required input
      # check options for converting format
      
      msstats.raw <- MaxQtoMSstatsFormat(
          evidence = evidence, 
          annotation = annot, 
          proteinGroups = proteinGroups)
      msstats.raw
      dim(msstats.raw)
  }, expected = c(264160,10))
})
