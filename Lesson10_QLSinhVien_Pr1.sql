drop database QuanLySinhVien;
create database QuanLySinhVien;
use QuanLySinhVien;

create table Class (
	ClassID int primary key auto_increment,
    ClassName varchar(10) not null unique,
    StartDate date,
    Status bit
);

create table Student (
	StudentID int primary key auto_increment,
    StudentName varchar(20) not null,
    Address varchar(50) not null,
    Phone varchar(10),
    Status bit,
    ClassID int,
    foreign key (ClassID) references Class(ClassID)
);

create table Subject (
	SubID int primary key auto_increment,
    SubName varchar(10) not null,
    Credit int,
    Status bit
);

create table Mark (
	MarkID int primary key auto_increment,
    SubID int,
    StudentID int,
    Mark int,
    ExamTimes int,
    foreign key (SubID) references Subject(SubID),
    foreign key (StudentID) references Student(StudentID)
);


insert into Class (ClassName, StartDate, Status)
values	('A1', '2008-12-20', 1),
		('A2', '2008-12-22', 1),
        ('B3', current_date(), 0);

insert into Student (StudentName, Address, Phone, Status, ClassID)
values	('Hung', 'Ha Noi', '0912113113', 1 ,1),
		('Hoa', 'Hai Phong', '', 1 ,1),
		('Hoa2', 'Hai Phong', '', 1 ,1),
		('Manh', 'HCM', '0123123123', 0 ,2);
        
insert into Subject (SubName, Credit, Status)
values	('CF', 5, 1),
		('C', 6, 1),
        ('HDJ', 5, 1),
        ('RDBMS', 10, 1);
        
insert into Mark (SubID, StudentID, Mark, ExamTimes)
values	(1, 1, 8, 1),
		(1, 2, 10, 2),
        (2, 1, 12, 1),
        (3, 1, 30, 1),
        (3, 3, 20, 1);
        

-- select * from Student;
-- select * from Subject;
-- select * from Class;
-- select * from Student where status = true;

-- select * from Subject where Credit < 10;

-- select S.StudentID, S.StudentName, C.ClassName
-- from Student S join Class C on S.ClassID = C.ClassID where C.ClassName = 'A1';

-- select S.StudentID, S.StudentName, Sub.SubName, M.Mark
-- from Student S join Mark M on  S.StudentID = M.StudentID join Subject Sub on Sub.SubID = M.SubID
-- where Sub.SubName = 'CF';

-- Hiển thị số lượng sinh viên ở từng nơi
select address, count(StudentID) as 'Số lượng sinh viên'
from Student
group by address;

-- Tính điểm trung bình các môn học của mỗi học viên
select S.StudentName as 'Tên học viên', avg(M.mark) as 'Điểm trung bình'
from Student as S join Mark as M on S.StudentID = M.StudentID
group by S.StudentName;

-- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
select S.StudentName as 'Tên học viên', avg(M.mark) as 'Điểm trung bình'
from Student as S join Mark as M on S.StudentID = M.StudentID
group by S.StudentName
having avg(M.mark) > 15;

-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select S.StudentName as 'Tên học viên', avg(M.mark) as 'Điểm trung bình'
from Student as S join Mark as M on S.StudentID = M.StudentID
group by S.StudentName
having avg(M.mark) >= all (
	select avg(M.mark) 
    from Mark as M
    group by M.StudentID
);

