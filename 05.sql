  

with tabled(custid,diff) as
 (with tablec(custid,odate,ind) as 
 (with tableb(custid,odate) as 
  (with tablea (custid, count_date) as  
     (select c.custid, count(distinct o.odate)
     from customers c left join orders o on c.custid=o.ocust
     group by c.custid
     having count(distinct o.odate)>=5)
  select a.custid, o.odate
  from tablea a left join orders o on a.custid=o.ocust
  order by a.custid, o.odate)
  select b.custid, b.odate, row_number()over(order by b.custid)
  from tableb b)
 select c1.custid, c1.odate-c2.odate diff
 from tablec c1, tablec c2
 where c1.ind=c2.ind+1 and c1.custid=c2.custid and (c1.odate-c2.odate)>0)
select distinct d.custid
from tabled d
group by d.custid
having avg(d.diff)<30;
