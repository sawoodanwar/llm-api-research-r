# Data README for LLM API Research with R

This directory contains notes and example schemas for CSV-based datasets used in LLM API integration workflows.

## Expected Data Formats

Typical CSV inputs include columns such as:

- `post_id`: Unique identifier for each post or document.
- `page_name`: Name of the news outlet, page, or source.
- `post_text`: Main textual content (status, headline, or article excerpt).
- `created_at`: Timestamp of publication in ISO format.
- `reaction_like`, `reaction_love`, `reaction_care`, `reaction_haha`, `reaction_wow`, `reaction_sad`, `reaction_angry`: Counts of Facebook reactions or analogous engagement metrics.

You can adapt these schemas to other platforms (Twitter/X, YouTube, etc.) by replacing reaction fields with relevant engagement indicators.

## Privacy and Ethics

- Remove direct identifiers (names, user IDs) when possible.
- Aggregate or sample data according to institutional ethics/IRB requirements.
- Respect platform terms of service when collecting and storing data.

## Example Files

- `example_posts.csv`: Small synthetic dataset illustrating required columns (not real user data).

## Related Repositories

- LLM-based text analysis workflows: [llm-text-analysis-r](https://github.com/sawoodanwar/llm-text-analysis-r)
