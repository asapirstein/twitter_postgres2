/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */
select lang as lang , count(*) as count
from (
	select distinct  
	data->>'id' as id_tweets,
	data->>'lang' as lang
	from tweets_jsonb
	where (data->'entities'->'hashtags') @@'$[*].text == "coronavirus"'or
        (data->'extended_tweet'->'entities'->'hashtags')@@'$[*].text == "coronavirus"'
) t
group by lang
order by count desc, lang; 
