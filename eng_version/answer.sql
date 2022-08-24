-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.

SELECT
	*
FROM
	employee
WHERE
	SUBSTRING_INDEX(fullname, ' ', - 1)
	REGEXP '^[HTK]'
	AND CHAR_LENGTH(fullname) <= 15;

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

SELECT
	*
FROM
	employee
WHERE
	YEAR(now()) - YEAR(birthday) BETWEEN 18 AND 50
	and(address = 'Quang Tri'
		OR address = 'Quang Nam');

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

SELECT
	cu.fullname,
	count(co.customer_id) number_booking
FROM
	customer cu
	JOIN customer_type ct ON ct.id = cu.customer_type_id
	JOIN contract co ON co.customer_id = cu.id
WHERE
	ct. `name` = 'Diamond'
GROUP BY
	co.customer_id
ORDER BY
	number_booking;

-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- select tmp.ht, (tmp.g + tmp2.c) total from (SELECT kh.ho_ten ht, kh.ma_khach_hang mk, sum(ct.so_luong * dk.gia) g FROM khach_hang kh
-- left JOIN hop_dong hd on hd.ma_khach_hang= kh.ma_khach_hang
-- left JOIN dich_vu dv on dv.ma_dich_vu= hd.ma_dich_vu
-- left JOIN hop_dong_chi_tiet ct on ct.ma_hop_dong= hd.ma_hop_dong
-- left JOIN dich_vu_di_kem dk on dk.ma_dich_vu_di_kem= ct.ma_dich_vu_di_kem
-- group by kh.ma_khach_hang) tmp
-- left join (SELECT kh.ho_ten ht, kh.ma_khach_hang mk, sum(dv.chi_phi_thue) c FROM khach_hang kh
-- JOIN hop_dong hd on hd.ma_khach_hang= kh.ma_khach_hang
-- JOIN dich_vu dv on dv.ma_dich_vu= hd.ma_dich_vu
-- group by hd.ma_khach_hang) tmp2 on tmp2.mk= tmp.mk;

SELECT cu.id, cu.fullname, sum(cd.quantity * a.price)+ tmp.pri FROM customer cu
LEFT JOIN contract co on co.customer_id= cu.id
LEFT JOIN service se on se.id= co.service_id
LEFT JOIN contract_detail cd on cd.contract_id= co.id
LEFT JOIN attach_service a on a.id= cd.attach_service_id
LEFT JOIN 
(SELECT
	cu1.id as id,
	cu1.fullname, sum(se1.price) as pri
	FROM customer cu1
	JOIN contract co1 on co1.customer_id= cu1.id
	JOIN service se1 on se1.id= co1.service_id
	GROUP BY cu1.id) tmp on tmp.id = cu.id
	GROUP BY co.customer_id;

-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

SELECT
	se.id,
	se. `name`,
	se.area,
	se.price,
	st. `name`
FROM
	service se
	JOIN service_type st ON st.id = se.service_type_id
WHERE
	NOT EXISTS (
		SELECT
			*
		FROM
			contract
		WHERE
			service_id = se.id
			AND start_date BETWEEN '2021-01-01'
			AND '2021-03-31');

-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT
	se.id,
	se. `name`,
	se.area,
	se.price,
	se.max_people,
	st. `name`
FROM
	service se
	JOIN service_type st ON st.id = se.service_type_id
WHERE
	EXISTS (
		SELECT
			*
		FROM
			contract
		WHERE
			service_id = se.id
			AND YEAR(start_date) = '2020')
		AND NOT EXISTS (
			SELECT
				*
			FROM
				contract
			WHERE
				service_id = se.id
				AND YEAR(start_date) = '2021');

-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
 
SELECT DISTINCT
	fullname
FROM
	customer;

SELECT
	fullname
FROM
	customer
GROUP BY
	fullname;

SELECT
	fullname
FROM
	customer
UNION
SELECT
	fullname
FROM
	customer;

-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

