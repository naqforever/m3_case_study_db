-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.

SELECT
    *
FROM
    nhan_vien
WHERE
    SUBSTRING_INDEX(ho_ten, ' ', - 1) REGEXP '^[HTK]'
    AND CHAR_LENGTH(ho_ten) <= 15;
    
	
	
-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

SELECT
	*
FROM
	khach_hang
WHERE
	TIMESTAMPDIFF(Year,ngay_sinh,now())  BETWEEN 18 AND 50
	and (dia_chi like '%Da Nang%'
		OR dia_chi like '%Quang Tri%');



-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần 
--	đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

SELECT
    kh.ho_ten,
    count(hd.ma_khach_hang) so_lan_dat
from
    khach_hang kh
    JOIN loai_khach lk USING(ma_loai_khach)
    JOIN hop_dong hd USING (ma_khach_hang)
WHERE
    lk.ten_loai_khach = 'Diamond'
GROUP BY
    hd.ma_khach_hang
ORDER BY
    so_lan_dat;



-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, 
--	tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và 
--	Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng.
--	(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).


-- solution1
SELECT
    ma_khach_hang,
    ho_ten,
    ten_loai_khach,
    t.ma_hop_dong,
    ten_dich_vu,
    ngay_lam_hop_dong,
    ngay_ket_thuc,
    (IFNULL(sum(so_luong * gia), 0) + IFNULL(t.cpt, 0)) tongtien
from
    khach_hang
    LEFT JOIN loai_khach USING(ma_loai_khach)
    LEFT JOIN hop_dong USING(ma_khach_hang)
    LEFT JOIN hop_dong_chi_tiet USING(ma_hop_dong)
    LEFT JOIN dich_vu_di_kem USING(ma_dich_vu_di_kem)
    LEFT JOIN (
        SELECT
            ten_dich_vu,
            ma_hop_dong,
            sum(chi_phi_thue) cpt
        from
            khach_hang
            LEFT JOIN hop_dong USING(ma_khach_hang)
            LEFT JOIN dich_vu USING(ma_dich_vu)
        GROUP BY
            ma_hop_dong
    ) t USING(ma_hop_dong)
GROUP BY
    ma_hop_dong;

-- solution2
select
    distinct khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong,
    dich_vu.ten_dich_vu,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    sum(
        if (
            hop_dong_chi_tiet.so_luong is null,
            0,
            hop_dong_chi_tiet.so_luong * dich_vu_di_kem.gia
        )
    ) + dich_vu.chi_phi_thue as Tong_Tien
from
    khach_hang
    left join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
    left join hop_dong on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
    left join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
    left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    left join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
group by
    hop_dong.ma_hop_dong;

    
-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ
--	chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).


-- solution1
SELECT
    ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu
FROM
    dich_vu
    JOIN loai_dich_vu USING (ma_loai_dich_vu)
WHERE
    ma_dich_vu NOT IN (
        SELECT
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2021
            AND QUARTER(ngay_lam_hop_dong) = 1
    );
	
	
-- solution2	
SELECT
    ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu
FROM
    dich_vu
    JOIN loai_dich_vu USING (ma_loai_dich_vu)
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2021
            AND QUARTER(ngay_lam_hop_dong) = 1
            AND dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
    );
	
	
-- solution3	
SELECT
    dv.ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu
FROM
    dich_vu dv
    JOIN loai_dich_vu USING (ma_loai_dich_vu)
    LEFT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
    AND YEAR(hd.ngay_lam_hop_dong) = 2021
    AND QUARTER(hd.ngay_lam_hop_dong) = 1
WHERE
    hd.ma_dich_vu IS NULL
GROUP BY
    dv.ma_dich_vu;


-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ
-- đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT
    ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu
from
    dich_vu dv
    JOIN loai_dich_vu USING (ma_loai_dich_vu)
