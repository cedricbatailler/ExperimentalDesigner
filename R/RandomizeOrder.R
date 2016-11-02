#' Randomize order of your participant
#'
#' @param object An experimental plan object.
#'
#' @return A randomly ordered experimental plan.
#' @export
#' @import dplyr
#' @importFrom stats runif
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition) %>%
#'  RandomizeOrder()


RandomizeOrder <-
  function(object) {

    if (!is.ExperimentalPlan(object)) {
      stop("Object is not an Experimental plan.",
           call. = FALSE)
    }
    
    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("dplyr needed for this function to work. Please install it.",
           call. = FALSE)
    }
    
     # Randomly arrange rows

    object$Plan  <-
      object$Plan %>%
      mutate(Rand = runif(n())) %>%
      arrange(Rand) %>%
      select(-Rand) 
    
    return(object)
  }