SELECT
	tmp.month,
	co.NoOfCustomers
FROM (
	SELECT
		1 AS `month`
	UNION
	SELECT
		2 AS `month`
	UNION
	SELECT
		3 AS `month`
	UNION
	SELECT
		4 AS `month`
	UNION
	SELECT
		5 AS `month`
	UNION
	SELECT
		6 AS `month`
	UNION
	SELECT
		7 AS `month`
	UNION
	SELECT
		8 AS `month`
	UNION
	SELECT
		9 AS `month`
	UNION
	SELECT
		10 AS `month`
	UNION
	SELECT
		11 AS `month`
	UNION
	SELECT
		12 AS `month`) AS tmp
	LEFT JOIN (
		SELECT
			month(start_date) AS month,
			count(customer_id) AS NoOfCustomers
		FROM
			contract
		WHERE
			YEAR(start_date) = '2021'
		GROUP BY
			month) AS co ON co.month = tmp.month;

-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc

SELECT
	co.id,
	co.start_date,
	co.end_date,
	sum(co.down_payment),
	COUNT(cd.attach_service_id) numOfAttachService
FROM
	contract co
	LEFT JOIN contract_detail cd ON cd.contract_id = co.id
GROUP BY
	co.id;

-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

SELECT
	cu.fullname,
	a. `name`,
	a.price,
	a.status,
	a.unit
FROM
	service se
	JOIN contract co ON co.service_id = se.id
	JOIN contract_detail cd ON cd.contract_id = co.id
	JOIN attach_service a ON a.id = cd.attach_service_id
	JOIN customer cu ON cu.id = co.customer_id
	JOIN customer_type ct ON ct.id = cu.customer_type_id
WHERE
	ct. `name` = 'Diamond'
	AND cu.address in('Vinh', 'Quang Ngai');

-- 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT
	co.id,
	ep.fullname,
	cu.fullname,
	cu.phone,
	se. `name`,
	sum(cd.attach_service_id),
	co.down_payment
FROM
	service se
	JOIN contract co ON co.service_id = se.id
	JOIN employee ep ON ep.id = co.empployee_id
	JOIN customer cu ON cu.id = co.customer_id
	JOIN contract_detail cd ON cd.contract_id = co.id
	JOIN attach_service a ON a.id = cd.attach_service_id
WHERE (co.start_date BETWEEN '2020-10-01'
	AND '2020-12-30')
and(co.start_date NOT BETWEEN '2021-01-01'
	AND '2021-06-30')
GROUP BY
	co.id
-- 13.  Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

	-- CREATE TEMPORARY TABLE if not EXISTS tmp
	-- SELECT  a.`name`, count(cd.attach_service_id) numOfAttachServer FROM attach_service a
	-- JOIN contract_detail cd on cd.attach_service_id= a.id
	-- GROUP BY cd.attach_service_id;
	-- SELECT * from tmp;
	-- CREATE TEMPORARY TABLE if not EXISTS tmp1
	-- SELECT max(numOfAttachServer) numOfAttachServer FROM tmp;
	-- SELECT * FROM tmp1;
	-- SELECT tmp.name, tmp.numOfAttachServer FROM tmp
	-- JOIN tmp1 on tmp1.numOfAttachServer= tmp.numOfAttachServer;
	-- SELECT * FROM tmp
	-- WHERE numOfAttachServer in (select max(numOfAttachServer) from tmp);
	CREATE TABLE IF NOT EXISTS mostused AS
		SELECT
			a.name,
			a.id,
			count(
			*) AS amount
		FROM
			attach_service a
			JOIN contract_detail cd ON cd.attach_service_id = a.id
		GROUP BY
			a.name;

SELECT
	m.name,
	amount
FROM
	mostused m
WHERE
	m.amount = (
		SELECT
			max(amount)
		FROM
			mostused);

DROP TABLE mostused;

-- 14.  Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT
	co.id,
	se. `name`,
	a. `name`,
	count(cd.attach_service_id) amount
