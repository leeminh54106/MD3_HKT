create database HN_JV240408_AD_LEMINHQUANG;
use HN_JV240408_AD_LEMINHQUANG;

create table  CUSTOMERS
(
    id varchar(4) PRIMARY KEY,
    name        varchar(100) not null,
    email       varchar(100) not null UNIQUE,
    phone       varchar(25) not null UNIQUE,
    address     varchar(255) not null
);

create table ORDERS
(
    id varchar(4) primary key,
    customer_id  VARCHAR(4) not null,
	foreign key (customer_id) references CUSTOMERS (id),
	total_amount double not null,
	order_date   date not null
    );

create table PRODUCTS
(
    id varchar(4) primary key,
    name varchar(255) not null,
    description text,
    price double not null,
    status bit(1) not null
);

create table ORDERS_DETAILS
(
    order_id varchar(4) not null,
    foreign key (order_id) references ORDERS (id),
    product_id varchar(4) not null,
	foreign key (product_id) references PRODUCTS (id),
    quantity   int(11) not null,
    price      double not null,
    primary key (order_id, product_id)
);

insert into CUSTOMERS (id, name, email, phone, address)
values ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984758926', 'Ba Đình, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904727584', 'Mỹ Châu, Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');

insert into PRODUCTS (id, name, description, price, status)
values ('P001', 'iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 18999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 409900, 1);

insert into ORDERS (id, customer_id, total_amount, order_date)
values ('H001', 'C001', 52999997, '2023-02-22'),
       ('H002', 'C001', 80999987, '2023-03-11'),
       ('H003', 'C002', 54399958, '2023-01-23'),
       ('H004', 'C003', 102999957, '2023-02-14'),
       ('H005', 'C003', 80999997, '2022-03-13'),
       ('H006', 'C004', 110499994, '2023-02-01'),
       ('H007', 'C004', 17999996, '2023-03-29'),
       ('H008', 'C004', 29999998, '2023-02-14'),
       ('H009', 'C005', 28999999, '2023-01-10'),
       ('H010', 'C005', 14999994, '2023-04-11');

insert into ORDERS_DETAILS (order_id, product_id, price, quantity)
values ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),
       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),
       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005', 40900000, 4),
       ('H004', 'P002', 14999999, 3),
       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),
       ('H006', 'P005', 40900000, 5),
       ('H006', 'P002', 14999999, 6),
       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),
       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 9),
       ('H010', 'P003', 28999999, 4),
       ('H010', 'P001', 22999999, 4);

-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
select * from customers;

-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng)
select c.name,c.phone,c.address from customers c 
join orders o on o.customer_id = c.id
where o.order_date >= '2023-03-01' and o.order_date <= '2023-03-31';

-- 3. Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ).
select month(order_date) as thang,sum(total_amount) as tong_doanh_thu from orders
where year(order_date) = 2023
group by month(order_date);

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại)
select c.* from customers c where c.id not in (select o.customer_id from orders o where o.order_date >= '2023-02-01' and o.order_date <= '2023-02-28');

-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra
select od.product_id, p.name as product_name, sum(od.quantity) as tong_so_luong_ban from ORDERS_DETAILS od
join ORDERS o ON od.order_id = o.id
join PRODUCTS p ON od.product_id = p.id
where o.order_date >= '2023-03-01' and o.order_date <= '2023-03-31'
group by od.product_id, p.name;

-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu 
-- (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu).
select c.id as ma_khach_hang,c.name as ten_khach_hang,sum(o.total_amount) as muc_chi_tieu
from CUSTOMERS c
join ORDERS o on c.id = o.customer_id
and year(o.order_date) = 2023
group by c.id, c.name
order by muc_chi_tieu desc;

-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên 
-- (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) 
select c.name,sum(od.price) as tong_tien,o.order_date,sum(od.quantity) as tong_so_luong from orders_details od
join orders o on o.id = od.order_id
join customers c on c.id = o.customer_id
group by o.id
having tong_so_luong >5;

-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn 
create view laythongtin as select c.name,c.phone,c.address,o.total_amount,o.order_date from customers c
join orders o on o.customer_id = c.id;
select * from laythongtin;

-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt.
create view hienthikhachang as select c.name,c.address,c.phone,count(o.id) as tong_so_luong from customers c 
join orders o on o.customer_id = c.id
group by c.id;
select * from hienthikhachang;

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.
create view hienthisanpham as select p.name,p.description,p.price,sum(od.quantity) as tong_so_luong from products p
join orders_details od on od.product_id = p.id
group by p.id;
select * from hienthisanpham;

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer
create index idx_phone on customers(phone);
create index idx_email on customers(email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.
delimiter //
create procedure laytatca(id_in varchar(4))
begin
select * from customers where id = id_in;
end //
delimiter //

call laytatca('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm.
delimiter //
create procedure tatcasanpham()
begin
select * from products;
end //
delimiter ;
call tatcasanpham;

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng
delimiter //
create procedure danhsachhoadon (customer_id_in varchar(4))
begin
select o.* from orders o
join customers c on c.id = o.customer_id
where c.id = customer_id_in;
end //
delimiter ;

call danhsachhoadon('C001');