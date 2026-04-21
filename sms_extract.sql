SELECT name FROM sqlite_master WHERE type='table';

SELECT
    datetime(date/1000000000 + 978307200, 'unixepoch', 'localtime') as date,
    is_from_me as SentMessage,
    text as Content
FROM message
ORDER BY date DESC
LIMIT 20;

SELECT
    handle_id,
    COUNT(*) as numofmessage,
    SUM(CASE WHEN is_from_me = 0 THEN 1 ELSE 0 END) as recievedmsg,
    SUM(CASE WHEN is_from_me = 1 THEN 1 ELSE 0 END) as sentmsg
FROM message
GROUP BY handle_id
ORDER BY numofmessage DESC;
