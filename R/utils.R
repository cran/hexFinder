#' Checks if a given url is valid and available.
#'
#' @param url The resource url to check.
#' @param status_ok The list of valid header statuses.
#'
#' @importFrom httr2 request req_perform req_method
#'
#' @keywords utils internal
#' @return The result of evaluating the expression or NULL in case of error.
url_file_exists <- function(url, status_ok = 200) {
  request <- request(url) |>
    req_method("HEAD") |>
    req_perform() |>
    catch()

  if (is.null(request)) {
    return(FALSE)
  }

  status_ok == request$status_code #nocov
}

#' Returns gitub repo links based on given URLs
#'
#' @param ... Any links we would like to parse to find a github URL from.
#'
#' @importFrom purrr keep map
#' @importFrom stringr str_split str_replace
#'
#' @keywords utils internal
#' @return A list of possible github repos
clean_repo_links <- function(...) {
  c(...) |>
    map(\(arg) {
      arg |>
        str_split(",") |>
        unlist()
    }) |>
    unlist() |>
    keep(\(url) {
      grepl("github.com", url)
    }) |>
    map(\(url) {
      url |>
        str_replace("/issues", "") |>
        (\(.) gsub("/$", "", .))() |>
        (\(.) gsub(" ", "", .))() |>
        (\(.) gsub("\n", "", .))()
    }) |>
    unlist() |>
    unique()
}

#' Logs a given message.
#'
#' @param ... The message to log.
#'
#' @keywords utils internal
#' @return No return, called for side effects.
log <- function(...) {
  do.call(cat, list(...))
  cat("\n")
}

#' Catches errors from a given expression. Can be used in a pipe.
#'
#' @param ... The expression to safely evaluate.
#'
#' @keywords utils internal
#' @return The result of evaluating the expression or NULL in case of error.
catch <- function(...) {
  tryCatch(..., error = \(error) NULL)
}
