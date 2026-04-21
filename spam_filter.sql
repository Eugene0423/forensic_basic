SELECT
    datetime(date/1000000000 + 978307200, 'unixepoch', 'localtime') as date,
    text as Content
FROM message
WHERE is_from_me = 0
AND (
    text LIKE '%http%'
    OR text LIKE '%www%'
    OR text LIKE '%.kr%' --korean, may be edited
    OR text LIKE '%.com%'
)
ORDER BY date DESC;

SELECT
    datetime(date/1000000000 + 978307200, 'unixepoch', 'localtime') as date,
    text as Content
FROM message
WHERE is_from_me = 0
AND (
    text LIKE '%대출%'
    OR text LIKE '%당첨%'
    OR text LIKE '%무료%'
    OR text LIKE '%클릭%'
    OR text LIKE '%인증%' --include text contents which include suspicious words
)
ORDER BY date DESC;
