CREATE INDEX on tweet_tags using(tag)
CREATE INDEX on tweet_tags using(tag, id_tweets)
/*three*/
CREATE INDEX on tweets using(id_tweets,lang);
/* Four and five */
CREATE INDEX tweets_idx_ft ON tweets USING gin(to_tsvector('english', text)) where lang ='en';

