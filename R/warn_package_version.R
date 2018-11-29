#' Warn Package Version
#'
#' This function warn the user if some package have different versions installed on the system and in dev_mode
#'
#' @param level level of warning. If `level = 0`, only packages with a version lower than the one installed on the system is issued.
#'                                If `level = 1`, only packages with a version lower or equal than the one installed on the system is issued
#'                                If `level = 2`, all common packages are issued
#'
#' @importFrom rlang !!
#' @importFrom magrittr %>%
#'
#' @export
#'
warn_package_version <- function(level = 2) {
  lib_version       <- check_version()
  core_msg          <- function(n) glue::glue("{n} packages are installed both in the system and in dev_mode()")
  count_lib_version <- lib_version %>%
    dplyr::count(!!rlang::sym("compare")) %>%
    dplyr::arrange(!!rlang::sym("compare")) %>%
    dplyr::mutate_at("n", cumsum) %>%
    dplyr::mutate(msg = paste(core_msg(!!rlang::sym("n")), dplyr::case_when(
      compare == -1 ~  "with a version lower in dev_mode()",
      compare == 0  ~ "with a version lower or equal in dev_mode()",
      compare == 1  ~ "with a version higher in dev_mode()"
    ))) %>%
    dplyr::filter(compare <= (level + 1))
  purrr::walk(count_lib_version[["msg"]], warning, call. = FALSE)
}