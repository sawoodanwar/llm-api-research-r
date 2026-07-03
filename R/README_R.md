# LLM API Client Utilities in R

This directory contains R scripts for integrating with LLM APIs using robust patterns for configuration, requests, and error handling.

## Files

- `llm_api_client.R`: Core client functions for issuing requests to LLM APIs.
- `llm_api_error_handling.R`: Extra utilities for error handling, logging, and retries.
- `llm_batch_requests.R`: Helpers for batched requests over data frames.

## llm_api_client.R

This script is responsible for:

- Reading API keys from environment variables (e.g., `OPENAI_API_KEY`).
- Constructing JSON payloads for chat/completion endpoints.
- Handling HTTP responses and returning structured R objects (e.g., lists, tibbles).

Key patterns include:

- Using `httr::POST()` or `httr2` with proper headers and timeouts.
- Encapsulating base URL and model names in configurable options.

## llm_api_error_handling.R

This script focuses on error resilience:

- Wrapping API calls in `tryCatch()` blocks.
- Detecting rate-limit or network errors and retrying with exponential backoff.
- Logging errors to `logs/` as CSV or JSON with timestamps and input metadata.

It is designed to be reusable across projects and can be extended with custom logging backends.

## llm_batch_requests.R

This script provides helpers for applying a client function across rows of a data frame:

- Safely iterating over text fields (e.g., `post_text`).
- Collecting outputs and errors in a unified tibble.
- Allowing for chunked or parallel execution strategies.

## Usage

Source the scripts in your analysis code, for example:

```r
source("R/llm_api_client.R")
source("R/llm_api_error_handling.R")
source("R/llm_batch_requests.R")
```

Then call functions like `llm_call()` or `llm_batch_call()` as defined in your implementation.
