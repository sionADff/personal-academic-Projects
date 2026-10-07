# Dating Platform — Database

Relational database for a dating application: user profiles, hobbies, likes and mutual matches. Built as a coursework project (2025).

## Tech

- **DBMS:** MySQL 8.0+ (script uses functional key parts, requires MySQL >= 8.0.13)
- **Language:** SQL

## Schema (8 tables)

| Table | Purpose |
| --- | --- |
| `users` | Profile: name, email (unique), password hash, age, bio, location |
| `genders` | Lookup: gender list |
| `countries` / `cities` | Location hierarchies (city -> country) |
| `hobbies` | Lookup: hobby list |
| `users_hobbies` | Many-to-many: user <-> hobbies |
| `likes` | One-directional like, no self-likes (`CHECK`), no duplicates (`UNIQUE`) |
| `matches` | Mutual match; functional unique key prevents duplicate pairs (A,B) vs (B,A) |

Design notes:

- Normalized to 3NF: no repeating groups, all non-key attributes depend on the key only.
- Referential integrity via foreign keys with deliberate `ON DELETE` behaviour (`RESTRICT` on gender, `SET NULL` on location, `CASCADE` on likes/matches).
- Passwords are stored only as hashes; demo file contains placeholder hashes, no real credentials.

## How to run

```bash
mysql -u root -p < dating_platform.sql
```

Or paste the script into MySQL Workbench / phpMyAdmin (SQL tab) and execute. The script drops and re-creates the tables, then loads seed data: 8 countries, 45 cities, 9 hobbies, 6 demo users.

## Example queries

**1. All matches with user names and cities:**

```sql
SELECT m.id AS match_id,
       u1.name AS user_a, c1.city_name AS city_a,
       u2.name AS user_b, c2.city_name AS city_b,
       m.created_at
FROM matches m
JOIN users u1 ON u1.id = m.userA_id
JOIN users u2 ON u2.id = m.userB_id
LEFT JOIN cities c1 ON c1.id = u1.city_id
LEFT JOIN cities c2 ON c2.id = u2.city_id;
```

**2. Who received the most likes:**

```sql
SELECT u.name, u.surname, COUNT(l.id) AS likes_received
FROM users u
JOIN likes l ON l.liked_id = u.id
GROUP BY u.id, u.name, u.surname
ORDER BY likes_received DESC;
```

**3. Mutual likes not matched yet (candidates for new matches):**

```sql
SELECT l1.users_id AS user_a, l1.liked_id AS user_b
FROM likes l1
JOIN likes l2 ON l1.users_id = l2.liked_id AND l1.liked_id = l2.users_id
WHERE l1.users_id < l1.liked_id;
```

**4. Most popular hobbies:**

```sql
SELECT h.hobby_name, COUNT(uh.users_id) AS fans
FROM hobbies h
JOIN users_hobbies uh ON uh.hobbies_id = h.id
GROUP BY h.id, h.hobby_name
ORDER BY fans DESC;
```

## Project status

Schema and seed data are complete and tested; application layer (backend/frontend) is out of scope for this repository.
