/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT '#' || tag as tag , count(*) as count
    FROM (
        SELECT DISTINCT
            data->>'id' AS id_tweets,
            jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            )->>'text'::TEXT as tag
	from tweets_jsonb
        where (data->'entities'->'hashtags') @@'$[*].text == "coronavirus"'or
        (data->'extended_tweet'->'entities'->'hashtags')@@'$[*].text == "coronavirus"'
) t
group by tag
order by count desc, tag
limit 1000;

