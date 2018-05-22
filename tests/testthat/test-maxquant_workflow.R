context("maxquant_workflow")

test_that("Vignette example works", {
  expect_equal({
      # 1. First, get protein ID information
      
      proteinGroups <- read.table(
          system.file(
              "extdata/DDA_ControlledMixture2014", 
              "proteinGroups.txt", 
              package = "MSstatsmaterial"), 
          sep = "\t",
          header = TRUE)
      
      # 2. Read in annotation including condition and biological replicates: annotation.csv
      annot <- read.csv(
          system.file(
              "extdata/DDA_ControlledMixture2014", 
              "annotation.csv", 
              package = "MSstatsmaterial"), 
          header=TRUE)
      
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
