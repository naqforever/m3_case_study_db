-- department
insert into department (id, name) values (1, 'Marketing');
insert into department (id, name) values (2, 'Legal');
insert into department (id, name) values (3, 'Human Resources');
insert into department (id, name) values (4, 'Legal');
insert into department (id, name) values (5, 'Sales');
insert into department (id, name) values (6, 'Training');

-- degree
insert into degree (id, name) values (1, 'Undergraduate');
insert into degree (id, name) values (2, 'Master');
insert into degree (id, name) values (3, 'DOCTER');
insert into degree (id, name) values (4, 'PROFESSOR');
insert into degree (id, name) values (5, 'College');
insert into degree (id, name) values (6, 'University');
insert into degree (id, name) values (7, 'Bacherlor');
insert into degree (id, name) values (8, 'Associate');

-- position
insert into position (id, name) values (1, 'Manager Employee');
insert into position (id, name) values (2, 'Database Administrator');
insert into position (id, name) values (3, 'Registered receptionist');
insert into position (id, name) values (4, 'Structural Analysis Engineer');
insert into position (id, name) values (5, 'Budget/Accounting Analyst');
insert into position (id, name) values (6, 'Environmental Specialist');
insert into position (id, name) values (7, 'Attendant');
insert into position (id, name) values (8, 'Supervisor');
insert into position (id, name) values (9, 'security');
insert into position (id, name) values (10, 'HR');
insert into position (id, name) values (11, 'Sales');
insert into position (id, name) values (12, 'Director');
insert into position (id, name) values (13, 'Chef');

-- customer type
INSERT INTO customer_type(`name`) value('Diamond'),('Planium'),('Silver'),('Member'),('Retail'),('Gold');

-- rent type
INSERT INTO rent_type(`name`) value('Day'),('Month'),('Year'),('Hour');

-- attach service
INSERT INTO attach_service(`name`, price, unit, status) value ('laundry', 3, 'kg', 'new');
INSERT INTO attach_service(`name`, price, unit, status) value ('ciname', 2, 'ticket', 'on');
INSERT INTO attach_service(`name`, price, unit, status) value ('taxi', 1, 'km', 'off');
INSERT INTO attach_service(`name`, price, unit, status) value ('gym', 2, 'hour', 'on');
INSERT INTO attach_service(`name`, price, unit, status) value ('massage', 8, 'ticket', 'on');
INSERT INTO attach_service(`name`, price, unit, status) value ('karaoke', 12, 'hour', 'on');

-- customer
insert into customer (fullname, birthday, gender, identify_number, phone, email, address, customer_type_id) values ('Winston Van der Son', '1973-01-25', 1, '51625-002', '150-638-9355', 'wvang@merriam-webster.com', 'Quang Nam', 1);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Chevy Stanaway', '1981-07-14', 0, '51625-002', '172-626-0746', 'cstanawayh@multiply.com', '9 Meadow Ridge Parkway', 1);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Nolan Pflieger', '1994-10-23', 1, '51625-002','316-568-2767', 'npfliegeri@artisteer.com', '8 Straubel Alley', 5);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Blanche Bonnyson', '1997-10-05', 1, '51625-002','312-274-1325', 'bbonnysonj@harvard.edu', '9 Longview Crossing', 3);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Scott Penburton', '1997-07-30', 0, '51625-002','646-810-1655', 'spenburtonk@imageshack.us', '02056 Spaight Way', 1);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Vinson Hunting', '2005-08-08', 1, '51625-002','457-893-9840', 'vhuntingl@123-reg.co.uk', '27 Twin Pines Way', 2);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Gabriellia Lepick', '1980-03-18', 0, '51625-002','493-593-5681', 'glepickm@microsoft.com', '28429 Independence Parkway',2);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Vaughn Olivey', '1959-01-25', 1, '971-529-2866', '493-593-5681','voliveyn@walmart.com', '72 Doe Crossing Crossing', 3);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Elaine Oxton', '1960-03-25', 1, '143-972-2973', '493-593-5681','eoxtono@nymag.com', '3 Hagan Hill', 5);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Stephanus Gibbieson', '1962-03-25', 1, '51625-002', '456-807-4184', 'sgibbiesonp@mlb.com', '02676 Drewry Lane', 5);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Hendrika Peare', '1989-04-14', 1, '51625-002','408-404-2547', 'hpeareq@dagondesign.com', 'vinh', 4);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Torin Sellors', '2000-08-18', 0, '51625-002','504-394-9756', 'tsellorsr@symantec.com', 'Quang Nam', 3);
insert into customer (fullname, birthday, gender,identify_number, phone, email, address, customer_type_id) values ('Gisella Legan', '1965-07-20', 0, '51625-002','103-386-8874', 'glegans@feedburner.com', 'Quang Ngai', 1);


