# LLM API Research with R

This repository collects R-focused workflows, utilities, and examples for integrating Large Language Model (LLM) APIs (e.g., OpenAI, Anthropic, etc.) into computational social science and media/communication research.

## Goals

- Provide reusable R scripts for calling LLM APIs with robust error handling and logging.
- Demonstrate end-to-end pipelines for social media and text data (CSV-based) using tidyverse and httr/httr2.
- Facilitate reproducible research for topic modeling, sentiment, and annotation workflows that rely on LLMs.
- Connect to related repositories in the Sawood Anwar GitHub profile for thesis-related and NLP projects.

## Repository Structure

- `R/`
  - `llm_api_client.R`: Core wrapper functions for making LLM API calls from R (POST requests, JSON handling).
  - `llm_api_error_handling.R`: Extra utilities for retries, rate-limit backoff, and structured error logging.
  - `llm_batch_requests.R`: Helpers for batched calls over data frames (e.g., news posts, comments).
- `data/`
  - `README_data.md`: Notes on expected data formats (CSV), privacy/anonymization, and example schemas.
  - `example_posts.csv`: Small synthetic dataset of COVID-19 news posts and reaction counts for quick testing.
- `examples/`
  - `covid_news_reactions_llm_api.R`: Example pipeline inspired by PhD thesis data (Facebook reactions & COVID-19 news).
  - `simple_prompting_demo.R`: Minimal reproducible example for first-time LLM API integration in R.
- `logs/`
  - Directory for storing API error logs (e.g., `.csv` or `.json`) and run metadata.

## Data Notes

This repository assumes input data is in CSV format with columns such as `post_id`, `page_name`, `post_text`, `created_at`, and reaction counts. Data should be **anonymized and compliant** with platform terms and institutional ethics requirements.

See `data/README_data.md` for details.

## Cross-links to Related Repositories

- LLM text analysis workflows in R: [llm-text-analysis-r](https://github.com/sawoodanwar/llm-text-analysis-r)
- BERTopic topic modeling workflows: [bertopic-media-topics](https://github.com/sawoodanwar/bertopic-media-topics)
- Profile and other research repositories: [GitHub profile](https://github.com/sawoodanwar)

Together with `llm-text-analysis-r` and `bertopic-media-topics`, this repository is part of a small computational communication toolkit for LLMs and topic modeling.

## Example Usage

A minimal example of running batched LLM calls over the synthetic COVID-19 news posts:

```r
library(readr)
source("R/llm_api_client.R")
source("R/llm_api_error_handling.R")
source("R/llm_batch_requests.R")

posts <- read_csv("data/example_posts.csv")
results <- llm_batch_call(posts, text_col = "text", model = "gpt-4.1-mini")
head(results$llm_output)
```

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/sawoodanwar/llm-api-research-r.git
   ```
2. Install R packages:
   - `tidyverse`
   - `httr` or `httr2`
   - `jsonlite`
   - `readr`

3. Configure your API key(s):
   - Store them in `.Renviron` or environment variables (e.g., `OPENAI_API_KEY`).
   - **Never commit secrets to the repository.**

4. Run an example script, e.g.:
   ```r
   source("R/simple_prompting_demo.R")
   ```

## License

This repository is licensed under the MIT License. See `LICENSE` for details.
