#' Initialize an experimental design object
#'
#' @param n Number of participant you want in your experiment.
#'
#' @return Returns an experimental design as form of a data frame.
#' @export
#'
#' @examples InitExperimentalPlan(80)

InitExperimentalPlan <-
  function(n) {
    ExpPlan <- 
      list(
        N = n,
        Factors = as.character(),
        Plan = data.frame(Participant = seq(1, n))
      )
    class(ExpPlan) <- "ExperimentalPlan"
    
    ExpPlan
  }