FROM
	attach_service a
	JOIN contract_detail cd ON cd.attach_service_id = a.id
	JOIN contract co ON co.id = cd.contract_id
	JOIN service se ON se.id = co.service_id
GROUP BY
	a. `name`
HAVING
	amount = 1;

-- 15.  Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
SELECT
	ep.fullname,
	de. `name`,
	dp. `name`,
	ep.phone,
	ep.address,
	count(ep.id) amount
FROM
	employee ep
	JOIN `degree` de ON de.id = ep.degree_id
	JOIN department dp ON dp.id = ep.department_id
	JOIN contract co ON co.empployee_id = ep.id
WHERE
	YEAR(co.start_date) BETWEEN '2020'
	AND '2021'
GROUP BY
	ep.id
HAVING
	amount <= 3;

-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
DELETE FROM employee
WHERE id NOT in(
		SELECT
			-- can't specify target table
			tmp.id FROM ( SELECT DISTINCT
					ep.id FROM employee ep
					JOIN contract co ON co.empployee_id = ep.id
				WHERE
					YEAR(co.start_date) BETWEEN 2019 AND 2021) AS tmp);

DELETE FROM employee
WHERE NOT EXISTS (
		SELECT
			*
		FROM
			contract
		WHERE
			empployee_id = employee.id
			AND YEAR(contract.start_date) BETWEEN 2019 AND 2021);

-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ
UPDATE
	customer
SET
	customer_type_id = 1
WHERE
	id in(
		SELECT
			tmp.id FROM ( SELECT DISTINCT
					cu.id, sum(se.price + a.price * cd.quantity) AS total_pay FROM customer cu
					JOIN contract co ON co.customer_id = cu.id
					JOIN service se ON se.id = co.service_id
					JOIN contract_detail cd ON cd.contract_id = co.id
					JOIN attach_service a ON a.id = cd.attach_service_id
				WHERE
					cu.customer_type_id = 2
					AND YEAR(co.start_date) = 2021
				GROUP BY
					co.id
				HAVING
					total_pay > 100) AS tmp);

-- 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).

DELETE
FROM
	customer WHERE NOT EXISTS (
		SELECT
			*
		FROM
			contract
		WHERE
			YEAR(start_date) >= 2021
			AND contract.customer_id = customer.id);

-- 19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

UPDATE
	attach_service
SET
	price = price * 2
WHERE
	id in(
		SELECT
			tmp.id FROM ( SELECT DISTINCT
					a.id AS id FROM attach_service a
					JOIN contract_detail cd ON cd.attach_service_id = a.id
					JOIN contract co ON co.id = cd.contract_id
				WHERE
					YEAR(co.start_date) = 2021
				GROUP BY
					cd.attach_service_id
				HAVING
					COUNT(cd.attach_service_id) >= 5) AS tmp);

-- 20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

SELECT id, fullname, email, phone, birthday, address, 'employee' as fromTable FROM employee
UNION ALL
SELECT id, fullname, email, phone, birthday, address, 'customer' as fromTable FROM customer

-- 21.	Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu” và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”

CREATE VIEW v_nhan_vien AS
SELECT
	em.id, em.fullname, em.address
FROM
	employee em
	JOIN contract co ON co.empployee_id = em.id
WHERE
year(co.start_date) = 2020
-- 	co.start_date = '2019-12-12' and em.address= 'Hai Chau'
GROUP BY
	co.empployee_id
HAVING
	count(co.empployee_id) >= 1;

-- 22.	Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.

-- Not all views are updateable. The rules around updates change between various mysql versions and perhaps even the sql mode setting influences the behaviour. Pls share the exact mysql version of both servers and the select statement of the view as well.

UPDATE v_nhan_vien a set a.address= 'Lien Chieu';

-- 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

DELIMITER //
CREATE PROCEDURE sp_xoa_khach_hang(customerId int)
BEGIN
DELETE FROM customer WHERE id= customerId;
END
// DELIMITER ;