WHERE
    EXISTS (
        SELECT
            1
        FROM
            hop_dong
        WHERE
            dv.ma_dich_vu = ma_dich_vu
            and year(ngay_lam_hop_dong) = 2020
    )
    and 
    NOT EXISTS (
            SELECT
            1
        FROM
            hop_dong
        WHERE
            dv.ma_dich_vu = ma_dich_vu
            and year(ngay_lam_hop_dong) = 2021
    );
    


-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau. Sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
 
SELECT
    DISTINCT(ho_ten)
FROM
    khach_hang;


SELECT
    ho_ten
FROM
    khach_hang
GROUP BY
    ho_ten;
    

SELECT
    ho_ten
FROM
    khach_hang
UNION
SELECT
    ho_ten
FROM
    khach_hang;
    


-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

SELECT
    thang,
    IFNULL(so_lan_khach_dat, 0)
FROM
    (
        SELECT
            1 AS thang
        UNION
        SELECT
            2 AS thang
        UNION
        SELECT
            3 AS thang
        UNION
        SELECT
            4 AS thang
        UNION
        SELECT
            5 AS thang
        UNION
        SELECT
            6 AS thang
        UNION
        SELECT
            7 AS thang
        UNION
        SELECT
            8 AS thang
        UNION
        SELECT
            9 AS thang
        UNION
        SELECT
            10 AS thang
        UNION
        SELECT
            11 AS thang
        UNION
        SELECT
            12 AS thang
    ) t
    LEFT JOIN (
        SELECT
            month(ngay_lam_hop_dong) AS thang,
            count(ma_khach_hang) AS so_lan_khach_dat
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = '2021'
        GROUP BY
            thang
    ) c USING (thang);



-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong,
-- ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    SUM(hd.tien_dat_coc) tong_tien_coc,
    IFNULL(SUM(hdct.so_luong), 0) so_luong_dich_vu_di_kem
FROM
    hop_dong hd
    LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
GROUP BY
    hd.ma_hop_dong;
	
	

-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

SELECT
    ma_dich_vu_di_kem,
    ten_dich_vu_di_kem
FROM
    dich_vu_di_kem
    JOIN hop_dong_chi_tiet USING (ma_dich_vu_di_kem)
    JOIN hop_dong hd USING (ma_hop_dong)
    JOIN khach_hang USING (ma_khach_hang)
    JOIN loai_khach USING (ma_loai_khach)
WHERE
    ten_loai_khach = 'Diamond'
    AND (
        dia_chi LIKE '%Vinh%'
        OR dia_chi LIKE '%Quang Ngai%'
    );



-- 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu,
-- so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ 
-- đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT
    ma_hop_dong,
    nv.ho_ten nhan_vien,
    kh.ho_ten khach_hang,
    kh.so_dien_thoai,
    ten_dich_vu,
    SUM(tien_dat_coc) tong_tien_coc,
    SUM(so_luong) tong_so_luong_dvdk,
    ngay_lam_hop_dong
FROM
    hop_dong
    LEFT JOIN nhan_vien nv USING (ma_nhan_vien)
    LEFT JOIN dich_vu USING (ma_dich_vu)
    LEFT JOIN khach_hang kh USING (ma_khach_hang)
    LEFT JOIN hop_dong_chi_tiet USING (ma_hop_dong)
    LEFT JOIN dich_vu_di_kem USING (ma_dich_vu_di_kem)
WHERE
    ma_khach_hang IN (
        SELECT
            ma_khach_hang
        FROM
            khach_hang
            JOIN hop_dong USING(ma_khach_hang)
        WHERE
            ngay_lam_hop_dong BETWEEN '2020-10-01'
            AND '2020-12-30'
    )
    and ma_khach_hang NOT IN (
        SELECT
            ma_khach_hang
        FROM
            khach_hang
            JOIN hop_dong USING(ma_khach_hang)
        WHERE
            ngay_lam_hop_dong BETWEEN '2021-01-01'
            AND '2021-06-30'
    )
