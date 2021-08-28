pdfize <- function(dir) {
  source <- here::here(fs::path(dir, "index.html"))

  folders <- strsplit(dir, "/")[[1]]
  output <- here::here(fs::path(dir, folders[length(folders)], ext = "pdf"))

  pagedown::chrome_print(
    input = source,
    output = output,
    options = list(printBackground = TRUE),
    wait = 10,
    timeout = 600
  )
}
