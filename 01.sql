
with temp_tableb(ordid,ptype_count) as
  (with temp_table(ordid, ptype) as
    (select distinct details.ordid, products.ptype
     from details left join products on details.pcode=products.pcode)
  select a.ordid, count(a.ptype)
  from temp_table a
  where a.ptype is not NULL
  group by a.ordid
  having count(a.ptype)=1)
select distinct products.ptype, count(distinct b.ordid)
from temp_tableb b inner join details on b.ordid=details.ordid inner join products on details.pcode=products.pcode
group by products.ptype;



