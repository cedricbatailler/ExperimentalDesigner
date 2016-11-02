#' Test if the object is an ExperimentalPlan.
#' 
#' @param x An object
#' @return \code{TRUE} if the object inherits from the \code{ExperimentalPlan} class.
#' @export

is.ExperimentalPlan <-
  function(x) {
    inherits(x, "ExperimentalPlan")
  }