#' Saves experimental plan as a file.
#'
#' @param object An experimental plan object.
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
#'  SaveExperimentalPlan("myplan.xlsx")

SaveExperimentalPlan <-
  function(object, name, type = "xlsx", path = NA) {

    if (!is.ExperimentalPlan(object)) {
      stop("object is not an Experimental plan.",
           call. = FALSE)
    }

    data <- object$Plan

    filename <-
      ifelse(is.na(path),
             name,
             paste0(path, name))

    if(type == "xlsx")
    {
      if (!requireNamespace("xlsx", quietly = TRUE))
      {
        stop("xlsx package is needed when saving experimental plan as xlsx.",
             call. = FALSE)
      }

      xlsx::write.xlsx(x = data,
                       file = filename,
                       sheetName = "Experimental Plan",
                       row.names = FALSE)

    }
    if(type == "eprime") {

      write(c("' README",
              "",
              "",
              "' This text should be pasted in an e-prime inline",
              "' at the begining of your script.",
              "'",
              "' Please remember that this function is still somehow ",
              "' experimental for now.",
              "'",
              "' For this inline to get desired effect, first element of",
              "' your script must be this inline and second should be a",
              "' list named \"Experiment\". This list must contains one row",
              "' with Attributes named after your factor names.",
              "",
              "' INITIATING VARIABLES",
              "",
              ""),
            filename)

      for(j in 2:ncol(data)) {
        write(c(paste0("Dim ", colnames(data)[j], " As String ")
        ),
        filename,
        append = TRUE)
      }

      write(c("",
              "Dim ParticipantNumber As Double",
              "",
              "' GETTING PARTICIPANT NUMBER",
              "",
              "",
              "ParticipantNumber = C.GetAttrib(\"Subject\")",
              "",
              "' ASSIGNING CONDITIONS FOR PARTICIPANT",
              "",
              "",
              "Select Case ParticipantNumber"),
            filename,
            append = TRUE)


      for(i in 1:nrow(data))
      {
        Temp <-
          data %>%
          filter(row_number() == i)

        write(c("",
                paste0("    Case ", Temp$Participant)
        ), filename, append = TRUE)

        for(j in 2:ncol(Temp)) {
          write(c(paste0("        ", colnames(Temp)[j], " = \"", Temp[1,j], "\"")
          ), filename, append = TRUE)
        }
      }
      write(c("    Case Else",
              "",
              "        msgBox(\"No condition specified for this participant\")",
              "",
              "End Select",
              "",
              "' ASSIGNING CONDITION VALUES",
              ""),
            filename,
            append = TRUE)

      ValueTemp <- "Experiment.SetAttrib 1"

      for(j in 2:ncol(data)) {
        ValueTemp <- paste0(ValueTemp,
                            ", ", colnames(data)[j])
      }

      write(c("",
              ValueTemp),
            filename,
            append = TRUE)
    }
  }
