#' Path to the quarto binary
#'
#' Determine the path to the quarto binary. Uses `QUARTO_PATH` environment
#' variable if defined, otherwise uses `Sys.which()`.
#'
#' @return Path to quarto binary (or `NULL` if not found)
#'
#' @export
quarto_path <- function() {
  path_env <- Sys.getenv("QUARTO_PATH", unset = NA)
  if (!is.na(path_env)) {
    return(path_env)
  }
  # Fallback: check well-known locations if no QUARTO_PATH set.
  locations <- c(
    # Location on PATH
    "quarto",

    # A location used by some installers
    "/usr/local/bin/quarto",

    # A location used by some installers
    "/opt/quarto/bin/quarto",

    # The IDE's embedded Quarto on macOS
    "/Applications/RStudio.app/Contents/MacOS/quarto/bin/quarto"
  )
  for (location in locations) {
    path <- unname(Sys.which(location))
    if (nzchar(path)) {
      return(path)
    }
  }
  return(NULL)
}

find_quarto <- function() {
  path <- quarto_path()
  if (is.null(path)) {
    stop("Unable to find quarto command line tools.")
  } else {
    path
  }
}
