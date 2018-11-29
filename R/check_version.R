#' Compare package versions
#'
#' Look for packages installed with [devtools::dev_mode()](devtools::dev_mode) and compare them
#' with packages installed in the system (using `.libPaths`)
#'
#' If any similar packages are found, a warning is issued.
#'
#' @export
#'
check_version <- function() {
  original_lib_path <- .libPaths()

  suppressMessages(devtools::dev_mode(on = TRUE))
  lib_path_dev <- .libPaths()[1]
  lib_path_sys <- .libPaths()[2]

  if (!identical(.libPaths(), original_lib_path)) {
    suppressMessages(devtools::dev_mode(on = FALSE))
  }

  lib_dev <- list.files(lib_path_dev)
  lib_sys <- list.files(lib_path_sys)

  lib_common <- intersect(lib_dev, lib_sys)

  purrr::map_dfr(lib_common, function(lib) {
    tibble::tibble(
      library  = lib,
      dev_mode = as.character(desc::desc_get_version(file.path(lib_path_dev, lib, "DESCRIPTION"))),
      system   = as.character(desc::desc_get_version(file.path(lib_path_sys, lib, "DESCRIPTION"))),
      compare  = compareVersion(dev_mode, system)
    )

  })
}