In real life scenarios like "can you show me our most viewed pages", I'd use unix tools.

1. Most Page Views:
`cat webserver.log | awk '{print $1}' | sort | uniq -c | sort -rn`

2. Unique Page Views:
`cat webserver.log | sort | uniq | awk '{print $1}' | sort | uniq -c | sort -rn`



