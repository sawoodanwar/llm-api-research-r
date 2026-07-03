# Batch LLM requests over a data frame

#' Apply an LLM call across rows of a data frame
#'
#' @param df Data frame.
#' @param text_col Name of the text column.
#' @param model Model name.
#' @return Data frame with an added column `llm_output`.
llm_batch_call <- function(df,
                           text_col = "post_text",
                           model = "gpt-4.1-mini") {
  if (!text_col %in% names(df)) {
    stop(sprintf("Column '%s' not found in data frame.", text_col))
  }

  df$llm_output <- NA_character_

  for (i in seq_len(nrow(df))) {
    txt <- df[[text_col]][i]
    res <- llm_call_safe(txt, model = model)
    df$llm_output[i] <- if (is.list(res)) llm_extract_text(res) else NA_character_
  }

  df
}
