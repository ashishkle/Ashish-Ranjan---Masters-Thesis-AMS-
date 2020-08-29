
 create table freshrss.on2it_context as -- [or use Insert]
-- insert into freshrss.on2it_context  values
SELECT id, 'VENDOR' as on2itcontext, e.title,  
CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4) as newsfeed 
, e.link, e.tags, DATE(FROM_UNIXTIME(e.date)) as pub_date
FROM freshrss.on2itashishranjan_entry e 
WHERE e.aging =0
AND LOWER(CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)) 
REGEXP 'palo alto networks|microsoft|fortinet|cisco|vmware|k8s|extreme networks
|forrester|centrify|john kindervag|chase cummingham'
union
SELECT id, 'NON-VENDOR' as on2itcontext , e.title,  
CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)  as newsfeed 
, e.link, e.tags, DATE(FROM_UNIXTIME(e.date)) as pub_date
FROM freshrss.on2itashishranjan_entry e  
WHERE e.aging =0 
AND LOWER(CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)) 
REGEXP 'oracle|google|amazon|sap|salesforce|zoom'
union
SELECT id, 'BREACH' as on2itcontext , e.title,  
CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)  as newsfeed
 , e.link, e.tags, DATE(FROM_UNIXTIME(e.date)) as pub_date
FROM freshrss.on2itashishranjan_entry e 
WHERE e.aging =0 
AND LOWER(CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)) 
REGEXP 'data breach|data leak|privacy breach'
union
SELECT id, 'ZERO TRUST' as on2itcontext , e.title,  
CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)  as newsfeed , 
e.link, e.tags, DATE(FROM_UNIXTIME(e.date)) as pub_date
FROM freshrss.on2itashishranjan_entry e 
WHERE e.aging =0 
AND LOWER(CONVERT(SUBSTRING(UNCOMPRESS(e.content_bin),1,5000) USING utf8mb4)) 
REGEXP 'zero trust';