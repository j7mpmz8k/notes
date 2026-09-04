```psql
createdb ENTER_NAME  
```

lists DB's
```
\l
```

enter DB
```psql
\c DB_NAME
```

lists tables from within DB
```
\dt
```

?
```
\i
```

finds gets rows from a table
```sql
SELECT col1, col2 FROM table1;
```

counts all items in all rows from table?
```sql
SELECT COUNT(*) FROM table1
```

not sure what `GROUP BY` does
```sql
SELECT COUNT(row1) FROM table1 GROUP BY row1
```

`WHERE` lets me filter the collum by certain critiria
```sql
SELECT WHERE collumn1 = "row entry name"
```
