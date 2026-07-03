# LLM API client helpers

#' Call an LLM API with a simple prompt
#'
#' @param prompt Character string containing the user prompt.
#' @param model Character name of the model (e.g., "gpt-4.1-mini").
#' @param temperature Numeric temperature parameter.
#' @return A list with response content and metadata.
llm_call <- function(prompt,
                     model = "gpt-4.1-mini",
                     temperature = 0.7) {
  api_key <- Sys.getenv("OPENAI_API_KEY")
  if (api_key == "") {
    stop("OPENAI_API_KEY is not set in environment variables.")
  }

  url <- "https://api.openai.com/v1/chat/completions"

  body <- list(
    model = model,
    messages = list(list(role = "user", content = prompt)),
    temperature = temperature
  )

  res <- httr::POST(
    url,
    httr::add_headers(Authorization = paste("Bearer", api_key)),
    httr::content_type_json(),
    body = jsonlite::toJSON(body, auto_unbox = TRUE)
  )

  httr::stop_for_status(res)
  out <- httr::content(res, as = "parsed", type = "application/json")
  return(out)
}

#' Extract text content from a chat completion response
#'
#' @param response List returned by llm_call().
#' @return Character string of the first choice content.
llm_extract_text <- function(response) {
  tryCatch(
    {
      response$choices[[1]]$message$content
    },
    error = function(e) {
      warning("Failed to extract text from response: ", conditionMessage(e))
      NA_character_
    }
  )
}