GROUP BY
    ma_hop_dong;
    
    
	
-- 13.  Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).


-- solution1
SELECT
    ma_dich_vu_di_kem,
    ten_dich_vu_di_kem,
    sum(so_luong) tong_so_luong_dvdk
FROM
    dich_vu_di_kem
    JOIN hop_dong_chi_tiet USING(ma_dich_vu_di_kem)
GROUP by
    ma_dich_vu_di_kem
having
    tong_so_luong_dvdk >= all(
        select
            sum(so_luong) tong_so_luong_dvdk
        FROM
            hop_dong_chi_tiet
        GROUP by
            ma_dich_vu_di_kem
    );
	
-- solution2	
With count_used AS (
    SELECT
        ma_dich_vu_di_kem,
        ten_dich_vu_di_kem,
        sum(so_luong) tong_so_luong_dvdk
    FROM
        dich_vu_di_kem
        JOIN hop_dong_chi_tiet USING(ma_dich_vu_di_kem)
    GROUP by
        ma_dich_vu_di_kem
)
SELECT
    ma_dich_vu_di_kem,
    ten_dich_vu_di_kem,
    tong_so_luong_dvdk
FROM
    count_used
WHERE
    tong_so_luong_dvdk = (
        SELECT
            max(tong_so_luong_dvdk)
        FROM
            count_used
    );
    


-- 14.  Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị
-- bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).

SELECT
		ma_hop_dong,
		ten_loai_dich_vu,
        ten_dich_vu_di_kem,
        count(ma_dich_vu_di_kem) so_lan_dung_dvdk
    FROM
        dich_vu_di_kem
        JOIN hop_dong_chi_tiet USING(ma_dich_vu_di_kem)
        JOIN hop_dong USING (ma_hop_dong)
        JOIN dich_vu USING (ma_dich_vu)
        JOIN loai_dich_vu USING (ma_loai_dich_vu)
    GROUP by
        ma_dich_vu_di_kem
        HAVING so_lan_dung_dvdk = 1;
        


-- 15.  Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai,
-- dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

SELECT
    ma_nhan_vien,
    ho_ten,
    ten_trinh_do,
    ten_bo_phan,
    so_dien_thoai,
    dia_chi,
    count(hd.ma_nhan_vien) tong_so_hop_dong
FROM
    nhan_vien
    JOIN trinh_do USING (ma_trinh_do)
    JOIN bo_phan USING (ma_bo_phan)
    JOIN hop_dong hd USING (ma_nhan_vien)
where
    year(ngay_lam_hop_dong) BETWEEN 2020
    and 2021
GROUP by
    hd.ma_nhan_vien
having
    tong_so_hop_dong <= 3;	
	
	
	
-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.

DELETE FROM
    nhan_vien nv
WHERE
    NOT EXISTS (
        select
            1
        from
            hop_dong
        WHERE
            ma_nhan_vien = nv.ma_nhan_vien
            and YEAR(ngay_lam_hop_dong) BETWEEN 2019
            and 2021
    )
	
	
	
-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinium lên Diamond, chỉ cập nhật những khách hàng
-- đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ

UPDATE
    khach_hang
set
    ma_loai_khach = 1
