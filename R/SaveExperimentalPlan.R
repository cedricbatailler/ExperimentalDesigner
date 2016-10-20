#' Saves experimental plan as a file.
#'
#' @param data An experimental plan object.
#' @param name What should the created file be named.
#' @param type What kind of file should be created (csv, xlsx, or e-prime inline).
#' @param path (Optional) A path to where the created file should be saved.
#'
#' @importFrom xlsx write.xlsx
#'
#' @export
#'
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition) %>%
#'  RandomizeOrder() %>%
#'  SavecExperimentalPlan("myplan.xlsx")

SaveExperimentalPlan <-
  function(data, name, type = "xlsx", path = NA) {

    # For xlsx export

    filename <-
      ifelse(is.na(path),
             name,
             paste0(path, name))

    if(type == "xlsx") {

      if (!requireNamespace("xlsx", quietly = TRUE)) {
        stop("xlsx package is needed when saving experimental plan as xlsx.",
             call. = FALSE)
      }

      xlsx::write.xlsx(x = data,
                       file = filename,
                       sheetName = "Experimental Plan",
                       row.names = FALSE)

    }
  }
