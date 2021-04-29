/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT '#' || tag  AS tag, count(*) as count 
    FROM (
        SELECT DISTINCT
            data->>'id' AS id_tweets,
            jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            )->>'text'::TEXT as tag
	FROM tweets_jsonb
	WHERE to_tsvector('english', 
	COALESCE(data->'extended_tweet'->>'full_text', data ->>'text'))@@to_tsquery('english','coronavirus')
    and data->>'lang'='en'
) t
group by tag
order by count desc, tag
limit 1000;
