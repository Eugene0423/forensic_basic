# forensic_basic
# 📱 iOS Mobile Forensics - Basic Project
> Mobile forensic experiment utilizing iPhone backup files

---
## 📌 Beginning the project

This project is an introductory mobile forensics practical exercise focused on generating an iTunes backup of **your own iPhone device**, analyzing the SQLite database, and extracting text message data.

> ⚠️ **Legal Notice**: This exercise must be performed exclusively on **devices you own** or **devices for which you have obtained explicit consent**. Unauthorized application to another person's device is illegal.

---

## 🛠️ Environment
OS: Windows
Phone: Iphone
Tools: iTunes, DB Browser for SQLite

- **iTunes** - create iPhone backup
- **DB Browser for SQLite** - SQLite DB file analysis

---

## 📂 Structure of the Project
//further updates will be made soon

---

## Step 1 : Create iTunes Backup

1. By USB connect iPhone to PC
2. Run iTunes, and click truct this computer
3. Click **"Backup in this computer"** -> do not crypto the local backup

**Pathway of backup file**
%User%APPDATA%\Apple\MobileSync\Backup\

---

## Step 2 : Understant the backup structure

Structure:
```
📁 [UDID]/
├── 📁 00/          
├── 📁 01/
├── 📁 3d/
│   └── 3d0d7e...   ← The real data file
├── Info.plist       ← Information of the device
├── Manifest.db      ← All the file's list (SQLite) ★
├── Manifest.plist   ← Backup metadata
└── Status.plist     ← Backup status
```

---

## Step 3 : Analyze Manifest.db

Open 'Manifest.db' from DB Browser for SQLite

**Finding the hash value of wanted file:**
```sql
SELECT fileID, domain, relativePath
FROM Files
WHERE relativePath LIKE '%sms.db%';
```
Example output:
```
fileID    : 3d0d7e5fb2ce288813306e4d4636395e047a3d28
domain    : AppDomainPlugin-com.apple.madrid
relativePath: Library/SMS/sms.db
```

---

## Step 4 : Extract and analyze sms.db

1. Check the two letter in front of 'fileID'
2. Backup Folder -> '3d' folder -> copy the matching file
3. Change the file name to 'sms.db'
4. Open 'sms.db' from DB Browser

**Check all tuples in table:**
```sql
SELECT name FROM sqlite_master WHERE type='table';
```

**Check recent 20 messages:**
```sql
SELECT
    datetime(date/1000000000 + 978307200, 'unixepoch', 'localtime') as 날짜,
    is_from_me as 내가보낸것,
    text as 내용
FROM message
ORDER BY date DESC
LIMIT 20;
```

---

## Additional Step : Filtering Spam messages

```sql
SELECT
    datetime(date/1000000000 + 978307200, 'unixepoch', 'localtime') as 날짜,
    text as 내용
FROM message
WHERE is_from_me = 0
AND (
    text LIKE '%http%'
    OR text LIKE '%www%'
    OR text LIKE '%.kr%' -> For South Korean messages
    OR text LIKE '%.com%'
)
ORDER BY date DESC;
```
