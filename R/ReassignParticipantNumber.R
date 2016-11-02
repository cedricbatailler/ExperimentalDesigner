#' Reassign participant number.
#' 
#' @param object An experimental plan object.
#' @return An experimental plan object with participant number corresponding to row number.
#' @import dplyr
#' @export
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'   
#' InitExperimentalPlan(80) %>%
#'   AddFactor(Condition) %>%
#'   RandomizeOrder() %>%
#'   ReassignParticipantNumber()

ReassignParticipantNumber <-
  function(object) {
    # Reassign participant number so it is row number.
    
    if (!is.ExperimentalPlan(object)) {
      stop("Object is not an Experimental plan.",
           call. = FALSE)
    }
    
    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("dplyr needed for this function to work. Please install it.",
           call. = FALSE)
    }
    
    newExperimentalPlan <- 
      object
    
    Plan <-
      object$Plan %>%
      mutate(Participant = row_number())
    
    newExperimentalPlan$Plan <- Plan
    
    return(newExperimentalPlan)
  }
