-- lookup.sql

-- Find SMS DB
SELECT fileID, domain, relativePath
FROM Files
WHERE relativePath LIKE '%sms.db%';

-- Find Phone Call History DB
SELECT fileID, domain, relativePath
FROM Files
WHERE relativePath LIKE '%CallHistory%';

-- Find Safari History
SELECT fileID, domain, relativePath
FROM Files
WHERE relativePath LIKE '%History.db%';

-- Find App Usage History
SELECT fileID, domain, relativePath
FROM Files
WHERE relativePath LIKE '%KnowledgeC%';

-- Find all file list by domain
SELECT domain, COUNT(*) as numoffile
FROM Files
GROUP BY domain
ORDER BY numoffile DESC;
