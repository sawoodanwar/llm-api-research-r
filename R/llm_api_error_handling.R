# LLM API error handling helpers

#' Safely call an LLM API with retry and logging
#'
#' @param prompt Character prompt.
#' @param model Model name.
#' @param max_retries Maximum number of retries.
#' @param log_file Path to a CSV log file in logs/.
#' @return List with response or NA on failure.
llm_call_safe <- function(prompt,
                          model = "gpt-4.1-mini",
                          max_retries = 3,
                          log_file = "logs/llm_api_errors.csv") {
  attempt <- 1
  while (attempt <= max_retries) {
    try <- try(llm_call(prompt, model = model), silent = TRUE)
    if (!inherits(try, "try-error")) {
      return(try)
    }

    message(sprintf("Attempt %d failed: %s", attempt, as.character(try)))
    log_error(prompt, model, attempt, try, log_file)

    # simple exponential backoff
    Sys.sleep(2 ^ attempt)
    attempt <- attempt + 1
  }

  warning("All attempts to call LLM API failed.")
  return(NA)
}

#' Log an error to a CSV file
#'
#' @param prompt Prompt used.
#' @param model Model name.
#' @param attempt Attempt number.
#' @param error Error object.
#' @param log_file Path to CSV log file.
log_error <- function(prompt, model, attempt, error, log_file) {
  dir.create(dirname(log_file), showWarnings = FALSE, recursive = TRUE)
  entry <- data.frame(
    timestamp = Sys.time(),
    prompt = prompt,
    model = model,
    attempt = attempt,
    error = as.character(error),
    stringsAsFactors = FALSE
  )

  if (file.exists(log_file)) {
    utils::write.table(entry, file = log_file, sep = ",", col.names = FALSE,
                        row.names = FALSE, append = TRUE)
  } else {
    utils::write.table(entry, file = log_file, sep = ",", col.names = TRUE,
                        row.names = FALSE, append = FALSE)
  }
}
