#' Reassign participant number
#'
#' @param Data
#'
#' @return An experimental plan object with participant number corresponding to row number.
#'
#' @import dplyr
#'
#' @export
#'
#' @examples
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition) %>%
#'  RandomizeOrder() %>%
#'  Reassign Participant Number

ReassignParticipantNumber <-
  function(Data) {
    # Reassign participant number so it is row number.

    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("dplyr needed for this function to work. Please install it.",
           call. = FALSE)
    }

    Data %>%
      mutate(Participant = row_number())
  }