WHERE
    ma_khach_hang in (
        select
            t.ma_khach_hang
        from
            (
                SELECT
                    kh.ma_khach_hang,
                    kh.ho_ten,
                    lk.ten_loai_khach,
                    hd.ma_hop_dong,
                    dv.ten_dich_vu,
                    hd.ngay_lam_hop_dong,
                    hd.ngay_ket_thuc,
                    (sum(dvdk.gia * hdct.so_luong) + tmp.gia_dv) tong_tien
                FROM
                    khach_hang kh
                    left JOIN loai_khach lk USING (ma_loai_khach)
                    left join hop_dong hd USING (ma_khach_hang)
                    left join dich_vu dv USING (ma_dich_vu)
                    left JOIN hop_dong_chi_tiet hdct USING (ma_hop_dong)
                    left join dich_vu_di_kem dvdk USING (ma_dich_vu_di_kem)
                    left JOIN (
                        SELECT
                            kh.ma_khach_hang as ma_khach_hang,
                            sum(dv.chi_phi_thue) as gia_dv
                        from
                            khach_hang kh
                            join hop_dong hd USING (ma_khach_hang)
                            join dich_vu dv USING (ma_dich_vu)
                        GROUP by
                            kh.ma_khach_hang
                    ) as tmp USING (ma_khach_hang)
                where
                    ten_loai_khach = 'Platinium'
                GROUP by
                    kh.ma_khach_hang
                HAVING
                    tong_tien > 1000000
            ) t
    );
	
	
-- 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
-- After set CASCADE or SET FOREIGN_KEY_CHECKS=OFF;

-- maybe have to change fk cascade delete on hop_dong, hop_dong_chi_tiet table	
DELETE FROM
    khach_hang kh
WHERE
    EXISTS (
        select
            1
        FROM
            hop_dong
        WHERE
            kh.ma_khach_hang = ma_khach_hang
            and YEAR(ngay_lam_hop_dong) < 2021
    );
	
	
	
-- 19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

UPDATE
    dich_vu_di_kem
set
    gia = gia * 2
WHERE
    ma_dich_vu_di_kem in (
        SELECT
            tmp.ma_dich_vu_di_kem
        FROM
            (
                SELECT
                    ma_dich_vu_di_kem,
                    sum(so_luong) t
                FROM
                    dich_vu
                    JOIN hop_dong USING(ma_dich_vu)
                    JOIN hop_dong_chi_tiet USING(ma_hop_dong)
                GROUP by
                    ma_dich_vu_di_kem
                having
                    t > 10
            ) tmp
    );
	
	
	
-- 20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id
-- (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

SELECT
    ma_nhan_vien as id,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM
    nhan_vien
UNION ALL
SELECT
    ma_khach_hang,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM
    khach_hang;
	
	
	
-- 21.	Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu”
-- và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng nam 2021

create view v_nhan_vien as
select
    ma_nhan_vien,
    ho_ten,
    dia_chi,
    so_dien_thoai
from
    nhan_vien
    JOIN hop_dong USING(ma_nhan_vien)
WHERE
    dia_chi like '%Đà Nẵng%'
    and year(ngay_lam_hop_dong) = 2021;
	
	
	
-- 22.	Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.
   
update v_nhan_vien set dia_chi = 'Liên Chiểu';



-- 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

DELIMITER //
CREATE PROCEDURE sp_xoa_khach_hang(p_ma_khach_hang int)
BEGIN
delete from khach_hang WHERE ma_khach_hang = p_ma_khach_hang;
END
// DELIMITER ;



-- 24.	Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với yêu cầu sp_them_moi_hop_dong phải
-- thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

DELIMITER // 
CREATE PROCEDURE sp_them_moi_hop_dong
(
  p_ma_hop_dong int,
  p_ngay_lam_hop_dong date,
  p_ngay_ket_thuc date, 
  p_tien_dat_coc double,
  p_ma_nhan_vien int, 
  p_ma_khach_hang int,
  p_ma_dich_vu int
) 
BEGIN 
DECLARE lastid int;
select 
  max(ma_hop_dong) into lastid 
from 
  hop_dong;
  
if (p_ma_hop_dong <> lastid + 1) THEN
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Invalid Id';
ELSEIF (p_ngay_lam_hop_dong is null) THEN
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Invalid Start Date';
 ELSEIF (p_ma_nhan_vien not in (select ma_nhan_vien from nhan_vien)) then
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Invalid Ma Nhan Vien';
  ELSEIF (p_ma_khach_hang not in (select ma_khach_hang from khach_hang)) then
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Invalid Mha Khach Hang';
  ELSEIF (p_ma_dich_vu not in (select ma_dich_vu from dich_vu)) then
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Invalid Ma Dich Vu';
else INSERT INTO hop_dong (
  ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, 
  ma_nhan_vien, ma_khach_hang, ma_dich_vu
) VALUE(
  p_ma_hop_dong, p_ngay_lam_hop_dong, p_ngay_ket_thuc, p_tien_dat_coc, 
  p_ma_nhan_vien, p_ma_khach_hang, p_ma_dich_vu
);
end if;
END 
// DELIMITER ;



-- 25.	Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì hiển thị tổng số lượng bản ghi
-- còn lại có trong bảng hop_dong ra giao diện console của database.

DELIMITER //
CREATE TRIGGER tr_xoa_hop_dong
AFTER DELETE on hop_dong FOR EACH ROW
BEGIN
set @c= (select count(*) from hop_dong);
signal SQLSTATE '01000' set MESSAGE_TEXT = @c;
END
// DELIMITER ;

delete from hop_dong where ma_hop_dong =1;



-- 26.	Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không,
-- với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, 
--nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.

DELIMITER //
CREATE trigger tr_cap_nhat_hop_dong
after UPDATE on hop_dong FOR EACH ROW
BEGIN
if new.ngay_lam_hop_dong + 2 > new.ngay_ket_thuc then signal SQLSTATE '02000' set MESSAGE_TEXT = 'Invaild start date';
end if;
END
// DELIMITER ;



-- 27.	Tạo Function thực hiện yêu cầu sau:
-- a.	Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
-- b.	Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng
-- mà khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên
-- toàn bộ các lần làm hợp đồng). Mã của khách hàng được truyền vào như là 1 tham số của function này.

