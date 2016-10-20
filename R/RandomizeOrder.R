#' Randomize order of your participant
#'
#' @param Data
#'
#' @return A randomly ordered experimental plan.
#' @export
#' @import dplyr
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition) %>%
#'  RandomizeOrder()


RandomizeOrder <-
  function(Data) {

    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("dplyr needed for this function to work. Please install it.",
           call. = FALSE)
    }

    # Randomly arrange rows

    Data %>%
      mutate(Rand = runif(n())) %>%
      arrange(Rand) %>%
      select(-Rand)
  }
