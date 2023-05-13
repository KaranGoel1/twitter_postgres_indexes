SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
    id_tweets, '#' || (jsonb ->> 'text' ::TEXT) as tag
    FROM (
    SELECT
    id_tweets,
    jsonb_array_elements(tags) as jsonb
    FROM(
    SELECT DISTINCT
        data ->> 'id' as id_tweets,
        COALESCE(data->'extended_tweet' -> 'entities'->'hashtags', data->'entities'->'hashtags','[]') as tags
    FROM tweets_jsonb
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english','coronavirus')
      AND data ->> 'lang' ='en'
)AS t1) as t2) t
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000
;
