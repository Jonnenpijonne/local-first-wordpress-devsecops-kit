# Data Classification Template

| Table / Field | Classification | Development Handling | Notes |
| --- | --- | --- | --- |
| wp_users.user_email | Personal data | Replace with generated address | Stable pseudonym preferred |
| wp_users.user_login | Personal data | Replace with generated login | Keep referential consistency |
| wp_usermeta.meta_value | Personal data / mixed | Review and scrub | May contain contact details or metadata |
| wp_options.option_value | Configuration risk | Remove or replace | API keys, tokens, licenses |
| wp_posts.post_content | Mixed content risk | Scan and anonymize | Free text may contain personal data |
| wp_comments.comment_author_email | Personal data | Replace |  |
| wp_comments.comment_author_IP | Personal data | Truncate or replace |  |
| wp-content/uploads | High-risk files | Do not copy by default | May contain PDFs, images or metadata |
