
select distinct c.custid
from customers c
where c.custid not in
     (select custid
      from customers left join orders on customers.custid=orders.ocust left join details on orders.ordid=details.ordid left join products on details.pcode=products.pcode	
      where products.ptype='BOOK' and orders.odate between '2016-01-01' and '2016-12-31');	  
	

