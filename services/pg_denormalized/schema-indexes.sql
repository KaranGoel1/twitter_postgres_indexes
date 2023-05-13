CREATE INDEX ON tweets_jsonb USING GIN((data -> 'entities' -> 'hashtags'))

CREATE INDEX ON tweets_jsonb USING GIN((data -> 'extended_tweet' -> 'entities' -> 'hashtags'))

CREATE INDEX ON tweets_jsonb USING BTREE((data ->> 'id'));

CREATE INDEX ON tweets_jsonb USING GIN(to_tsvector(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'));
