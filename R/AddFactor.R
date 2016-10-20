#' Adds a factor to an experimental plan object
#'
#' @param Data An experimental plan object.
#' @param Factor Factor you wish to add to you experimental plan.
#' Factor must be specified as a vector object (see examples section).
#'
#' @return An experimental plan object.
#' @export
#'
#' @import dplyr
#'
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition)

AddFactor <-
  function(Data, Factor) {

    # Getting the name of the factor
    ConditionName <-
      deparse(substitute(Factor))

    # Getting the number of condition in factor
    NumberOfCondition <-
      length(Factor)

    # Create a variable which will be used to assign participants
    # to their condition. Variable will be name Temp to bypass standard eval
    # problems which would made rename levels uneasy.

    Data <-
      Data %>%
      mutate(Temp = row_number() %% NumberOfCondition %>%
               as.factor()) %>%
      arrange(Temp)

    # Renaming levels

    levels(Data$Temp) <-
      Factor

    # Using standard evaluation to rename

    Data %>%
      rename_(.dots = setNames("Temp", ConditionName))
  }
