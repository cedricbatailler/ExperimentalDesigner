#' Adds a factor to an experimental plan object
#'
#' @param object An experimental plan object.
#' @param factor Factor you wish to add to you experimental plan.
#' Factor must be specified as a vector object (see examples section).
#'
#' @return An experimental plan object.
#' @export
#'
#' @import dplyr
#' @importFrom stats setNames
#'
#' @examples
#' Condition <-
#'   c("Eperimental", "Control")
#'
#' InitExperimentalPlan(80) %>%
#'  AddFactor(Condition)
AddFactor <-
  function(object, factor) {
    
    # TESTS
    
    # Object must be an experimental plan
    if (!is.ExperimentalPlan(object)) {
      stop("Object is not an Experimental plan.",
           call. = FALSE)
    }
    
    # dplyr must be installed
    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("dplyr needed for this function to work. Please install it.",
           call. = FALSE)
    }
    
    # FUNCTION
    
    # Getting the name of the factor
    ConditionName <-
      deparse(substitute(factor))
    
    # Getting the number of condition in factor
    NumberOfCondition <-
      length(factor)
    
    # Create a variable which will be used to assign participants
    # to their condition. Variable will be name Temp to bypass standard eval
    # problems which would made rename levels uneasy.
    
    Plan <-
      object$Plan %>%
      mutate(Temp = row_number() %% NumberOfCondition %>%
               as.factor()) %>%
      arrange(Temp)
    
    # Renaming levels
    
    levels(Plan$Temp) <-
      factor
    
    # Using standard evaluation to rename
    
    Plan <- 
      Plan %>%
      rename_(.dots = setNames("Temp", ConditionName))
    
    
    object$Factors <- append(object$Factors,
                             ConditionName)
    object$Plan <- Plan
    
    return(object)
  }