-- 24.	Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với yêu cầu sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

DELIMITER / / CREATE PROCEDURE sp_them_moi_hop_dong(
    pid int,
    pstart_date date,
    pend_date date,
    pdown_payment double,
    pempployee_id int,
    pcustomer_id int,
    pservice_id int
) BEGIN DECLARE lastid int;
select
    max(id) into lastid
from
    contract;
if pid = lastid + 1 THEN if pstart_date is null then SIGNAL SQLSTATE '02000'
SET
    MESSAGE_TEXT = 'start date is not null';
    else
INSERT INTO
    contract (
        id,
        start_date,
        end_date,
        down_payment,
        empployee_id,
        customer_id,
        service_id
    ) VALUE(
        pid,
        pstart_date,
        pend_date,
        pdown_payment,
        pempployee_id,
        pcustomer_id,
        pservice_id
    );
end if;
else SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Invalid id';
end if;
END / / DELIMITER;
call sp_them_moi_hop_dong(31, '2020-10-10', null, null, 1, 2, 1);

-- 25.	Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.

DELIMITER //
CREATE TRIGGER tr_xoa_hop_dong
AFTER DELETE on contract FOR EACH ROW
BEGIN
set @c= (select count(*) from contract);
signal SQLSTATE '01000' set MESSAGE_TEXT = @c;
END
// DELIMITER ;

drop TRIGGER tr_xoa_hop_dong;
DELETE FROM contract WHERE id= 10;


-- 26.	Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.

DELIMITER //
CREATE trigger tr_cap_nhat_hop_dong
after UPDATE on contract FOR EACH ROW
BEGIN
if new.start_date> new.end_date then signal SQLSTATE '02000' set MESSAGE_TEXT = 'Invaild start date';
end if;
END
// DELIMITER ;

UPDATE `cs_m3`.`contract` SET `end_date` = '2021-12-20' WHERE (`id` = '1');
drop trigger tr_cap_nhat_hop_dong;

-- 27.	Tạo Function thực hiện yêu cầu sau:
-- a.	Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
-- b.	Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng mà khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng). Mã của khách hàng được truyền vào như là 1 tham số của function này.


SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
create FUNCTION func_dem_dich_vu()
RETURNS  int
BEGIN
DECLARE res int;
select count(*) INTO res from (select se.`name`, sum(se.price)  as total from contract co
JOIN service se on se.id= co.service_id
GROUP by co.service_id
HAVING total> 500) as t;
return res;
END
// DELIMITER ;

select func_dem_dich_vu();


DELIMITER //
CREATE FUNCTION func_tinh_thoi_gian_hop_dong(pcustomer_id int)
RETURNS int
begin
DECLARE res int;
select max(tmp.t) into res from (select datediff(end_date, start_date) t from contract
WHERE customer_id= pcustomer_id) as tmp;
RETURN res;
end
// DELIMITER ;

select func_tinh_thoi_gian_hop_dong(5);

-- 28.	Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng dich_vu) và xóa những hop_dong sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng hop_dong) và những bản liên quan khác.

DELIMITER //
CREATE PROCEDURE sp_xoa_dich_vu_va_hd_room()
BEGIN
SET @myvar := (SELECT GROUP_CONCAT(co.id SEPARATOR ',') AS myval from service se
JOIN service_type st on st.id= se.service_type_id
JOIN contract co on co.service_id= se.id
WHERE st.`name`= 'Room' and  year(co.start_date) BETWEEN 2015 and 2020);
DELETE FROM contract_detail  WHERE FIND_IN_SET(contract_id,@myvar);
DELETE FROM contract  WHERE FIND_IN_SET(id,@myvar);
DELETE from service
WHERE id in ( SELECT DISTINCT
			co.service_id
		FROM
			contract co
		WHERE
			 FIND_IN_SET(co.id,@myvar));
END
// DELIMITER ;

call sp_xoa_dich_vu_va_hd_room();