SET GLOBAL log_bin_trust_function_creators = 1;


DELIMITER //
create FUNCTION func_dem_dich_vu()
RETURNS  int
BEGIN
DECLARE res int;
select count(*) INTO res from (select sum(chi_phi_thue) t from dich_vu
join hop_dong using(ma_dich_vu)
group by ma_dich_vu
having t > 2000000) as tmp;
return res;
END
// DELIMITER ;
select func_dem_dich_vu();


DELIMITER //
CREATE FUNCTION func_tinh_thoi_gian_hop_dong(p_ma_khach_hang int)
RETURNS int
begin
DECLARE res int;
select max(tmp.t) into res from (select datediff(ngay_ket_thuc, ngay_lam_hop_dong) t from hop_dong
WHERE ma_khach_hang= p_ma_khach_hang) as tmp;
RETURN res;
end
// DELIMITER ;
select func_tinh_thoi_gian_hop_dong(5);



-- 28.	Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ
-- đầu năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng dich_vu) và xóa những hop_dong
-- sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng hop_dong) và những bản liên quan khác.

DELIMITER //
CREATE PROCEDURE sp_xoa_dich_vu_va_hd_room()
BEGIN
SET @myvar := (SELECT GROUP_CONCAT(ma_hop_dong SEPARATOR ',')  from dich_vu
JOIN loai_dich_vu using(ma_loai_dich_vu)
JOIN hop_dong using(ma_dich_vu)
WHERE ten_loai_dich_vu = 'Room' and  year(ngay_lam_hop_dong) BETWEEN 2015 and 2020);

DELETE FROM hop_dong_chi_tiet  WHERE FIND_IN_SET(ma_hop_dong,@myvar);
DELETE FROM hop_dong  WHERE FIND_IN_SET(ma_hop_dong,@myvar);
DELETE from dich_vu
WHERE ma_dich_vu in ( SELECT DISTINCT
			ma_dich_vu
		FROM
			hop_dong
		WHERE
			 FIND_IN_SET(ma_hop_dong,@myvar));
END
// DELIMITER ;
call sp_xoa_dich_vu_va_hd_room();