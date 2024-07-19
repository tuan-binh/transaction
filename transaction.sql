create DATABASE my_user_data;
use my_user_data;

create table users (
	id int AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    myMonney double,
    address varchar(255),
    phone VARCHAR(11),
    dob date,
    status bit
);

alter table users MODIFY COLUMN myMonney double check (myMonney > 0);
describe users;
create table transfers (
	sender_id int,
    receive_id int,
    money double,
    transfer_date DATETIME,
    PRIMARY KEY (sender_id,receive_id),
    FOREIGN KEY(sender_id) REFERENCES users(id),
    FOREIGN KEY(receive_id) REFERENCES users(id)
);

INSERT INTO users (name, myMonney, address, phone, dob, status) VALUES
('Nguyễn Văn A', 15000000.00, '123 Đường Láng, Hà Nội', '0912345678', '1985-05-20', 1),
('Trần Thị B', 20000000.00, '456 Đường Giải Phóng, Hà Nội', '0923456789', '1990-08-15', 1),
('Lê Minh C', 30000000.00, '789 Đường Nguyễn Trãi, Hà Nội', '0934567890', '1988-12-25', 1),
('Phạm Thanh D', 25000000.00, '101 Đường Cầu Giấy, Hà Nội', '0945678901', '1992-03-10', 1),
('Hoàng Thị E', 35000000.00, '202 Đường Kim Mã, Hà Nội', '0956789012', '1987-07-30', 1);

delete from transfers where sender_id = 1 and receive_id = 2; 

start transaction;
-- update lại money của người gửi
update users set myMonney = myMonney - 13000000 WHERE id = 1; 
-- tạo transfers
insert into transfers (sender_id,receive_id ,money,transfer_date) values (1,2,13000000,NOW());
-- update lại money của người nhận
update users set myMonney = myMonney + 13000000 where id = 2;
commit;
set autocommit = 0; 