-- employee
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (1, 'Sandy Pashan', '1961-01-15', '37000-727', 1163.08, '663-959-9605', 'spashan0@bandcamp.com', '5 Roth Road', 6, 5, 4);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (2, 'Philipa Kennerley', '1954-11-14', '48951-1178', 1313.71, '587-113-9816', 'pkennerley1@sourceforge.net', '5 Union Pass', 5, 1, 3);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (3, 'Mahalia Bigland', '1961-04-03', '0406-9959', 2347.75, '369-457-9519', 'mbigland2@harvard.edu', '922 Gateway Alley', 6, 6, 6);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (4, 'Quillan Rewcastle', '1988-08-18', '53157-300', 3124.24, '941-396-9009', 'qrewcastle3@unc.edu', '734 John Wall Terrace', 5, 4, 5);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (5, 'Joella Skilbeck', '1968-09-15', '61314-225', 1061.98, '847-249-3629', 'jskilbeck4@ox.ac.uk', '577 Everett Park', 2, 2, 1);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (6, 'Evangelin Grayshan', '1984-05-31', '51334-882', 2107.3, '253-637-2071', 'egrayshan5@reuters.com', '2 Union Place', 4, 1, 3);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (7, 'Mavis Mattiuzzi', '1995-06-03', '54868-0520', 2948.05, '851-771-0858', 'mmattiuzzi6@acquirethisname.com', '77 Kensington Trail', 5, 5, 4);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (8, 'Virgilio Jaze', '1979-12-15', '64764-253', 3895.07, '597-347-4065', 'vjaze7@ftc.gov', '22 4th Point', 6, 5, 2);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (9, 'Annabela Pitherick', '1950-12-01', '36987-1190', 2880.58, '528-905-6627', 'apitherick8@ed.gov', '0 Lighthouse Bay Junction', 3, 2, 2);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (10, 'Rickert Freshwater', '1992-06-16', '36987-2899', 2300.7, '271-319-5402', 'rfreshwater9@biglobe.ne.jp', '73 Clemons Avenue', 3, 6, 6);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (11, 'Trisha Coton', '1968-11-15', '16853-1305', 2971.4, '914-126-8308', 'tcotona@scribd.com', '04 Del Mar Circle', 4, 4, 5);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (12, 'Wat Eckersall', '1980-06-02', '0268-0153', 1313.17, '713-338-8129', 'weckersallb@4shared.com', '302 Manitowish Avenue', 6, 6, 6);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (13, 'Gabi Tidman', '1994-05-13', '0615-2525', 3253.19, '324-999-3543', 'gtidmanc@goo.gl', '85165 Eagan Hill', 4, 1, 6);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (14, 'Constantin Treadway', '1952-01-22', '43857-0101', 2344.88, '586-507-1116', 'ctreadwayd@webs.com', '5448 Graedel Hill', 3, 4, 1);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (15, 'Amalie Linfitt', '1964-12-26', '10237-629', 2191.54, '640-545-4045', 'alinfitte@tumblr.com', '6400 Mifflin Parkway', 5, 1, 3);
insert into employee (id, fullname, birthday, identify_number, salary, phone, email, address, position_id, degree_id, department_id) values (16, 'Leola Halward', '1987-03-08', '49999-895', 2572.72, '410-710-1004', 'lhalwardf@miibeian.gov.cn', '681 Dexter Parkway', 6, 4, 1);

-- service type
INSERT INTO service_type(`name`) value('Villa'),('House'),('Room');

-- service
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Villa Sweet', 23, 120, 10, 'other', 'no comment', 12, 5, 1,1);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Villa Couple', 2, 120, 10, 'other', 'no comment', 12, 5, 1,2);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Villa Family', 6, 120, 10, 'other', 'no comment', 12, 5, 1,3);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Villa Standard', 8, 120, 10, 'other', 'no comment', 12, 5, 1,4);

INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('House Sweet', 23, 120, 10, 'other', 'no comment', 12, 5, 2,1);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('House Couple', 23, 120, 10, 'other', 'no comment', 12, 5, 2,2);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('House Family', 23, 120, 10, 'other', 'no comment', 12, 5, 2,3);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('House Standard', 23, 120, 10, 'other', 'no comment', 12, 5, 2,4);

INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Room Sweet', 23, 120, 10, 'other', 'no comment', NULL, 5, 3,1);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Room Couple', 23, 120, 10, 'other', 'no comment', NULL, 5, 3,2);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Room Family', 23, 120, 10, 'other', 'no comment', NULL, 5, 3,3);
INSERT INTO service (`name`, area, price, max_people, standar_room, description_other_convinience, pool_area, floor_number, service_type_id, rent_type_id)
value ('Room Standard', 23, 120, 10, 'other', 'no comment', NULL, 5, 3,4);

-- contract
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-07-30', '2021-04-20', 599, 5, 5, 6);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-01-15', '2021-01-28', 29, 1, 8, 6);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-05-11', '2020-12-14', 974, 1, 3, 3);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-10-10', '2021-04-06', 590, 7, 5, 4);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-08-17', '2021-12-07', 458, 9, 1, 10);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-11-28', '2021-01-17', 254, 13, 10, 7);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-04-14', '2021-12-03', 901, 4, 2, 6);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-01-17', '2021-03-11', 96, 6, 1, 12);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-10-28', '2021-10-05', 667, 3, 8, 5);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-06-09', '2021-02-14', 740, 5, 12, 5);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-01-24', '2021-11-23', 834, 12, 1, 6);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-02-21', '2021-07-17', 688, 4, 11, 9);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-03-16', '2021-03-29', 921, 3, 10, 7);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-12-02', '2021-01-09', 67, 14, 4, 6);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-10-25', '2021-11-25', 604, 13, 10, 12);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-08-28', '2021-01-30', 893, 11, 8, 9);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-08-04', '2021-12-09', 979, 8, 10, 12);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-01-25', '2021-07-28', 367, 3, 6, 12);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-11-19', '2021-06-15', 577, 4, 1, 8);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-06-14', '2021-10-09', 660, 6, 12, 8);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-02-01', '2021-07-24', 413, 5, 9, 3);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2021-09-16', '2021-03-24', 474, 8, 13, 11);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-06-27', '2021-10-21', 856, 11, 5, 8);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-03-30', '2021-10-08', 954, 14, 2, 10);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-02-28', '2021-01-28', 333, 14, 10, 12);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-10-17', '2021-08-14', 885, 4, 1, 5);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-08-31', '2021-03-04', 190, 6, 9, 9);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-11-10', '2021-04-20', 991, 7, 7, 8);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2019-12-31', '2021-02-18', 960, 9, 5, 5);
insert into contract (start_date, end_date, down_payment, empployee_id, customer_id, service_id) values ('2020-11-21', '2021-06-11', 700, 4, 11, 4);

-- contract detail
insert into contract_detail (quantity, contract_id, attach_service_id) values (87, 8, 5);
insert into contract_detail (quantity, contract_id, attach_service_id) values (90, 8, 5);
insert into contract_detail (quantity, contract_id, attach_service_id) values (4, 27, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (91, 13, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (41, 2, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (18, 10, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (12, 2, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (69, 3, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (97, 4, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (52, 2, 5);
insert into contract_detail (quantity, contract_id, attach_service_id) values (28, 26, 5);
insert into contract_detail (quantity, contract_id, attach_service_id) values (68, 14, 2);
insert into contract_detail (quantity, contract_id, attach_service_id) values (46, 23, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (36, 4, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (10, 27, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (96, 18, 2);
insert into contract_detail (quantity, contract_id, attach_service_id) values (43, 27, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (95, 8, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (39, 5, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (87, 17, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (51, 11, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (78, 8, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (92, 2, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (92, 7, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (38, 11, 5);
insert into contract_detail (quantity, contract_id, attach_service_id) values (73, 20, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (99, 20, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (23, 21, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (92, 3, 4);
insert into contract_detail (quantity, contract_id, attach_service_id) values (92, 4, 3);
insert into contract_detail (quantity, contract_id, attach_service_id) values (92, 4, 1);
insert into contract_detail (quantity, contract_id, attach_service_id) values (23, 8, 6);