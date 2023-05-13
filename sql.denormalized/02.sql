SELECT
    tag,
    count(*) as count
FROM (
    SELECT DISTINCT
    id_tweets, '#' || (jsonb ->> 'text' ::TEXT) as tag
    FROM
    (
    SELECT 
    id_tweets,
    jsonb_array_elements(
            tags
            ) AS jsonb
    FROM(
    SELECT DISTINCT
    data ->> 'id' as id_tweets,
    COALESCE(data->'extended_tweet' -> 'entities'->'hashtags', data->'entities'->'hashtags','[]') as tags
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    OR data-> 'extended_tweet' -> 'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) as t2)AS t1) as t
GROUP BY (1)
ORDER BY count DESC, tag
LIMIT 1000;
