create database HN_JV221024_CB_LeMinhQuang;
use HN_JV221024_CB_LeMinhQuang;


create table student (
id varchar(4) primary key not null,
name varchar(100) not null,
birthday date not null,
gender bit(1) not null,
address text not null,
phone varchar(45) unique
);

create table subject(
id varchar(4) primary key not null,
name varchar(45) not null,
priority int not null
);

create table mark(
studentid varchar(4) not null,
foreign key(studentid) references student(id),
subjectid varchar(4) not null,
foreign key(subjectid) references subject(id),
point double not null
);

insert into student values('S001','Nguyễn Thế Anh','1999-1-11',1,'Hà Nội','984678082'),
						  ('S002','Đặng Bảo Trâm','1998-12-22',0,'Lào Cai','904982654'),
                          ('S003','Trần Hà Phương','2000-5-5',0,'Nghệ An','947645363'),
                          ('S004','Đỗ Tiến Mạnh','1999-3-26',1,'Hà Nội','983665353'),
                          ('S005','Phạm Duy Nhất','1998-10-4',1,'Tuyên Quang','987242678'),
                          ('S006','Mai Văn Thái','2002-6-22',1,'Nam Định','982654268'),
                          ('S007','Giang Gia Hân','1996-11-10',0,'Phú Thọ','982364753'),
                          ('S008','Nguyễn Ngọc Bảo My','1999-1-22',0,'Hà Nam','927863453'),
                          ('S009','Nguyễn Tiến Đạt','1998-8-7',1,'Tuyên Quang','989274673'),
                          ('S010','Nguyễn Thiệu Quang','2000-9-18',1,'Hà Nội','984378291');

insert into subject values('MH01','Toán',2),
						  ('MH02','Vật Lý',2),
						  ('MH03','Hoá Học',1),
						  ('MH04','Ngữ Văn',1),
						  ('MH05','Tiếng Anh',2);
					
insert into mark values('S001','MH01',8.5),('S001','MH02',7),('S001','MH03',9),('S001','MH04',9),('S001','MH05',5),
					   ('S002','MH01',9),('S002','MH02',8),('S002','MH03',6.5),('S002','MH04',8),('S002','MH05',6),
					   ('S003','MH01',7.5), ('S003','MH02',6.5), ('S003','MH03',8), ('S003','MH04',7), ('S003','MH05',7),
					   ('S004','MH01',6), ('S004','MH02',7), ('S004','MH03',5), ('S004','MH04',6.5), ('S004','MH05',8),
					   ('S005','MH01',5.5), ('S005','MH02',8), ('S005','MH03',7.5), ('S005','MH04',8.5), ('S005','MH05',9),
					   ('S006','MH01',8), ('S006','MH02',10), ('S006','MH03',9), ('S006','MH04',7.5), ('S006','MH05',6.5),
					   ('S007','MH01',9.5), ('S007','MH02',9), ('S007','MH03',6), ('S007','MH04',9), ('S007','MH05',4),
					   ('S008','MH01',10), ('S008','MH02',8.5), ('S008','MH03',8.5), ('S008','MH04',6), ('S008','MH05',9.5),
					   ('S009','MH01',7.5), ('S009','MH02',7), ('S009','MH03',9), ('S009','MH04',5), ('S009','MH05',10),
					   ('S010','MH01',6.5), ('S010','MH02',8), ('S010','MH03',5.5), ('S010','MH04',4), ('S010','MH05',7);
                       
--  Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
update student set name = 'Đỗ Đức Mạnh' where id = 'S004';
-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
update subject set name = 'Ngoại Ngữ' where id = 'MH05';
update subject set priority = 1 where id = 'MH05';

select * from subject;

-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9).
update mark set point = 8.5 where studentid = 'S009' and subjectid = 'MH01';

update mark set point = 7 where studentid = 'S009' and subjectid = 'MH02';

update mark set point = 5.5 where studentid = 'S009' and subjectid = 'MH03';

update mark set point = 6 where studentid = 'S009' and subjectid = 'MH04';

update mark set point = 9 where studentid = 'S009' and subjectid = 'MH05';

-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
delete from mark m where m.studentid = 'S010';
delete from student where id = 'S010';

-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student 
select * from student;

-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1
select * from subject sub where sub.priority = 1;

-- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , 
-- giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh
select id,name,birthday,case gender when  1 then 'nam' else 'nữ' end as gender, address,phone from student s;

-- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần
select s.name,sub.name,m.point as diem_toan from student s
join mark m on m.studentid = s.id
join subject sub on sub.id = m.subjectid
where sub.name = 'Toán'
order by diem_toan desc;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
select case gender when 0 then 'Nữ' else 'Nam' end as 'Giới tính',count(gender) as 'Số lượng' from student group by gender;

-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , 
-- bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.

select s.id,s.name,sum(m.point) as 'Tổng điểm',avg(m.point) as 'Điểm trung bình' from student s
join mark m on s.id = m.studentid
group by s.id, s.name;

-- 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán 
create view student_view as select id,name,gender, address from student;
select * from student_view;

-- 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học 
create view average_mark_view as select s.id,s.name,avg(m.point) as 'điểm trung bình' from student s 
join mark m on m.studentid = s.id
group by s.id,s.name;
select * from average_mark_view;

-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT
create index idx_phoneNumber on student(phone);

-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
delimiter //
create procedure PROC_INSERTSTUDENT(id_in varchar(4),name_in varchar(100),birthday_in date,gender_in bit, address_in text,phone_in varchar(45))
begin
insert into student(id,name,birthday,address,phone) value(id_in,name_in,birthday_in,gender_in,address_in,phone_in);
end //
delimiter ;

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học
delimiter //
create procedure PROC_UPDATESUBJECT(id_in varchar(4),name_in varchar(45))
begin
update subject set name = name_in where id = id_in;
end //
delimiter ;

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh. 
delimiter //
create procedure PROC_DELETEMARK (id_in varchar(4))
BEGIN
    delete from mark where studentid = id_in;
END //
delimiter ;
