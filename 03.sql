select c.custid, cast(sum(p.price*d.qty) as decimal(10,2))
from customers c left join orders o on c.custid=o.ocust left join details d on o.ordid=d.ordid left join products p on d.pcode=p.pcode
where p.ptype='MUSIC' and o.odate between '2016-01-01' and '2016-06-30'
group by c.custid
having sum(p.price*d.qty)<50
union all
select distinct c.custid, cast(0 as decimal(10,2))
from customers c left join orders o on c.custid=o.ocust left join details d on o.ordid=d.ordid left join products p on d.pcode=p.pcode
where c.custid not in
     (select custid
      from customers left join orders on customers.custid=orders.ocust left join details on orders.ordid=details.ordid left join products on details.pcode=products.pcode	
      where products.ptype='MUSIC' and orders.odate between '2016-01-01' and '2016-06-30') or o.ordid is null;
	 

