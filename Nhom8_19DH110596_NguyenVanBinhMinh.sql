--CREATE TABLE
CREATE TABLE Nhan_vien
(   
    MaNV char(7) PRIMARY KEY,
    CMND number(12) NOT NULL UNIQUE,
    Ho_lot nvarchar2(30) NOT NULL,
    TenNV nvarchar2(20) NOT NULL,
    Tuoi number(2) default 18,
    Gioi_tinh nvarchar2(3),
    SDT number(12),
    Chuc_vu nvarchar2(30) DEFAULT N'Nhân viên',
    CONSTRAINT CHK_Gioi_tinh CHECK (Gioi_tinh IN ('Nam', 'N?')),
    CONSTRAINT CHK_Chuc_vu CHECK (Chuc_vu IN ('Nhân viên', 'Qu?n lý'))
);

create table Co_so
(
    Ma_co_so char(7) PRIMARY KEY,
    Ten_co_so nvarchar2(30) NOT NULL,
    Dia_chi nvarchar2(60),
    Tinh_trang nvarchar2(20) default N'Ho?t ??ng' 
    CONSTRAINT CHK_Tinh_trang CHECK (Tinh_trang IN ('Ho?t ??ng', 'Ng?ng ho?t ??ng')),
    Loai_co_so nvarchar2(25) CHECK (Loai_co_so IN ('Kho','Kho l?nh','Kho trung tâm phân ph?i','Chi nhánh'))
);


create table Chi_tiet_nhan_vien
(
    MaNV char(7) REFERENCES Nhan_vien(MaNV),
    Ca number(1),
    Ma_NQL char(7) CONSTRAINT FK_MaNQL REFERENCES Nhan_vien(MaNV) , 
    Ma_co_so char(7) REFERENCES Co_so(Ma_co_so)
);

create table Tai_xe
(
    Ma_tai_xe char(7) PRIMARY KEY,
    Ten_tai_xe nvarchar2(20),
    Ca number(1),
    Tuyen nvarchar2(30)
);

create table Xe_van_chuyen
(
     So_xe varchar2(12) PRIMARY KEY,
     Loai_xe nvarchar2(20),
     Hang nvarchar2(20)
);

create table Phan_cong
(
    So_xe varchar2(12) REFERENCES Xe_van_chuyen(So_xe),
    Ma_tai_xe char(7) REFERENCES Tai_xe(Ma_tai_xe)
);

create table Nha_cung_cap
(
    MaNCC char(7) PRIMARY KEY,
    TenNCC nvarchar2(30),
    Dia_chi nvarchar2(60),
    SDT number(12),
    Tinh_Trang nvarchar2(15) default N'Ho?t ??ng' 
    CONSTRAINT CHK_Tinh_trang_NCC
    CHECK (Tinh_trang IN ('Ho?t ??ng', 'Ng?ng ho?t ??ng'))
);

create table Lo_hang
(
    MaLo char(7) PRIMARY KEY,
    Tong_so_thung integer,
    So_xe varchar2(12) REFERENCES Xe_van_chuyen(So_xe)
);

create table Thung
(
    Ma_Thung char(7) PRIMARY KEY,
    Tinh_trang nvarchar2(12) default N'Nguyên ki?n'
    CONSTRAINT CHK_Tinh_trang_Thung
    CHECK (Tinh_trang IN ('Nguyên ki?n','?ã m?','H?ng'))
);

create table Don_Vi_Tinh
(
    MaDVT char(7) PRIMARY KEY,
    TenDVT nvarchar2(20) 
);

create table Loai_Nguyen_Lieu
(
    MaLNL char(7) PRIMARY KEY,
    TenLNL nvarchar2(30),
    MaNCC char(7) REFERENCES Nha_cung_cap(MaNCC)
);

create table Nguyen_Lieu
(
    MaNL char(7) PRIMARY KEY,
    TenNL nvarchar2(30),
    Don_gia float,
    MaLNL char(7) REFERENCES Loai_Nguyen_Lieu(MaLNL),
    MaDVT char(7) REFERENCES Don_Vi_Tinh(MaDVT)
);

create table Loai_San_Pham
(
    MaLSP char(7) PRIMARY KEY,
    TenLSP nvarchar2(30)
);

create table San_Pham
(
    MaSP char(7) PRIMARY KEY,
    TenSP nvarchar2(30),
    MaLSP char(7) REFERENCES Loai_San_Pham(MaLSP),
    MaDVT char(7) REFERENCES Don_Vi_Tinh(MaDVT)
);

create table CT_San_Pham
(
    MaSP char(7) REFERENCES San_Pham(MaSP),
    MaNL char(7) REFERENCES Nguyen_Lieu(MaNL),
    So_luong number(2)
);

create table Bien_Dong_Gia
(
    MaSP char(7) REFERENCES San_Pham(MaSP),
    MaNV char(7) REFERENCES Nhan_vien(MaNV),
    Don_gia float default 1000,
    Ngay_cap_nhat date default SYSDATE
);

create table Khach_hang
(
    MaKH char(7) PRIMARY KEY,
    SDT_KH number(12),
    Ho_lot nvarchar2(20),
    Ten_KH nvarchar2(20)
);

create table CT_lo_hang
(
    MaLo char(7) REFERENCES Lo_hang(MaLo),
    Ma_Thung char(7) REFERENCES Thung(Ma_Thung)
);

create table CT_Thung
(
    Ma_Thung char(7) REFERENCES Thung(Ma_Thung),
    MaNL char(7) REFERENCES Nguyen_Lieu(MaNL),
    Tong_so_NL integer
);

create table Phieu_nhap 
(
    Ma_phieu_nhap char(7)PRIMARY KEY,
    Ngay_lap_phieu date default SYSDATE,
    Ngay_nhap_hang date default SYSDATE,
    MaNV char(7) REFERENCES Nhan_vien(MaNV),
    Ma_co_so_nhap char(7)CONSTRAINT FK_Ma_co_so_nhap_PN REFERENCES Co_so(Ma_co_so),
    Ma_co_so_xuat char(7)CONSTRAINT FK_Ma_co_so_xuat_PN REFERENCES Co_so(Ma_co_so) 
);

create table Phieu_xuat 
(
    Ma_phieu_xuat char(7)PRIMARY KEY,
    Ngay_lap_phieu date default SYSDATE,
    Ngay_xuat_hang date default SYSDATE,
    MaNV char(7) REFERENCES Nhan_vien(MaNV),
    Ma_co_so_nhap char(7)CONSTRAINT FK_Ma_co_so_nhap_PX REFERENCES Co_so(Ma_co_so),
    Ma_co_so_xuat char(7)CONSTRAINT FK_Ma_co_so_xuat_PX REFERENCES Co_so(Ma_co_so) 
);

create table CT_Phieu_xuat
(
    Ma_phieu_xuat char(7) REFERENCES Phieu_xuat(Ma_phieu_xuat),
    MaLo char(7) REFERENCES Lo_hang(MaLo)
);

create table CT_Phieu_nhap
(
    Ma_phieu_nhap char(7) REFERENCES Phieu_nhap(Ma_phieu_nhap),
    MaLo char(7) REFERENCES Lo_hang(MaLo),
    Thoi_han number(1) default 5,
    CONSTRAINT CHK_Thoi_han
    CHECK (Thoi_han <= 5)
);

create table Hoa_don
(
    SoHD char(7) PRIMARY KEY,
    Ngay_lap_HD date default SYSDATE,
    MaNV char(7) REFERENCES Nhan_vien(MaNV),
    MaKH char(7) REFERENCES Khach_hang(MaKH),
    CONSTRAINT CHK_Tong_tien
    CHECK (Tong_tien >= 1000)
);

create table CT_Hoa_don
(
    SoHD char(7) REFERENCES Hoa_don(SoHD),
    MaSP char(7) REFERENCES San_Pham(MaSP),
    So_luong integer default 1,
    Thanh_tien float default 1000,
    CONSTRAINT CHK_Thanh_tien
    CHECK (Thanh_tien >= 1000),
    CONSTRAINT CHK_So_luong
    CHECK (So_luong >= 1)
);

create table TON_KHO
(
    Thang VARCHAR2(5),
    Nam VARCHAR2(5),
    Ma_nguyen_lieu CHAR(7),
    Ten_nguyen_lieu NVARCHAR2(30),
    So_luong_ton NUMBER(10)
);

ALTER TABLE NHAN_VIEN ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_NV_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED')); 
ALTER TABLE CO_SO ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_CS_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE NHA_CUNG_CAP ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_NCC_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE HOA_DON ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_HD_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE KHACH_HANG ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_KH_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE LOAI_SAN_PHAM ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_LSP_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE SAN_PHAM ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_SP_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE LOAI_NGUYEN_LIEU ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_LNL_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE NGUYEN_LIEU ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_NL_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE THUNG ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_TH_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE LO_HANG ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_LH_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE TAI_XE ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_TX_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE XE_VAN_CHUYEN ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_XVC_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE PHIEU_NHAP ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_PN_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE PHIEU_XUAT ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_PX_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
ALTER TABLE DON_VI_TINH ADD DEL_STATUS VARCHAR2(7) DEFAULT 'ACTIVE' CONSTRAINT CHK_DVT_DEL_STATUS CHECK (DEL_STATUS IN('ACTIVE','DELETED'));
-------------------------------------------------------------------------------------------------------


                                                --INSERT INTO 
-------------------------------------------------------------------------------------------------------
--INSERT INTO
--Nhan_vien
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0921858566',N'Nguy?n',N'V?n A','27','Nam','0929441668',N'Qu?n lý');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0939746452',N'Lê',N'Th? N','25','N?','0785975795',N'Qu?n lý');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0921336765',N'Nguy?n',N'V?n X','27','Nam','0908678264',N'Qu?n lý');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0939161662',N'Lê',N'Thành T','25','Nam','092673345',N'Qu?n lý');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '6729279956',N'Nguy?n',N'V?n C','27','Nam','093925925',N'Nhân viên');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '6657265746',N'Nguy?n',N'V?n D','26','Nam','095875644',N'Nhân viên');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0567527675',N'Nguy?n',N'V?n E','25','Nam','093944258',N'Nhân viên');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0697955722',N'Tr?n',N'H?i ??ng','24','Nam','0978417678',N'Nhân viên');
insert into Nhan_vien ( cmnd, ho_lot, tennv, tuoi, gioi_tinh, sdt, chuc_vu)
values ( '0666848486',N'Tr??ng',N'Vi V??n','25','Nam','0905252599',N'Nhân viên');

--Co_so
insert into Co_so ( ten_co_so, dia_chi, tinh_trang, loai_co_so ) 
values ('Kho 1',N'Qu?n 10',N'Ho?t ??ng','Kho');
insert into Co_so ( ten_co_so, dia_chi, tinh_trang, loai_co_so ) 
values ('Kho 2',N'Qu?n 6',N'Ho?t ??ng','Kho l?nh');
insert into Co_so ( ten_co_so, dia_chi, tinh_trang, loai_co_so ) 
values ('Kho 3',N'Qu?n 2',N'Ho?t ??ng','Kho trung tâm phân ph?i');
insert into Co_so ( ten_co_so, dia_chi, tinh_trang, loai_co_so ) 
values ('Kho 4',N'Qu?n 3',N'Ho?t ??ng','Chi nhánh');

--Chi_tiet_nhan_vien
insert into Chi_tiet_nhan_vien
values ('NV00003','1','NV00001','KH00001');
insert into Chi_tiet_nhan_vien
values ('NV00004','3','NV00002','KL00001');
insert into Chi_tiet_nhan_vien
values ('NV00005','2','NV00006','PP00001');
insert into Chi_tiet_nhan_vien
values ('NV00008','1','NV00007','CN00001');

--Tai_xe
insert into Tai_xe ( ten_tai_xe, ca, tuyen )
values (N'Thành','1',N'Qu?n 10 - Qu?n 6');
insert into Tai_xe ( ten_tai_xe, ca, tuyen )
values (N'Tài','2',N'Qu?n 10 - Qu?n 2');
insert into Tai_xe ( ten_tai_xe, ca, tuyen )
values (N'Phúc','3',N'Qu?n 10 - Qu?n 3');

--Xe_van_chuyen
Insert into Xe_van_chuyen (so_xe, loai_xe, hang)
values (N'59-L2-88888',N'Xe t?i',N'HYUNDAI');
Insert into Xe_van_chuyen (so_xe, loai_xe, hang)
values ('59-N1-66666',N'Xe t?i','HYUNDAI');
Insert into Xe_van_chuyen (so_xe, loai_xe, hang)
values ('59-H2-56789',N'Xe t?i','HYUNDAI');

--Phan_cong
insert into Phan_cong (so_xe, ma_tai_xe)
values ('59-L2-88888','TX00002');
insert into Phan_cong (so_xe, ma_tai_xe)
values ('59-N1-66666','TX00001');
insert into Phan_cong (so_xe, ma_tai_xe)
values ('59-H2-56789','TX00003');

--Nha_cung_cap
insert into Nha_cung_cap ( tenncc, dia_chi, sdt, tinh_trang )
values (N'NCC Chicken','Qu?n 1','0995556658',N'Ho?t ??ng');
insert into Nha_cung_cap ( tenncc, dia_chi, sdt, tinh_trang )
values (N'NCC Vegatables','Qu?n 3','0987865556',N'Ho?t ??ng');
insert into Nha_cung_cap ( tenncc, dia_chi, sdt, tinh_trang )
values (N'NCC Drink','Qu?n 5','0214548529',N'Ho?t ??ng');

--Lo_hang
insert into Lo_hang ( tong_so_thung, so_xe )
values (30,'59-L2-88888');
insert into Lo_hang ( tong_so_thung, so_xe )
values (50,'59-N1-66666');
insert into Lo_hang ( tong_so_thung, so_xe )
values (20,'59-H2-56789');

--Thung
insert into Thung (tinh_trang)
values (N'Nguyên ki?n');
insert into Thung (tinh_trang)
values (N'Nguyên ki?n');
insert into Thung (tinh_trang)
values (N'?ã m?');

--Don_vi_tinh
insert into Don_vi_tinh ( tendvt )
values (N'Thùng');
insert into Don_vi_tinh ( tendvt )
values (N'Con');
insert into Don_vi_tinh ( tendvt )
values (N'Cái');
insert into Don_vi_tinh ( tendvt )
values (N'kg');

--Loai_nguyen_lieu
insert into Loai_nguyen_lieu ( tenlnl, mancc )
values (N'Th?t','NCC0001');
insert into Loai_nguyen_lieu ( tenlnl, mancc )
values (N'Rau','NCC0002');
insert into Loai_nguyen_lieu ( tenlnl, mancc )
values (N'N??c','NCC0003');

--Nguyen_lieu
insert into Nguyen_lieu ( tennl, don_gia, malnl, madvt )
values (N'Cánh gà','20000','LNL0001','DVT0003');
insert into Nguyen_lieu ( tennl, don_gia, malnl, madvt )
values (N'?ùi gà','20000','LNL0001','DVT0003');
insert into Nguyen_lieu ( tennl, don_gia, malnl, madvt )
values (N'?c gà','20000','LNL0001','DVT0003');

--Loai_san_pham
insert into Loai_san_pham ( tenlsp )
values ('Gà');
insert into Loai_san_pham ( tenlsp )
values ('Sandwich');

--San_pham
insert into San_pham ( tensp, malsp, madvt )
values (N'Cánh gà chiên mu?i tiêu chanh','LSP0001','DVT0003');
insert into San_pham ( tensp, malsp, madvt )
values (N'Cánh gà chiên ki?u Pháp','LSP0001','DVT0003');
insert into San_pham ( tensp, malsp, madvt )
values (N'?ùi gà chiên n??c m?m','LSP0001','DVT0003');
insert into San_pham ( tensp, malsp, madvt )
values (N'Sandwich gà s?t phô mai','LSP0001','DVT0003');

--Ct_san_pham
insert into Ct_san_pham 
values ('SP00001','NL00001',50);    
insert into CT_san_pham
values ('SP00002','NL00002',50);
insert into CT_san_pham
values ('SP00003','NL00003',50);

--Bien_dong_gia
insert into Bien_dong_gia
values ('SP00001','NV00001','20000',TO_DATE('10/11/2021', 'dd/mm/yyyy'));
insert into Bien_dong_gia
values ('SP00002','NV00001','20000',TO_DATE('10/11/2021', 'dd/mm/yyyy'));
insert into Bien_dong_gia
values ('SP00003','NV00001','20000',TO_DATE('10/11/2021', 'dd/mm/yyyy'));
insert into Bien_dong_gia
values ('SP00004','NV00001','20000',TO_DATE('10/11/2021', 'dd/mm/yyyy'));

--Khach_hang
insert into Khach_hang ( sdt_kh, ho_lot, ten_kh )
values ('0929441668',N'Ph?m ',N'Gia Kh??ng');
insert into Khach_hang ( sdt_kh, ho_lot, ten_kh )
values ('0939664785',N'Tr?n ',N'V?n Minh');
insert into Khach_hang ( sdt_kh, ho_lot, ten_kh )
values ('0924465758',N'Nguy?n V?n ',N'Bình Minh');

--Ct_lo_hang
insert into Ct_lo_hang
values ('LH00001','TH00001');
insert into Ct_lo_hang
values ('LH00002','TH00002');

--Ct_thung
insert into Ct_thung
values ('TH00001','NL00001',100);
insert into Ct_thung
values ('TH00002','NL00002',100);

--Phieu_nhap
insert into Phieu_nhap (ngay_lap_phieu, ngay_nhap_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('1/1/2022', 'dd/mm/yyyy'),TO_DATE('1/1/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');
insert into Phieu_nhap (ngay_lap_phieu, ngay_nhap_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('10/1/2022', 'dd/mm/yyyy'),TO_DATE('15/1/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');
insert into Phieu_nhap (ngay_lap_phieu, ngay_nhap_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('15/1/2022', 'dd/mm/yyyy'),TO_DATE('20/1/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');

--Phieu_xuat
insert into Phieu_xuat (ngay_lap_phieu, ngay_xuat_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('5/1/2022', 'dd/mm/yyyy'),TO_DATE('7/1/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');
insert into Phieu_xuat (ngay_lap_phieu, ngay_xuat_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('2/4/2022', 'dd/mm/yyyy'),TO_DATE('5/4/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');
insert into Phieu_xuat (ngay_lap_phieu, ngay_xuat_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('12/5/2022', 'dd/mm/yyyy'),TO_DATE('16/5/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');
insert into Phieu_xuat (ngay_lap_phieu, ngay_xuat_hang, manv, ma_co_so_nhap, ma_co_so_xuat)
values (TO_DATE('12/1/2022', 'dd/mm/yyyy'),TO_DATE('16/1/2022', 'dd/mm/yyyy'),'NV00003','PP00001','KH00001');

--Ct_phieu_nhap
insert into Ct_phieu_nhap
values ('PN00001','LH00001',4);
insert into Ct_phieu_nhap
values ('PN00002','LH00002',5);
insert into Ct_phieu_nhap
values ('PN00003','LH00003',4);

--Ct_phieu_xuat
insert into Ct_phieu_xuat
values ('PX00001','LH00001');
insert into Ct_phieu_xuat
values ('PX00002','LH00002');
insert into Ct_phieu_xuat
values ('PX00003','LH00003');
insert into Ct_phieu_xuat
values ('PX00021','LH00002');
insert into Ct_phieu_xuat
values ('PX00022','LH00003');

--Hoa_don
insert into Hoa_don ( ngay_lap_hd, manv, makh )
values (TO_DATE('20/1/2022', 'dd/mm/yyyy'),'NV00003','KH00001');
insert into Hoa_don ( ngay_lap_hd,  manv, makh )
values (TO_DATE('22/1/2022', 'dd/mm/yyyy'),'NV00003','KH00002');
insert into Hoa_don ( ngay_lap_hd, manv, makh )
values (TO_DATE('18/6/2022', 'dd/mm/yyyy'),'NV00003','KH00003');
insert into Hoa_don ( ngay_lap_hd,  manv, makh )
values (TO_DATE('19/6/2022', 'dd/mm/yyyy'),'NV00003','KH00003');

--Ct_hoa_don
insert into Ct_hoa_don
values ('HD00001','SP00001','3');
insert into Ct_hoa_don (sohd, masp, so_luong)
values ('HD00001','SP00003','2');
insert into Ct_hoa_don
values ('HD00002','SP00002','3');
insert into Ct_hoa_don
values ('HD00002','SP00003','2');
insert into Ct_hoa_don
values ('HD00003','SP00001','3');
insert into Ct_hoa_don
values ('HD00003','SP00003','2');
insert into Ct_hoa_don (sohd, masp, so_luong)
values ('HD00003','SP00002','2');
insert into Ct_hoa_don (sohd, masp, so_luong)
values ('HD00021','SP00001','2');

----------------------------------------------------------------------------------

                                                --FUNCTIONS
-------------------------------------------------------------------------------------------------------
--FUNCTIONS
--5 NUMBERS
CREATE OR REPLACE FUNCTION numberZerosString(
 n IN NUMBER
) RETURN VARCHAR2
AS
BEGIN
  RETURN LPAD( n, 5, '0' );
END;
--4 NUMBERS
CREATE OR REPLACE FUNCTION numberFourZerosString(
 n IN NUMBER
) RETURN VARCHAR2
AS
BEGIN
  RETURN LPAD( n, 4, '0' );
END;
--CTHOADON
CREATE OR REPLACE FUNCTION GET_LATEST_PRICE (N IN CHAR, M IN DATE) RETURN FLOAT
AS
R FLOAT;
BEGIN
    SELECT *  
    INTO R
    FROM
        (SELECT DON_GIA FROM Bien_Dong_Gia 
        WHERE N LIKE Bien_Dong_Gia.MASP AND M >= NGAY_CAP_NHAT
        ORDER BY Ngay_cap_nhat desc)
    WHERE ROWNUM = 1;
RETURN R;
END;
--CTHOADON
CREATE OR REPLACE FUNCTION GET_NGAY_LAP_HD (N IN CHAR) RETURN DATE
AS
R DATE;
BEGIN
    SELECT NGAY_LAP_HD
    INTO R
    FROM HOA_DON 
    WHERE N LIKE SOHD;
    RETURN R;
END;
--------------------------------------------------------------------------------------------------------------------
--PROCEDURES-TRIGGER
--1 NHAN VIEN-----------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_NV_ID MAXVALUE 99999 START WITH 1;

--TRIGGER NV
CREATE OR REPLACE TRIGGER TRIG_INSERT_NV
BEFORE INSERT 
ON NHAN_VIEN
FOR EACH ROW
DECLARE
    input_manv CHAR(7);
BEGIN
    :NEW.MANV := TO_CHAR(concat('NV', numberZerosString(SEQ_NV_ID.NEXTVAL)));
END;


--Insert Nhan vien
CREATE  or replace  PROCEDURE PRC_INSERT_NV (
                                            input_cmnd number,
                                            input_holot nvarchar2,
                                            input_tennv nvarchar2,
                                            input_tuoi number,
                                            input_gioi_tinh nvarchar2,
                                            input_sdt char,
                                            input_chucvu nvarchar2
                                            )
AS
BEGIN
    IF input_chucvu IS NULL
    THEN
    INSERT INTO NHAN_VIEN (CMND,HO_LOT,TENNV,TUOI,GIOI_TINH,SDT)
    VALUES(input_cmnd,input_holot,input_tennv,input_tuoi,input_gioi_tinh,input_sdt);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_chucvu IS NOT NULL
    THEN
    INSERT INTO NHAN_VIEN (CMND,HO_LOT,TENNV,TUOI,GIOI_TINH,SDT,CHUC_VU)
    VALUES(input_cmnd,input_holot,input_tennv,input_tuoi,input_gioi_tinh,input_sdt,input_chucvu);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSE
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    END IF;
END;

--------------------------------------------------------------------------------------------------------
--2 INSERT INTO Chi_tiet_nhan_vien
CREATE  or replace PROCEDURE PRC_INSERT_CT_NV (
                                            input_MaNV char,
                                            input_Ca number,
                                            input_MaNQL char,
                                            input_MaCoSo char
                                            )
AS
BEGIN
    INSERT INTO chi_tiet_nhan_vien
    VALUES(input_MaNV,input_Ca,input_MaNQL,input_MaCoSo);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

----------------------------------------------------------
-------------------------------------------------------------------------------------------------------
--3 CO SO
CREATE SEQUENCE SEQ_KHO_ID MAXVALUE 99999 START WITH 00001;
CREATE SEQUENCE SEQ_KHOLANH_ID MAXVALUE 99999 START WITH 00001;
CREATE SEQUENCE SEQ_KHOPHANPHOI_ID MAXVALUE 99999 START WITH 00001;
CREATE SEQUENCE SEQ_KHOCHINHANH_ID MAXVALUE 99999 START WITH 00001;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_CS
BEFORE INSERT 
ON CO_SO
FOR EACH ROW
DECLARE
    input CHAR(7);
BEGIN
    IF :NEW.LOAI_CO_SO LIKE N'Kho'
    THEN    
        :NEW.MA_CO_SO := TO_CHAR(concat('KH', numberZerosString(SEQ_KHO_ID.NEXTVAL)));
        
    ELSIF :NEW.LOAI_CO_SO LIKE N'Kho l?nh'
    THEN    
       :NEW.MA_CO_SO := TO_CHAR(concat('KL', numberZerosString(SEQ_KHOLANH_ID.NEXTVAL)));
            
    ELSIF :NEW.LOAI_CO_SO LIKE N'Kho trung tâm phân ph?i'
    THEN
        :NEW.MA_CO_SO := TO_CHAR(concat('PP', numberZerosString(SEQ_KHOPHANPHOI_ID.NEXTVAL)));
        
    ELSIF :NEW.LOAI_CO_SO LIKE N'Chi nhánh'
    THEN 
        :NEW.MA_CO_SO := TO_CHAR(concat('CN', numberZerosString(SEQ_KHOCHINHANH_ID.NEXTVAL)));
    
    ELSE    
        :NEW.MA_CO_SO := TO_CHAR(concat('KH', numberZerosString(SEQ_KHO_ID.NEXTVAL)));     
    END IF;    
END;

--Insert to COSO-------------------
CREATE  or replace PROCEDURE PRC_INSERT_COSO (
                                            input_ten nvarchar2,
                                            input_diachi nvarchar2,
                                            input_tinhtrang nvarchar2,
                                            input_loai nvarchar2
                                            )
AS
BEGIN
    IF input_loai LIKE N'Kho'
    THEN    
    INSERT INTO CO_SO(TEN_CO_SO,DIA_CHI,TINH_TRANG,LOAI_CO_SO)
    VALUES(input_ten,input_diachi,input_tinhtrang,input_loai);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_loai LIKE N'Kho l?nh'
    THEN    
    INSERT INTO CO_SO(TEN_CO_SO,DIA_CHI,TINH_TRANG,LOAI_CO_SO)
    VALUES(input_ten,input_diachi,input_tinhtrang,input_loai);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS KHO_LANH');
            
    ELSIF input_loai LIKE N'Kho trung tâm phân ph?i'
    THEN
    INSERT INTO CO_SO(TEN_CO_SO,DIA_CHI,TINH_TRANG,LOAI_CO_SO)
    VALUES(input_ten,input_diachi,input_tinhtrang,input_loai);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS PHAN_PHOI');
        
    ELSIF input_loai LIKE N'Chi nhánh'
    THEN 
    INSERT INTO CO_SO(TEN_CO_SO,DIA_CHI,TINH_TRANG,LOAI_CO_SO)
    VALUES(input_ten,input_diachi,input_tinhtrang,input_loai);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS CHI_NHANH');
    
    ELSE    
        INSERT INTO CO_SO(TEN_CO_SO,DIA_CHI,TINH_TRANG)
        VALUES(input_ten,input_diachi,input_tinhtrang);
        DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS DEFAULT FACILITY');      
    END IF;
END;

-------------------------------------
-------------------------------------
--4 KHACH HANG
CREATE SEQUENCE SEQ_KH_ID MAXVALUE 99999 START WITH 1;

--trigger
CREATE OR REPLACE TRIGGER TRIG_INSERT_KH
BEFORE INSERT 
ON KHACH_HANG
FOR EACH ROW
DECLARE
    input CHAR(7);
BEGIN
    :NEW.MAKH := TO_CHAR(concat('KH', numberZerosString(SEQ_KH_ID.NEXTVAL)));
END;

--Insert KhachHang
CREATE  or replace  PROCEDURE PRC_INSERT_KH (
                                            input_sdt number,
                                            input_holot nvarchar2,
                                            input_tenkh nvarchar2   
                                            )
AS
BEGIN
    INSERT INTO KHACH_HANG(SDT_KH,HO_LOT,TEN_KH)
    VALUES(input_sdt,input_holot,input_tenkh);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

-------------------------------------
--5 HOA DON
CREATE SEQUENCE SEQ_HD_ID MAXVALUE 99999 START WITH 1;

--trigger
CREATE OR REPLACE TRIGGER TRIG_INSERT_HD
BEFORE INSERT 
ON HOA_DON
FOR EACH ROW
DECLARE

BEGIN
    :NEW.SOHD := TO_CHAR(concat('HD', numberZerosString(SEQ_HD_ID.NEXTVAL)));
END;

--TRIGGER Cam chinh sua HD
CREATE OR REPLACE TRIGGER TRIG_ALTER_HD
BEFORE INSERT OR UPDATE
ON HOA_DON
FOR EACH ROW
BEGIN
    IF (TRUNC(SYSDATE) > TRUNC(:OLD.NGAY_LAP_HD))
    THEN RAISE_APPLICATION_ERROR(-20011,'You can not alter this form anymore');
    end if;
END;

--TRIGGER Cam chinh sua CT_HD
CREATE OR REPLACE TRIGGER TRIG_ALTER_CT_HD
BEFORE INSERT OR UPDATE
ON CT_HOA_DON
FOR EACH ROW
BEGIN
    IF (TRUNC(SYSDATE) > TRUNC(GET_NGAY_LAP_HD(:NEW.SOHD)))
    THEN RAISE_APPLICATION_ERROR(-20011,'You can not alter this form anymore');
    end if;
END;

--Insert HOA_DON
CREATE  or replace  PROCEDURE PRC_INSERT_HD (
                                            input_ngaylap date,
                                            input_manv char,
                                            input_makh char
                                            )
AS
BEGIN
    IF input_ngaylap IS NULL
    THEN
    INSERT INTO HOA_DON (MANV,MAKH)
    VALUES(input_manv,input_makh);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylap IS NOT NULL
    THEN
    INSERT INTO HOA_DON(NGAY_LAP_HD,MANV,MAKH)
    VALUES(input_ngaylap, input_manv,input_makh);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
--    EXCEPTION WHEN OTHERS THEN
    ELSE
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    
    END IF;
END;

-------------------------------------
--6 DON VI TINH
CREATE SEQUENCE SEQ_DVT_ID MAXVALUE 99999 START WITH 1;

--TRIGGER 
CREATE OR REPLACE TRIGGER TRIG_INSERT_DVT
BEFORE INSERT 
ON DON_VI_TINH
FOR EACH ROW
BEGIN
    :NEW.MADVT := TO_CHAR(concat('DVT', numberFourZerosString(SEQ_DVT_ID.NEXTVAL)));
END;

--Insert DVT
CREATE  or replace  PROCEDURE PRC_INSERT_DVT (                                            
                                            input_tendvt nvarchar2 
                                            )
AS
BEGIN
    INSERT INTO DON_VI_TINH(TENDVT)
    VALUES(input_tendvt);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

-------------------------------------
--7 LOAI SAN PHAM
CREATE SEQUENCE SEQ_LSP_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_LSP
BEFORE INSERT 
ON LOAI_SAN_PHAM
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MALSP := TO_CHAR(concat('LSP', numberFourZerosString(SEQ_LSP_ID.NEXTVAL)));
END;

--Insert Loai_san_pham
CREATE  or replace  PROCEDURE PRC_INSERT_LSP (                                            
                                            input_tenlsp nvarchar2 
                                            )
AS
BEGIN
    INSERT INTO LOAI_SAN_PHAM (TENLSP)
    VALUES(input_tenlsp);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

------------------------------------------------------------------------------------
--8 SAN PHAM
CREATE SEQUENCE SEQ_SP_ID MAXVALUE 99999 START WITH 1;

--TRIGGER insert
CREATE OR REPLACE TRIGGER TRIG_INSERT_SP
BEFORE INSERT 
ON SAN_PHAM
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MASP := TO_CHAR(concat('SP', numberZerosString(SEQ_SP_ID.NEXTVAL)));
END;


--Insert SanPham
CREATE  or replace  PROCEDURE PRC_INSERT_SP (
                                            input_tensp nvarchar2,
                                            input_maloaisp char,
                                            input_madvt char
                                            )
AS
BEGIN
    INSERT INTO SAN_PHAM (TENSP,MALSP,MADVT)
    VALUES(input_tensp,input_maloaisp,input_madvt);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

--------------------------------------------------------------------
--9 CHITIETHOADON
--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_CTHD_THANH_TIEN
BEFORE INSERT OR UPDATE ON CT_HOA_DON
FOR EACH ROW
BEGIN
	:NEW.THANH_TIEN:=(:NEW.SO_LUONG * GET_LATEST_PRICE(:NEW.MASP,GET_NGAY_LAP_HD(:NEW.SOHD)));
END;

--Insert CThoadon
CREATE  or replace  PROCEDURE PRC_INSERT_CTHD (
                                            input_sohd CHAR,
                                            input_masp char,
                                            input_soluong NUMBER
                                            )
AS
BEGIN
    INSERT INTO CT_HOA_DON (sohd,masp,so_luong)
    VALUES(input_sohd,input_masp,input_soluong);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

------------------------------------------------------------------------------------
--10 Insert BIENDONGGIA
CREATE  or replace  PROCEDURE PRC_INSERT_BDG (
                                            input_masp CHAR,
                                            input_manv char,
                                            input_dongia float,
                                            input_ngaycapnhat date
                                            )
AS
BEGIN
    IF input_ngaycapnhat IS NULL
    THEN
    INSERT INTO BIEN_DONG_GIA (MASP,MANV,DON_GIA)
    VALUES(input_masp,input_manv,input_dongia);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    ELSIF input_ngaycapnhat IS NOT NULL
    THEN
    INSERT INTO BIEN_DONG_GIA
    VALUES(input_masp,input_manv,input_dongia,input_ngaycapnhat);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSE
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    END IF;
END;

------------------------------------------------------------------------------------
--11 PHIEU XUAT
CREATE SEQUENCE SEQ_PX_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_PX
BEFORE INSERT 
ON PHIEU_XUAT
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MA_PHIEU_XUAT := TO_CHAR(concat('PX', numberZerosString(SEQ_PX_ID.NEXTVAL)));
END;
--Insert PHIEUXUAT
CREATE SEQUENCE SEQ_PX_ID MAXVALUE 99999 START WITH 1;

CREATE  or replace  PROCEDURE PRC_INSERT_PX (
                                            input_ngaylapphieu date,
                                            input_manv char,
                                            input_cosonhap char,
                                            input_cosoxuat char,
                                            input_ngayxuathang date
                                            )
AS
BEGIN
    IF input_ngaylapphieu IS NULL AND input_ngayxuathang IS NULL
    THEN
    
    INSERT INTO PHIEU_XUAT (MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT)
    VALUES(input_manv,input_cosonhap,input_cosoxuat);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NOT NULL AND input_ngayxuathang IS NOT NULL
    THEN
    
    INSERT INTO PHIEU_XUAT (NGAY_LAP_PHIEU,MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT,NGAY_XUAT_HANG)
    VALUES(input_ngaylapphieu,input_manv,input_cosonhap,input_cosoxuat,input_ngayxuathang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NULL AND input_ngayxuathang IS NOT NULL
    THEN
    
    INSERT INTO PHIEU_XUAT (MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT,NGAY_XUAT_HANG)
    VALUES(input_manv,input_cosonhap,input_cosoxuat,input_ngayxuathang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NOT NULL AND input_ngayxuathang IS NULL
    THEN
    
    INSERT INTO PHIEU_XUAT (NGAY_LAP_PHIEU,MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT)
    VALUES(input_ngaylapphieu,input_manv,input_cosonhap,input_cosoxuat);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSE
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    END IF;
END;

------------------------------------------------------------------------------------
--12 PHIEU NHAP
CREATE SEQUENCE SEQ_PN_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_PN
BEFORE INSERT 
ON PHIEU_NHAP
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MA_PHIEU_NHAP := TO_CHAR(concat('PN', numberZerosString(SEQ_PN_ID.NEXTVAL)));
END;

--Insert PHIEU_NHAP
CREATE  or replace  PROCEDURE PRC_INSERT_PN (
                                            input_ngaylapphieu date,
                                            input_manv char,
                                            input_cosonhap char,
                                            input_cosoxuat char,
                                            input_ngaynhaphang date
                                            )
AS
BEGIN
    IF input_ngaylapphieu IS NULL AND input_ngaynhaphang IS NULL
    THEN
    
    INSERT INTO PHIEU_NHAP (MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT)
    VALUES(input_manv,input_cosonhap,input_cosoxuat);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NOT NULL AND input_ngaynhaphang IS NOT NULL
    THEN
    
    INSERT INTO PHIEU_NHAP(NGAY_LAP_PHIEU,MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT,NGAY_NHAP_HANG)
    VALUES(input_ngaylapphieu,input_manv,input_cosonhap,input_cosoxuat,input_ngaynhaphang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NULL AND input_ngaynhaphang IS NOT NULL
    THEN
    
    INSERT INTO PHIEU_NHAP (MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT,NGAY_NHAP_HANG)
    VALUES(input_manv,input_cosonhap,input_cosoxuat,input_ngaynhaphang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSIF input_ngaylapphieu IS NOT NULL AND input_ngaynhaphang IS NULL
    THEN

    INSERT INTO PHIEU_NHAP (NGAY_LAP_PHIEU,MANV,MA_CO_SO_NHAP,MA_CO_SO_XUAT)
    VALUES(input_ngaylapphieu,input_manv,input_cosonhap,input_cosoxuat);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    
    ELSE
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    END IF;
END;

------------------------------------------------------------------------------------
--13 TAI XE
CREATE SEQUENCE SEQ_TX_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_TX
BEFORE INSERT 
ON TAI_XE
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MA_TAI_XE := TO_CHAR(concat('TX', numberZerosString(SEQ_TX_ID.NEXTVAL)));
END;

--Insert TAIXE
CREATE  or replace  PROCEDURE PRC_INSERT_TX (
                                            input_tentx nvarchar2,
                                            input_ca number,
                                            input_tuyen nvarchar2
                                            )
AS
BEGIN
    INSERT INTO TAI_XE (TEN_TAI_XE,CA,TUYEN)
    VALUES(input_tentx,input_ca,input_tuyen);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

------------------------------------------------------------------------------------
--14 Insert xevanchuyen
CREATE  or replace  PROCEDURE PRC_INSERT_XVC (
                                            input_soxe varchar2,
                                            input_loaixe nvarchar2,
                                            input_hang nvarchar2
                                            )
AS
BEGIN
    INSERT INTO XE_VAN_CHUYEN (SO_XE,LOAI_XE,HANG)
    VALUES(input_soxe,input_loaixe,input_hang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

------------------------------------------------------------------------------------
--15 Insert phancong
CREATE  or replace  PROCEDURE PRC_INSERT_PC (
                                            input_matx char,
                                            input_soxe varchar2
                                            )
AS
BEGIN
    INSERT INTO PHAN_CONG
    VALUES(input_matx,input_soxe);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;
-----------------------------------------------------------------------------------
--16 LO HANG
CREATE SEQUENCE SEQ_LH_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_LH
BEFORE INSERT 
ON LO_HANG
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MALO := TO_CHAR(concat('LH', numberZerosString(SEQ_LH_ID.NEXTVAL)));
END;

--Insert Lohang
CREATE  or replace  PROCEDURE PRC_INSERT_LH (
                                            input_tongthung number,
                                            input_soxe varchar2
                                            )
AS
BEGIN
    INSERT INTO LO_HANG (TONG_SO_THUNG,SO_XE)
    VALUES(input_tongthung,input_soxe);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

-------------------------------------
--17 THUNG
CREATE SEQUENCE SEQ_TH_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_TH
BEFORE INSERT 
ON THUNG
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MA_THUNG := TO_CHAR(concat('TH', numberZerosString(SEQ_TH_ID.NEXTVAL)));
END;

--Insert Thung
CREATE  or replace  PROCEDURE PRC_INSERT_TH (
                                            input_tinhtrang varchar2
                                            )
AS
BEGIN
    INSERT INTO THUNG (TINH_TRANG)
    VALUES(input_tinhtrang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

--------------------------------------------------------------------------------------------------------------------------
--18 Insert CT lo hang
CREATE  or replace  PROCEDURE PRC_INSERT_CTLH (
                                            input_malo char,
                                            input_mathung char
                                            )
AS
BEGIN
    INSERT INTO CT_LO_HANG
    VALUES(input_malo,input_mathung);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

----------------------------------------------------------
--19 Insert CT nhap hang
create or replace PROCEDURE PRC_INSERT_CTPN (
                                            input_mapn char,
                                            input_malo char,
                                            input_thoihan number
                                            )
AS
BEGIN
    IF input_thoihan > 5
    THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
    ELSE
    INSERT INTO CT_PHIEU_NHAP
    VALUES(input_mapn,input_malo,input_thoihan);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    PRC_GET_TON_KHO;
    END IF;
END;

------------------------------------------------------------------
--20 Insert CT XUAT hang
CREATE  or replace  PROCEDURE PRC_INSERT_CTPX (
                                            input_mapx char,
                                            input_malo char
                                            )
AS
BEGIN
    INSERT INTO CT_PHIEU_XUAT
    VALUES(input_mapx,input_malo);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;
-------------------------------------
--21 NHA CUNG CAP
CREATE SEQUENCE SEQ_NCC_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_NCC
BEFORE INSERT 
ON NHA_CUNG_CAP
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MANCC := TO_CHAR(concat('NCC', numberFourZerosString(SEQ_NCC_ID.NEXTVAL)));
END;

--Insert NHA CUNG CAP
CREATE SEQUENCE SEQ_NCC_ID MAXVALUE 99999 START WITH 1;

CREATE  or replace  PROCEDURE PRC_INSERT_NCC (
                                            input_tenncc nvarchar2,
                                            input_diachi nvarchar2,
                                            input_sdt number,
                                            input_tinhtrang nvarchar2
                                            )
AS
BEGIN
    INSERT INTO NHA_CUNG_CAP(TENNCC,DIA_CHI,SDT,TINH_TRANG)
    VALUES(input_tenncc,input_diachi,input_sdt,input_tinhtrang);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

-------------------------------------------------------------------
--22 LOAI NGUYEN LIEU
CREATE SEQUENCE SEQ_LNL_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_LNL
BEFORE INSERT 
ON LOAI_NGUYEN_LIEU
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MALNL := TO_CHAR(concat('LNL', numberFourZerosString(SEQ_LNL_ID.NEXTVAL)));
END;

--Insert loai nguyen lieu
CREATE  or replace  PROCEDURE PRC_INSERT_LNL (
                                            input_tenlnl nvarchar2,
                                            input_mancc char
                                            )
AS
BEGIN
    INSERT INTO LOAI_NGUYEN_LIEU(TENLNL,MANCC)
    VALUES(input_tenlnl,input_mancc);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

--------------------------------------------------------------------
--23 NGUYEN LIEU
CREATE SEQUENCE SEQ_NL_ID MAXVALUE 99999 START WITH 1;

--TRIGGER
CREATE OR REPLACE TRIGGER TRIG_INSERT_NL
BEFORE INSERT 
ON NGUYEN_LIEU
FOR EACH ROW
DECLARE

BEGIN
    :NEW.MANL := TO_CHAR(concat('NL', numberZerosString(SEQ_NL_ID.NEXTVAL)));
END;

--Insert nguyen lieu
CREATE  or replace  PROCEDURE PRC_INSERT_NL (
                                            input_tenlnl nvarchar2,
                                            input_dongia float,
                                            input_malnl char,
                                            input_madvt char
                                            )
AS
BEGIN
    INSERT INTO NGUYEN_LIEU(TENNL,DON_GIA,MALNL,MADVT)
    VALUES(input_tenlnl,input_dongia,input_malnl,input_madvt);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

-------------------------------------

----------------------------------------------------------------------------
--24 Insert chi tiet san pham
CREATE  or replace  PROCEDURE PRC_INSERT_CTSP (
                                            input_masp char,
                                            input_manl char,
                                            input_soluong number
                                            )
AS
BEGIN
    INSERT INTO CT_SAN_PHAM
    VALUES(input_masp,input_manl,input_soluong);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;

------------------------------------------------------
--25 Insert chi tiet THUNG
CREATE  or replace  PROCEDURE PRC_INSERT_CTTHUNG (
                                            input_mathung char,
                                            input_manl char,
                                            input_soluong number
                                            )
AS
BEGIN
    INSERT INTO CT_THUNG
    VALUES(input_mathung,input_manl,input_soluong);
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INSERT UNSUCCESSFULLY');
END;
-------------------------------------

-------------------------------------
-- CALL PROCEDURES
-- CALL INSERT NHANVIEN
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_NV(&CMND,&HOLOT,&TENNV,&TUOI,&GIOI_TINH,&SDT,&CHUC_VU);
END;

-- CALL INSERT CT_NHANVIEN
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CT_NV(&MaNV,&Ca,&MaNQL,&MaCoSo);
END;

-- CALL INSERT CO_SO
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_COSO(&TenCoSo,&DiaChi,&TinhTrang,&Loai);
END;

-- CALL INSERT KHACH_HANG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_KH(&SDT,&HOLOT,&TENKH);
END;

-- CALL INSERT HOA_DON
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_HD(&NgayLapPhieu,&TongTien,&MaNV,&MaKH);
END;

-- CALL INSERT DVT
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_DVT(&TenDVT);
END;

-- CALL INSERT LOAI_SP
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_LSP(&TenLSP);
END;

-- CALL INSERT SAN_PHAM
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_SP(&TENSP,&MALOAISP,&MADVT);
END;

-- CALL INSERT CT_HOA_DON
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTHD(&SOHD,&MASP,&SOLUONG);
END;

-- CALL INSERT BIEN_DONG_GIA
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_BDG(&MASP,&MANV,&DONGIA,&NGAYCAPNHAT);
END;

-- CALL INSERT PHIEU_XUAT
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_PX(&NGAY_LAP_PHIEU,&MANV,&CO_SO_NHAP,&CO_SO_XUAT,&NGAY_XUAT_HANG);
END;

-- CALL INSERT PHIEU_NHAP
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_PN(&NGAY_LAP_PHIEU,&MANV,&CO_SO_NHAP,&CO_SO_XUAT,&NGAY_NHAP_HANG);
END;

-- CALL INSERT TAI_XE
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_TX(&TENTX,&CA,&TUYEN);
END;

-- CALL INSERT XE_VAN_CHUYEN
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_XVC(&SOXE,&LOAIXE,&HANG);
END;

-- CALL INSERT PHAN_CONG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_PC(&MATX,&SOXE);
END;

-- CALL INSERT LO_HANG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_LH(&tongSoThung,&SoXe);
END;

-- CALL INSERT THUNG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_TH(&Tinhtrang);
END;

-- CALL INSERT CT_LO_HANG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTLH(&MALO,&MATHUNG);
END;

-- CALL INSERT CT_PHIEU_NHAP
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTPN(&MAPHIEUNHAP,&MALO,&THOIHAN);
END;

-- CALL INSERT CT_PHIEU_XUAT
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTPX(&MAPHIEUXUAT,&MALO);
END;

-- CALL INSERT NHA_CUNG_CAP
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_NCC(&TEN_NCC,&DIACHI,&SDT,&TINH_TRANG);
END;

-- CALL INSERT LOAI_NL
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_LNL(&TEN_LNL,&MANCC);
END;

-- CALL INSERT NGUYEN_LIEU
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_NL(&TEN_NL,&DON_GIA,&MALNL,&MADVT);
END;

-- CALL INSERT CT_SAN_PHAM
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTSP(&MASP,&MANL,&SOLUONG);
END;

-- CALL INSERT CT_THUNG
SET SERVEROUTPUT ON;
BEGIN 
    PRC_INSERT_CTTHUNG(&MATHUNG,&MANL,&SOLUONG);
END;
-----------------------------------------------------------------------------------------------------------
                                            -- Update
-----------------------------------------------------------------------------------------------------------
--TRIGGER UPDATE NHAN_VIEN
CREATE OR REPLACE TRIGGER TRIG_UPDATE_NV
BEFORE UPDATE
ON NHAN_VIEN
FOR EACH ROW
BEGIN
    IF :NEW.CHUC_VU NOT LIKE 'Nhân viên' AND :NEW.CHUC_VU NOT LIKE 'Qu?n lý'
    THEN raise_application_error (-20001,'Ch?c v? không t?n t?i');
    END IF;
END;
-------------------------------------------------------------------------------------
--UPDATE NHAN_VIEN
CREATE OR REPLACE PROCEDURE PRC_UPDATE_NV (input_manv CHAR, input_tuoi NUMBER,input_phone NUMBER, input_chucvu NVARCHAR2)
AS
BEGIN 
--000
IF input_tuoi IS NOT NULL AND input_phone IS NOT NULL AND input_chucvu IS NOT NULL
THEN
        UPDATE NHAN_VIEN
        SET TUOI=input_tuoi,
            SDT=input_phone,
            CHUC_VU= input_chucvu
        WHERE MANV=input_manv;
--001
ELSIF input_tuoi IS NOT NULL AND input_phone IS NOT NULL AND input_chucvu IS NULL
THEN
        UPDATE NHAN_VIEN
        SET TUOI=input_tuoi,
            SDT=input_phone
        WHERE MANV=input_manv;
--011
ELSIF input_tuoi IS NOT NULL AND input_phone IS NULL AND input_chucvu IS NULL
THEN
        UPDATE NHAN_VIEN
        SET TUOI=input_tuoi
        WHERE MANV=input_manv;
--111
ELSIF input_tuoi IS NULL AND input_phone IS NULL AND input_chucvu IS NULL
THEN
        raise_application_error (-20001,'D? li?u ch?a thay ??i');
--110
ELSIF input_tuoi IS NULL AND input_phone IS NULL AND input_chucvu IS NOT NULL
THEN
        UPDATE NHAN_VIEN
        SET 
            CHUC_VU= input_chucvu
        WHERE MANV=input_manv;
--100
ELSIF input_tuoi IS NULL AND input_phone IS NOT NULL AND input_chucvu IS NOT NULL
THEN
        UPDATE NHAN_VIEN
        SET 
            SDT=input_phone,
            CHUC_VU= input_chucvu
        WHERE MANV=input_manv;
--101
ELSIF input_tuoi IS NULL AND input_phone IS NOT NULL AND input_chucvu IS NULL
THEN
        UPDATE NHAN_VIEN
        SET 
            SDT=input_phone
        WHERE MANV=input_manv;
--010
ELSIF input_tuoi IS NOT NULL AND input_phone IS NULL AND input_chucvu IS NOT NULL
        THEN
        UPDATE NHAN_VIEN
        SET TUOI=input_tuoi,
            CHUC_VU= input_chucvu
        WHERE MANV=input_manv;
END IF;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_NV (&MANV,&TUOI,&SDT,&CHUC_VU );
END;
------------------------------------------------------------------
--UPDATE CT_NHAN_VIEN
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_CTNV (&MANV,&CA,&MA_NQL,&MA_CO_SO );
END;
-----------------------------------------------------------
--TRIGGERT UPDATE CO_SO
CREATE OR REPLACE TRIGGER TRIG_UPDATE_CS
BEFORE UPDATE
ON CO_SO
FOR EACH ROW
BEGIN
    IF :NEW.TINH_TRANG NOT LIKE 'Ho?t ??ng' AND :NEW.TINH_TRANG NOT LIKE 'Ng?ng ho?t ??ng'
    THEN raise_application_error (-20001,'Tình tr?ng không t?n t?i');
    END IF;
END;
--------------------------------------------------
--UPDATE CO_SO
CREATE OR REPLACE PROCEDURE PRC_UPDATE_COSO (input_macs CHAR, input_tinhtrang NVARCHAR2)
AS
BEGIN
         UPDATE CO_SO 
         SET TINH_TRANG = input_tinhtrang
         WHERE MA_CO_SO = input_macs;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_COSO(&MA_CO_SO,&TINH_TRANG);
END;
--------------------------------------------------
--UPDATE PhieuNhap 
CREATE OR REPLACE PROCEDURE PRC_UPDATE_PHIEUNHAP (input_mapn CHAR, input_ngaynhap DATE)
AS
BEGIN
IF input_ngaynhap IS NULL THEN
    UPDATE PHIEU_NHAP
    SET  NGAY_NHAP_HANG = SYSDATE
    WHERE MA_PHIEU_NHAP = input_mapn;
ELSE
    UPDATE PHIEU_NHAP
    SET  NGAY_NHAP_HANG = input_ngaynhap
    WHERE MA_PHIEU_NHAP = input_mapn;
    END IF;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_PHIEUNHAP (&MA_PHIEU_NHAP,&NGAY_NHAP_HANG);
END;
---------------------------------------------------------
--UPDATE CT_PN thoihan
create or replace PROCEDURE PRC_UDATE_THOI_HAN_CTPN (
                                            input_mapn char,
                                            input_malo char,
                                            input_thoihan number
                                            )
AS
BEGIN
    IF input_thoihan > 5
    THEN
    DBMS_OUTPUT.PUT_LINE('UPDATE UNSUCCESSFULLY, thoi han phai <= 5');
    ELSE
    UPDATE CT_PHIEU_NHAP
    SET THOI_HAN = input_thoihan
    WHERE MA_PHIEU_NHAP LIKE input_mapn AND MALO LIKE input_malo;
    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESS');
    END IF;
END;
------------------------------------------------------      
--UPDATE PHIEUXUAT  
CREATE OR REPLACE PROCEDURE PRC_UPDATE_PHIEUXUAT (input_mapx CHAR, input_ngayxuat DATE)
AS
BEGIN
IF input_ngayxuat IS NULL THEN
    UPDATE PHIEU_XUAT
    SET  NGAY_XUAT_HANG = SYSDATE
    WHERE MA_PHIEU_XUAT = input_mapx;
ELSE
    UPDATE PHIEU_XUAT
    SET  NGAY_XUAT_HANG = input_ngayxuat
    WHERE MA_PHIEU_XUAT = input_mapx;
    END IF;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_PHIEUXUAT (&MA_PHIEU_XUAT,&NGAY_XUAT_HANG);
END;
-------------------------------
--UPDATE CT_HOADON
CREATE OR REPLACE PROCEDURE PRC_UPDATE_CTHOADON (input_sohd CHAR,input_masp CHAR, input_soluong NUMBER)
AS
BEGIN
    UPDATE CT_HOA_DON
    SET MASP = input_masp,
        SO_LUONG = input_soluong
    WHERE SOHD = input_sohd;
END;

SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_CTHOADON (&SOHD,&MASP,&SO_LUONG);
END;

--TRIGGERT UPDATE THUNG
CREATE OR REPLACE TRIGGER TRIG_UPDATE_THUNG
BEFORE UPDATE
ON THUNG
FOR EACH ROW
BEGIN
    IF :NEW.TINH_TRANG LIKE 'H?ng'
    THEN 
        UPDATE CT_THUNG
        SET TONG_SO_NL = 0
        WHERE MA_THUNG LIKE :NEW.MA_THUNG;
    END IF;
END;

--UPDATE THUNG
CREATE OR REPLACE PROCEDURE PRC_UPDATE_THUNG (input_mathung CHAR,input_tinhtrang VARCHAR2)
AS
BEGIN
    UPDATE THUNG
    SET 
        TINH_TRANG = input_tinhtrang
    WHERE MA_THUNG = input_mathung;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_UPDATE_THUNG (&MA_THUNG,&TINH_TRANG);
END;
-----------------------------------------------------------------------------------------------------------
                                            -- Delete
-----------------------------------------------------------------------------------------------------------
--DELETE NHAN_VIEN
CREATE OR REPLACE PROCEDURE PRC_DEL_NHAN_VIEN (input_manv CHAR)
AS
BEGIN 
UPDATE NHAN_VIEN
SET DEL_STATUS = 'DELETED'
WHERE MANV LIKE input_manv;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_NHAN_VIEN (&MANV);
END;

--DELETE CO_SO
CREATE OR REPLACE PROCEDURE PRC_DEL_CO_SO (input_macs CHAR)
AS
BEGIN 
UPDATE CO_SO
SET DEL_STATUS = 'DELETED'
WHERE MA_CO_SO LIKE input_macs;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_CO_SO (&MA_CO_SO);
END;

--DELETE NCC
CREATE OR REPLACE PROCEDURE PRC_DEL_NCC (input_mancc CHAR)
AS
BEGIN 
UPDATE NHA_CUNG_CAP
SET DEL_STATUS = 'DELETED'
WHERE MANCC LIKE input_mancc;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_NCC (&MANCC);
END;

--DELETE HOA DON
CREATE OR REPLACE PROCEDURE PRC_DEL_HD (input_mahd CHAR)
AS
BEGIN 
UPDATE HOA_DON
SET DEL_STATUS = 'DELETED'
WHERE SOHD LIKE input_mahd;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_HD (&SOHD);
END;

--DELETE KHACH_HANG
CREATE OR REPLACE PROCEDURE PRC_DEL_KH (input_makh CHAR)
AS
BEGIN 
UPDATE KHACH_HANG
SET DEL_STATUS = 'DELETED'
WHERE MAKH LIKE input_makh;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_KH (&MAKH);
END;

--DELETE LOAI_SAN_PHAM
CREATE OR REPLACE PROCEDURE PRC_DEL_LSP (input_malsp CHAR)
AS
BEGIN 
UPDATE LOAI_SAN_PHAM
SET DEL_STATUS = 'DELETED'
WHERE MALSP LIKE input_malsp;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_LSP (&MALSP);
END;

--DELETE SAN_PHAM
CREATE OR REPLACE PROCEDURE PRC_DEL_SP (input_masp CHAR)
AS
BEGIN 
UPDATE SAN_PHAM
SET DEL_STATUS = 'DELETED'
WHERE MASP LIKE input_masp;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_SP (&MASP);
END;

--DELETE LOAI_NGUYEN_LIEU
CREATE OR REPLACE PROCEDURE PRC_DEL_LNL (input_malnl CHAR)
AS
BEGIN 
UPDATE LOAI_NGUYEN_LIEU
SET DEL_STATUS = 'DELETED'
WHERE MALNL LIKE input_malnl;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_LNL (&MALNL);
END;

--DELETE NGUYEN_LIEU
CREATE OR REPLACE PROCEDURE PRC_DEL_NL (input_manl CHAR)
AS
BEGIN 
UPDATE NGUYEN_LIEU
SET DEL_STATUS = 'DELETED'
WHERE MANL LIKE input_manl;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_NL (&MANL);
END;

--DELETE THUNG
CREATE OR REPLACE PROCEDURE PRC_DEL_TH (input_mathung CHAR)
AS
BEGIN 
UPDATE THUNG
SET DEL_STATUS = 'DELETED'
WHERE MA_THUNG LIKE input_mathung;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_TH (&MA_THUNG);
END;

--DELETE LO_HANG
CREATE OR REPLACE PROCEDURE PRC_DEL_LH (input_malo CHAR)
AS
BEGIN 
UPDATE LO_HANG
SET DEL_STATUS = 'DELETED'
WHERE MALO LIKE input_malo;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_LH (&MALO);
END;

--DELETE TAI_XE
CREATE OR REPLACE PROCEDURE PRC_DEL_TX (input_matx CHAR)
AS
BEGIN 
UPDATE TAI_XE
SET DEL_STATUS = 'DELETED'
WHERE MA_TAI_XE LIKE input_matx;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_TX (&MA_TAI_XE);
END;

--DELETE XE_VAN_CHUYEN
CREATE OR REPLACE PROCEDURE PRC_DEL_XVC (input_maxvc CHAR)
AS
BEGIN 
UPDATE XE_VAN_CHUYEN
SET DEL_STATUS = 'DELETED'
WHERE SO_XE LIKE input_maxvc;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_XVC (&SO_XE);
END;

--DELETE PHIEU_NHAP
CREATE OR REPLACE PROCEDURE PRC_DEL_PN (input_mapn CHAR)
AS
BEGIN 
UPDATE PHIEU_NHAP
SET DEL_STATUS = 'DELETED'
WHERE MA_PHIEU_NHAP LIKE input_mapn;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_PN (&MA_PHIEU_NHAP);
END;

--DELETE PHIEU_XUAT
CREATE OR REPLACE PROCEDURE PRC_DEL_PX (input_mapx CHAR)
AS
BEGIN 
UPDATE PHIEU_XUAT
SET DEL_STATUS = 'DELETED'
WHERE MA_PHIEU_XUAT LIKE input_mapx;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_PX (&MA_PHIEU_XUAT);
END;

--DELETE DON_VI_TINH
CREATE OR REPLACE PROCEDURE PRC_DEL_DVT (input_madvt CHAR)
AS
BEGIN 
UPDATE DON_VI_TINH
SET DEL_STATUS = 'DELETED'
WHERE MADVT LIKE input_madvt;
END;
SET SERVEROUTPUT ON;
BEGIN 
    PRC_DEL_DVT (&MADVT);
END;
-----------------------------------------------------------------------------------------------------------
                                            -- Views
-----------------------------------------------------------------------------------------------------------
-- CREATE VIEWS
-- SIMPLE
--1
CREATE OR REPLACE VIEW THONG_TIN_CHI_TIET_NHAN_VIEN
AS 
SELECT NHAN_VIEN.MANV, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN, GIOI_TINH, SDT, CHUC_VU, CA, MA_NQL, MA_CO_SO
FROM NHAN_VIEN FULL OUTER JOIN CHI_TIET_NHAN_VIEN
ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
WHERE DEL_STATUS NOT LIKE 'DELETED';
--1.1
CREATE OR REPLACE VIEW THONG_TIN_CHI_TIET_NHAN_VIEN_ADMIN
AS 
SELECT NHAN_VIEN.MANV, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN, 
GIOI_TINH, SDT, CHUC_VU, CA, MA_NQL, MA_CO_SO,NHAN_VIEN.DEL_STATUS AS TINH_TRANG
FROM NHAN_VIEN FULL OUTER JOIN CHI_TIET_NHAN_VIEN
ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV;

--2
CREATE OR REPLACE VIEW DANH_SACH_NHAN_VIEN
AS 
SELECT MANV, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN, GIOI_TINH, SDT, CHUC_VU
FROM NHAN_VIEN
WHERE DEL_STATUS NOT LIKE 'DELETED';
--2.1
CREATE OR REPLACE VIEW DANH_SACH_NHAN_VIEN_ADMIN
AS 
SELECT MANV, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN, GIOI_TINH, SDT, CHUC_VU,NHAN_VIEN.DEL_STATUS AS TINH_TRANG
FROM NHAN_VIEN;

--3
CREATE OR REPLACE VIEW DANH_SACH_SAN_PHAM
AS
SELECT TENSP, TENLSP, TENDVT
FROM SAN_PHAM JOIN loai_san_pham ON SAN_PHAM.MALSP = LOAI_SAN_PHAM.MALSP
JOIN DON_VI_TINH ON SAN_PHAM.MADVT = don_vi_tinh.madvt
WHERE SAN_PHAM.DEL_STATUS NOT LIKE 'DELETED';
--3.1
CREATE OR REPLACE VIEW DANH_SACH_SAN_PHAM_ADMIN
AS
SELECT TENSP, TENLSP, TENDVT,SAN_PHAM.DEL_STATUS AS TINH_TRANG
FROM SAN_PHAM JOIN loai_san_pham ON SAN_PHAM.MALSP = LOAI_SAN_PHAM.MALSP
JOIN DON_VI_TINH ON SAN_PHAM.MADVT = don_vi_tinh.madvt;

--4
CREATE OR REPLACE VIEW CONG_THUC_SAN_PHAM
AS
SELECT TENSP, TENNL, SO_LUONG
FROM CT_SAN_PHAM JOIN NGUYEN_LIEU ON CT_SAN_PHAM.MANL = NGUYEN_LIEU.MANL
JOIN SAN_PHAM ON SAN_PHAM.MASP =CT_SAN_PHAM.MASP
WHERE SAN_PHAM.DEL_STATUS NOT LIKE 'DELETED';
--4.1
CREATE OR REPLACE VIEW CONG_THUC_SAN_PHAM_ADMIN
AS
SELECT TENSP, TENNL, SO_LUONG, SAN_PHAM.DEL_STATUS AS TINH_TRANG
FROM CT_SAN_PHAM JOIN NGUYEN_LIEU ON CT_SAN_PHAM.MANL = NGUYEN_LIEU.MANL
JOIN SAN_PHAM ON SAN_PHAM.MASP =CT_SAN_PHAM.MASP;

--5
CREATE OR REPLACE VIEW V_HOA_DON
AS
SELECT HOA_DON.SOHD,NGAY_LAP_HD,MANV,MAKH,SUM(THANH_TIEN) TONG_TIEN, DEL_STATUS
FROM HOA_DON JOIN CT_HOA_DON ON HOA_DON.SOHD = CT_HOA_DON.SOHD
GROUP BY HOA_DON.SOHD,NGAY_LAP_HD,MANV,MAKH,DEL_STATUS;
--5.1
CREATE OR REPLACE VIEW DANH_SACH_HOA_DON
AS
SELECT SOHD, NGAY_LAP_HD, TONG_TIEN, 
CONCAT(CONCAT(NHAN_VIEN.HO_LOT,' '), TENNV) AS NHAN_VIEN_LAP_PHIEU, CONCAT(CONCAT(KHACH_HANG.HO_LOT,' '), TEN_KH)AS TEN_KHACH_HANG
FROM V_HOA_DON JOIN KHACH_HANG ON V_HOA_DON.MAKH = KHACH_HANG.MAKH
JOIN NHAN_VIEN ON V_HOA_DON.MANV=NHAN_VIEN.MANV
WHERE V_HOA_DON.DEL_STATUS NOT LIKE 'DELETED';
--5.2
CREATE OR REPLACE VIEW DANH_SACH_HOA_DON_ADMIN
AS
SELECT SOHD, NGAY_LAP_HD, TONG_TIEN, 
CONCAT(CONCAT(NHAN_VIEN.HO_LOT,' '), TENNV) AS NHAN_VIEN_LAP_PHIEU,
CONCAT(CONCAT(KHACH_HANG.HO_LOT,' '), TEN_KH)AS TEN_KHACH_HANG, V_HOA_DON.DEL_STATUS AS TINH_TRANG
FROM V_HOA_DON JOIN KHACH_HANG ON V_HOA_DON.MAKH = KHACH_HANG.MAKH
JOIN NHAN_VIEN ON V_HOA_DON.MANV=NHAN_VIEN.MANV;

--6
CREATE OR REPLACE VIEW THONG_TIN_HOA_DON
AS
SELECT HOA_DON.SOHD, TENSP, SO_LUONG, THANH_TIEN
FROM HOA_DON JOIN CT_HOA_DON ON HOA_DON.SOHD = CT_HOA_DON.SOHD
JOIN SAN_PHAM ON CT_HOA_DON.MASP = SAN_PHAM.MASP
WHERE HOA_DON.DEL_STATUS NOT LIKE 'DELETED';
--6.1
CREATE OR REPLACE VIEW THONG_TIN_HOA_DON_ADMIN
AS
SELECT HOA_DON.SOHD, TENSP, SO_LUONG, THANH_TIEN,HOA_DON.DEL_STATUS AS TINH_TRANG
FROM HOA_DON JOIN CT_HOA_DON ON HOA_DON.SOHD = CT_HOA_DON.SOHD
JOIN SAN_PHAM ON CT_HOA_DON.MASP = SAN_PHAM.MASP;

--7
CREATE OR REPLACE  VIEW NHAP_KHO
AS
SELECT TO_CHAR(NGAY_NHAP_HANG,'MM') AS THANG,TO_CHAR(NGAY_NHAP_HANG,'YYYY') AS NAM, NL.MANL,
TENNL,SUM(TONG_SO_NL) AS SO_LUONG_NHAP 
FROM PHIEU_NHAP PN JOIN CT_PHIEU_NHAP CTPN ON PN.MA_PHIEU_NHAP = CTPN.MA_PHIEU_NHAP
JOIN LO_HANG LH ON LH.MALO = CTPN.MALO
JOIN CT_LO_HANG CTLH ON LH.MALO=CTLH.MALO
JOIN THUNG TH ON TH.MA_THUNG =  CTLH.MA_THUNG
JOIN CT_THUNG CTTH ON TH.MA_THUNG = CTTH.MA_THUNG
JOIN NGUYEN_LIEU NL ON NL.MANL = CTTH.MANL
JOIN CO_SO CS ON PN.MA_CO_SO_NHAP = CS.MA_CO_SO
WHERE LOAI_CO_SO LIKE N'Kho' OR LOAI_CO_SO LIKE N'Kho l?nh'
GROUP BY TO_CHAR(NGAY_NHAP_HANG,'MM'),TO_CHAR(NGAY_NHAP_HANG,'YYYY'),NL.MANL,TENNL;

--8
CREATE OR REPLACE VIEW XUAT_KHO
AS
SELECT TO_CHAR(NGAY_XUAT_HANG,'MM') AS THANG,TO_CHAR(NGAY_XUAT_HANG,'YYYY') AS NAM,NL.MANL, 
TENNL,SUM(TONG_SO_NL) AS SO_LUONG_XUAT 
FROM PHIEU_XUAT PX JOIN CT_PHIEU_XUAT CTPX ON PX.MA_PHIEU_XUAT = CTPX.MA_PHIEU_XUAT
JOIN LO_HANG LH ON LH.MALO = CTPX.MALO
JOIN CT_LO_HANG CTLH ON LH.MALO=CTLH.MALO
JOIN THUNG TH ON TH.MA_THUNG =  CTLH.MA_THUNG
JOIN CT_THUNG CTTH ON TH.MA_THUNG = CTTH.MA_THUNG
JOIN NGUYEN_LIEU NL ON NL.MANL = CTTH.MANL
JOIN CO_SO CS ON PX.MA_CO_SO_XUAT = CS.MA_CO_SO
WHERE LOAI_CO_SO LIKE N'Kho' OR LOAI_CO_SO LIKE N'Kho l?nh'
GROUP BY TO_CHAR(NGAY_XUAT_HANG,'MM'),TO_CHAR(NGAY_XUAT_HANG,'YYYY'),NL.MANL,TENNL;

--9
CREATE OR REPLACE VIEW V_TON_KHO
AS
SELECT 
NHAP_KHO.THANG THANG, NHAP_KHO.NAM NAM,NHAP_KHO.MANL MANL, NHAP_KHO.TENNL TENNL,
CASE 
    WHEN SO_LUONG_XUAT IS NULL 
        THEN SO_LUONG_NHAP - 0 
    ELSE (SO_LUONG_NHAP - SO_LUONG_XUAT) 
END SO_LUONG_TON
FROM NHAP_KHO FULL OUTER JOIN XUAT_KHO ON NHAP_KHO.THANG = XUAT_KHO.THANG 
AND NHAP_KHO.NAM = XUAT_KHO.NAM AND NHAP_KHO.MANL = XUAT_KHO.MANL
WHERE NHAP_KHO.THANG IS NOT NULL AND NHAP_KHO.NAM IS NOT NULL AND NHAP_KHO.MANL 
IS NOT NULL AND NHAP_KHO.TENNL IS NOT NULL AND 
CASE 
    WHEN SO_LUONG_XUAT IS NULL 
        THEN SO_LUONG_NHAP - 0 
    ELSE (SO_LUONG_NHAP - SO_LUONG_XUAT) 
END IS NOT NULL
ORDER BY NHAP_KHO.NAM;

--10
CREATE OR REPLACE VIEW XEM_TON_KHO
AS 
SELECT * FROM V_TON_KHO;

--11
CREATE OR REPLACE VIEW CHI_PHI
AS 
SELECT THANG, NAM, NGUYEN_LIEU.TENNL, DON_GIA,SO_LUONG_NHAP, (DON_GIA * SO_LUONG_NHAP) TONG_CHI_PHI
FROM NHAP_KHO JOIN NGUYEN_LIEU ON NHAP_KHO.MANL = NGUYEN_LIEU.MANL;

--12
CREATE OR REPLACE VIEW TONG_THU
AS
SELECT TO_CHAR(NGAY_LAP_HD,'MM') AS THANG,TO_CHAR(NGAY_LAP_HD,'YYYY') AS NAM, SUM(TONG_TIEN) TONG_THU
FROM V_HOA_DON
GROUP BY TO_CHAR(NGAY_LAP_HD,'MM'),TO_CHAR(NGAY_LAP_HD,'YYYY');

--13
CREATE OR REPLACE VIEW LOI_NHUAN
AS
SELECT TONG_THU.THANG, TONG_THU.NAM,(TONG_THU - TONG_CHI_PHI) LOI_NHUAN
FROM CHI_PHI FULL OUTER JOIN TONG_THU ON CHI_PHI.THANG = TONG_THU.THANG AND CHI_PHI.NAM = TONG_THU.NAM;

--14
CREATE OR REPLACE VIEW THONG_TIN_PHIEU_NHAP
AS 
SELECT DISTINCT PN.MA_PHIEU_NHAP, NGAY_LAP_PHIEU, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN ,NHAP_TU,XUAT_DEN, NGAY_NHAP_HANG
FROM PHIEU_NHAP PN JOIN CT_PHIEU_NHAP CTPN ON PN.MA_PHIEU_NHAP = CTPN.MA_PHIEU_NHAP
JOIN NHAN_VIEN NV ON PN.MANV = NV.MANV
JOIN (SELECT (PHIEU_NHAP.MA_CO_SO_NHAP) AS MA_NHAP, TEN_CO_SO NHAP_TU FROM CO_SO JOIN PHIEU_NHAP ON CO_SO.MA_CO_SO = PHIEU_NHAP.MA_CO_SO_NHAP) A 
ON PN.MA_CO_SO_NHAP = A.MA_NHAP
FULL OUTER JOIN (SELECT (PHIEU_NHAP.MA_CO_SO_XUAT) AS MA_XUAT, TEN_CO_SO XUAT_DEN FROM CO_SO JOIN PHIEU_NHAP 
ON CO_SO.MA_CO_SO = PHIEU_NHAP.MA_CO_SO_XUAT) B
ON PN.MA_CO_SO_XUAT = B.MA_XUAT;

--15
CREATE OR REPLACE VIEW THONG_TIN_PHIEU_XUAT
AS 
SELECT DISTINCT PX.MA_PHIEU_XUAT, NGAY_LAP_PHIEU, CONCAT(CONCAT(HO_LOT,' '), TENNV) AS HO_TEN ,NHAP_DEN, XUAT_TU, NGAY_XUAT_HANG
FROM PHIEU_XUAT PX JOIN CT_PHIEU_XUAT CTPX ON PX.MA_PHIEU_XUAT = CTPX.MA_PHIEU_XUAT
JOIN NHAN_VIEN NV ON PX.MANV = NV.MANV
FULL OUTER JOIN (SELECT (PHIEU_XUAT.MA_CO_SO_NHAP) AS MA_NHAP, TEN_CO_SO NHAP_DEN FROM CO_SO JOIN PHIEU_XUAT 
ON CO_SO.MA_CO_SO = PHIEU_XUAT.MA_CO_SO_NHAP) A 
ON PX.MA_CO_SO_NHAP = A.MA_NHAP
FULL OUTER JOIN (SELECT (PHIEU_XUAT.MA_CO_SO_XUAT) AS MA_XUAT, TEN_CO_SO XUAT_TU FROM CO_SO JOIN PHIEU_XUAT 
ON CO_SO.MA_CO_SO = PHIEU_XUAT.MA_CO_SO_XUAT) B
ON PX.MA_CO_SO_XUAT = B.MA_XUAT;

---------------------------------------------------
                    --TON KHO
---------------------------------------------------
CREATE TYPE TYPE_TON_KHO IS OBJECT (Thang VARCHAR2(5),Nam VARCHAR2(5),Ma_nguyen_lieu CHAR(7),
Ten_nguyen_lieu NVARCHAR2(30),So_luong_ton NUMBER(10));

CREATE TYPE TABLE_TON_KHO IS TABLE OF TYPE_TON_KHO;

create or replace PROCEDURE PRC_GET_TON_KHO
AS
    RETURN_TON_KHO TABLE_TON_KHO;
BEGIN
SELECT TYPE_TON_KHO (THANG,NAM,MANL,TENNL,SO_LUONG_TON) BULK COLLECT
INTO RETURN_TON_KHO
FROM V_TON_KHO;
FOR X IN 1..RETURN_TON_KHO.COUNT
    LOOP
        declare
            c integer;
        begin
            C :=0;
            select count(*) into c from TON_KHO 
            where (CONCAT(RETURN_TON_KHO(X).THANG,CONCAT(RETURN_TON_KHO(X).NAM,RETURN_TON_KHO(X).Ma_nguyen_lieu)))
            LIKE(CONCAT(TON_KHO.THANG,CONCAT(TON_KHO.NAM,TON_KHO.Ma_nguyen_lieu)));
        if c = 0 then                
        INSERT INTO TON_KHO
        VALUES(RETURN_TON_KHO(X).THANG,RETURN_TON_KHO(X).NAM,RETURN_TON_KHO(X).Ma_nguyen_lieu,
                    RETURN_TON_KHO(X).Ten_nguyen_lieu, RETURN_TON_KHO(X).So_luong_ton);
        end if;
        end;
    END LOOP;
END;

-------------------------------------------------------
                    --END TON KHO
-------------------------------------------------------

---------------------------------------------------------------------------------
--QUERY
-- 10 BANG DON  (V?n Minh)
--1 Xem thông tin khách hàng 
SELECT * FROM KHACH_HANG;
--2 Xem thông tin khách hàng mã KH00001
SELECT * FROM KHACH_HANG WHERE MAKH = 'KH00001';
--3 Xem t?t c? hóa ??n trong ngày
SELECT * FROM HOA_DON WHERE NGAY_LAP_HD = SYSDATE;
--4 Xem t?t c? các hóa ??n t? ngày hôm qua và có t?ng ti?n h?n 1k?
SELECT * FROM HOA_DON WHERE TONG_TIEN > 1000 AND NGAY_LAP_HD < SYSDATE;
--5 Xem s? l??ng hóa ??n các khách hàng ?ã mua
SELECT MAKH, COUNT(SOHD) FROM HOA_DON GROUP BY MAKH;
--6 Xem mã phi?u nh?p có ngày l?p phi?u nh? h?n ngày nh?p hàng
SELECT MA_PHIEU_NHAP FROM PHIEU_NHAP WHERE NGAY_LAP_PHIEU < NGAY_NHAP_HANG;
--7 Xem s? l??ng lô hàng nh?p c?a m?i phi?u nh?p
SELECT MA_PHIEU_NHAP, COUNT(MALO) SO_LO_HANG FROM CT_PHIEU_NHAP GROUP BY ma_phieu_nhap;
--8 Xem s? l??ng lô hàng nh?p l?n h?n 10 c?a m?i phi?u nh?p 
SELECT MA_PHIEU_NHAP, COUNT(MALO) SO_LO_HANG FROM CT_PHIEU_NHAP GROUP BY ma_phieu_nhap HAVING COUNT(MALO)>=10;
--9 Xem s? l??ng lô hàng nh?p l?n h?n 3 c?a m?i phi?u nh?p và s?p x?pp t?ng ??n theo m?i phi?u nh?p 
SELECT MA_PHIEU_NHAP, COUNT(MALO) SO_LO_HANG FROM CT_PHIEU_NHAP GROUP BY ma_phieu_nhap HAVING COUNT(MALO)>=3 ORDER BY SO_LO_HANG;
--10 Xem phi?u nh?p có s? l??ng lô hàng l?n nh?t.
SELECT *
FROM (SELECT MA_PHIEU_NHAP, COUNT(MALO) SO_LO_HANG 
        FROM CT_PHIEU_NHAP 
        GROUP BY ma_phieu_nhap 
        HAVING COUNT(MALO)>=1 
        ORDER BY SO_LO_HANG
    )
WHERE ROWNUM = 1;
-------------------------------------------------
-- 10 BANG GHEP
--1 Xem toàn bô chi ti?t c?a nhân viên. (Gia Kh??ng)
SELECT* FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV;
--2 Xem nhân viên và c? s? mà nhân viên làm vi?c
SELECT NHAN_VIEN.MANV, TEN_CO_SO
FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
                JOIN CO_SO ON CHI_TIET_NHAN_VIEN.MA_CO_SO = CO_SO.MA_CO_SO;
--3 Xem phi?u xu?t do nhân viên nào xu?t ? c? s? nào
SELECT NHAN_VIEN.MANV, TEN_CO_SO, MA_PHIEU_XUAT
FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
                JOIN CO_SO ON CHI_TIET_NHAN_VIEN.MA_CO_SO = CO_SO.MA_CO_SO
                JOIN PHIEU_XUAT ON PHIEU_XUAT.MANV = NHAN_VIEN.MANV;
--4 Xem s? l??ng c? s? mà nhân viên làm vi?c
SELECT NHAN_VIEN.MANV, COUNT(CO_SO.MA_CO_SO)
FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
                JOIN CO_SO ON CHI_TIET_NHAN_VIEN.MA_CO_SO = CO_SO.MA_CO_SO
GROUP BY NHAN_VIEN.MANV;
--5 Xem s? l??ng phi?u xu?t >1 mà nhân viên ?ã l?p 
SELECT NHAN_VIEN.MANV, COUNT(MA_PHIEU_XUAT)
FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
                JOIN PHIEU_XUAT ON PHIEU_XUAT.MANV = NHAN_VIEN.MANV
GROUP BY NHAN_VIEN.MANV
HAVING COUNT(MA_PHIEU_XUAT)>1;
--6 Xem s? l??ng phi?u nh?p t? ba tr? lên mà nhân viên NV0003 ?ã l?p
SELECT NHAN_VIEN.MANV, COUNT(MA_PHIEU_NHAP)
FROM NHAN_VIEN JOIN CHI_TIET_NHAN_VIEN ON NHAN_VIEN.MANV = CHI_TIET_NHAN_VIEN.MANV
                JOIN PHIEU_NHAP ON PHIEU_NHAP.MANV = NHAN_VIEN.MANV
                JOIN CO_SO ON CHI_TIET_NHAN_VIEN.MA_CO_SO = CO_SO.MA_CO_SO
GROUP BY NHAN_VIEN.MANV
HAVING COUNT(MA_PHIEU_NHAP)>=3 OR NHAN_VIEN.MANV LIKE 'NV00003' ;
--7 Xem s? l??ng nguyên li?u nh?p c?a m?i phi?u nh?p (Bình Minh)
SELECT PN.MA_PHIEU_NHAP, COUNT(MANL) SO_LUONG_NL
FROM PHIEU_NHAP PN 
    JOIN CT_PHIEU_NHAP CTPN ON PN.MA_PHIEU_NHAP = CTPN.MA_PHIEU_NHAP
    JOIN LO_HANG LH ON CTPN.MALO = LH.MALO
    JOIN CT_LO_HANG CTLH ON LH.MALO = CTLH.MALO
    JOIN THUNG ON THUNG.MA_THUNG = CTLH.MA_THUNG
    JOIN CT_THUNG ON THUNG.MA_THUNG = CT_THUNG.MA_THUNG
GROUP BY PN.MA_PHIEU_NHAP;
--8 Xem s? l??ng nguyên li?u nh?p >2 c?a m?i phi?u nh?p
SELECT PN.MA_PHIEU_NHAP, COUNT(MANL) SO_LUONG_NL
FROM PHIEU_NHAP PN 
    JOIN CT_PHIEU_NHAP CTPN ON PN.MA_PHIEU_NHAP = CTPN.MA_PHIEU_NHAP
    JOIN LO_HANG LH ON CTPN.MALO = LH.MALO
    JOIN CT_LO_HANG CTLH ON LH.MALO = CTLH.MALO
    JOIN THUNG ON THUNG.MA_THUNG = CTLH.MA_THUNG
    JOIN CT_THUNG ON THUNG.MA_THUNG = CT_THUNG.MA_THUNG
GROUP BY PN.MA_PHIEU_NHAP
HAVING COUNT(MANL)>2;
--9 Xem nh?p xu?t c?a m?i tháng
SELECT NHAP_KHO.THANG THANG, NHAP_KHO.NAM NAM,SO_LUONG_NHAP,SO_LUONG_XUAT,
                                                CASE 
                                                    WHEN SO_LUONG_NHAP IS NULL AND SO_LUONG_XUAT IS NULL
                                                        THEN 0
                                                    WHEN SO_LUONG_NHAP IS NOT NULL AND SO_LUONG_XUAT IS NOT NULL
                                                        THEN SO_LUONG_NHAP - SO_LUONG_XUAT
                                                    WHEN SO_LUONG_NHAP IS NOT NULL AND SO_LUONG_XUAT IS NULL
                                                        THEN SO_LUONG_NHAP 
                                                    ELSE SO_LUONG_XUAT                                                    
                                                END  TON_THANG 
FROM NHAP_KHO FULL OUTER JOIN XUAT_KHO 
    ON NHAP_KHO.THANG = XUAT_KHO.THANG 
    AND NHAP_KHO.NAM = XUAT_KHO.NAM AND NHAP_KHO.MANL = XUAT_KHO.MANL
ORDER BY NAM;
--10 Xem t?n kho c?a m?i tháng
SELECT 
NHAP_KHO.THANG THANG, NHAP_KHO.NAM NAM,NHAP_KHO.TENNL
,CASE 
    --000
    WHEN SO_LUONG_XUAT IS NULL AND SO_LUONG_NHAP_PREV IS NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NULL
        THEN 0
    --001
    WHEN SO_LUONG_XUAT IS NULL AND SO_LUONG_NHAP_PREV IS NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NOT NULL
        THEN NHAP_KHO.SO_LUONG_NHAP
    --010
    WHEN SO_LUONG_XUAT IS NULL AND SO_LUONG_NHAP_PREV IS NOT NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NULL
        THEN NHAP_KHO.SO_LUONG_NHAP - SO_LUONG_XUAT
    --011
    WHEN SO_LUONG_XUAT IS NULL AND SO_LUONG_NHAP_PREV IS NOT NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NOT NULL
        THEN NHAP_KHO.SO_LUONG_NHAP + SO_LUONG_NHAP_PREV
    --111
    WHEN SO_LUONG_XUAT IS NOT NULL AND SO_LUONG_NHAP_PREV IS NOT NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NOT NULL  
        THEN (NHAP_KHO.SO_LUONG_NHAP + SO_LUONG_NHAP_PREV) - SO_LUONG_XUAT
    --110
    WHEN SO_LUONG_XUAT IS NOT NULL AND SO_LUONG_NHAP_PREV IS NOT NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NULL  
        THEN SO_LUONG_NHAP_PREV - SO_LUONG_XUAT 
    --100
    WHEN SO_LUONG_XUAT IS NOT NULL AND SO_LUONG_NHAP_PREV IS NULL AND  NHAP_KHO.SO_LUONG_NHAP IS NULL  
        THEN 0 - SO_LUONG_XUAT
    ELSE (NHAP_KHO.SO_LUONG_NHAP - SO_LUONG_XUAT) 
END SO_LUONG_TON
FROM 
(SELECT NHAP_KHO.THANG THANG, NHAP_KHO.NAM NAM, CASE 
                                                    WHEN SO_LUONG_NHAP IS NULL AND SO_LUONG_XUAT IS NULL
                                                        THEN 0
                                                    WHEN SO_LUONG_NHAP IS NOT NULL AND SO_LUONG_XUAT IS NOT NULL
                                                        THEN SO_LUONG_NHAP - SO_LUONG_XUAT
                                                    WHEN SO_LUONG_NHAP IS NOT NULL AND SO_LUONG_XUAT IS NULL
                                                        THEN SO_LUONG_NHAP 
                                                    ELSE SO_LUONG_XUAT                                                    
                                                END  SO_LUONG_NHAP_PREV FROM NHAP_KHO FULL OUTER JOIN XUAT_KHO 
    ON NHAP_KHO.THANG = XUAT_KHO.THANG 
    AND NHAP_KHO.NAM = XUAT_KHO.NAM AND NHAP_KHO.MANL = XUAT_KHO.MANL
ORDER BY NAM) A
JOIN NHAP_KHO 
    ON A.THANG = NHAP_KHO.THANG AND A.NAM=NHAP_KHO.NAM 
FULL OUTER JOIN XUAT_KHO 
    ON NHAP_KHO.THANG = XUAT_KHO.THANG 
    AND NHAP_KHO.NAM = XUAT_KHO.NAM AND NHAP_KHO.MANL = XUAT_KHO.MANL
ORDER BY NAM;
-----------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
--TRANSACTION
CREATE OR REPLACE PROCEDURE PRC_CHECK_UPDATE_NV_NHAP_HD(input_sohd char)
AS
COUNT_V NUMBER(1);
BEGIN
SET TRANSACTION READ WRITE NAME 'TRANS_CHECK_UPDATE_NV_NHAP_HD';
UPDATE HOA_DON
SET MANV = input_sohd;
EXCEPTION WHEN OTHERS THEN ROLLBACK;
END;

                                            -- Users
-----------------------------------------------------------------------------------------------------------
create user ADMIN IDENTIFIED BY ADMIN123;
CREATE ROLE ROLE_ADMIN;
create user MANAGER IDENTIFIED BY MANAGER123;
CREATE ROLE ROLE_MANAGER;
create user STAFF IDENTIFIED BY STAFF123;
CREATE ROLE ROLE_STAFF;
------------------------------ROLE ADMIN
GRANT CREATE USER, CREATE ROLE, CREATE SESSION TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON BIEN_DONG_GIA TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CHI_TIET_NHAN_VIEN TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CO_SO TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_HOA_DON TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_LO_HANG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_PHIEU_NHAP TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_PHIEU_XUAT TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_SAN_PHAM TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON CT_THUNG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON DON_VI_TINH TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON HOA_DON TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON KHACH_HANG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON LO_HANG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON LOAI_NGUYEN_LIEU TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON NHA_CUNG_CAP TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON NHAN_VIEN TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON PHAN_CONG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON PHIEU_NHAP TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON PHIEU_XUAT TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON SAN_PHAM TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON TAI_XE TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON THUNG TO ROLE_ADMIN;
GRANT SELECT,UPDATE,INSERT,DELETE ON XE_VAN_CHUYEN TO ROLE_ADMIN;
------------------------------ROLE MANAGER
GRANT SELECT,UPDATE,INSERT ON BIEN_DONG_GIA TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CHI_TIET_NHAN_VIEN TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CO_SO TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_HOA_DON TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_LO_HANG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_PHIEU_NHAP TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_PHIEU_XUAT TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_SAN_PHAM TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON CT_THUNG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON DON_VI_TINH TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON HOA_DON TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON KHACH_HANG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON LO_HANG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON LOAI_NGUYEN_LIEU TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON NHA_CUNG_CAP TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON NHAN_VIEN TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON PHAN_CONG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON PHIEU_NHAP TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON PHIEU_XUAT TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON SAN_PHAM TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT,DELETE ON TAI_XE TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON THUNG TO ROLE_MANAGER;
GRANT SELECT,UPDATE,INSERT ON XE_VAN_CHUYEN TO ROLE_MANAGER;
------------------------------ROLE STAFF
GRANT SELECT,UPDATE,INSERT ON BIEN_DONG_GIA TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CHI_TIET_NHAN_VIEN TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_HOA_DON TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_LO_HANG TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_PHIEU_NHAP TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_PHIEU_XUAT TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_SAN_PHAM TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON CT_THUNG TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON DON_VI_TINH TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON HOA_DON TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON KHACH_HANG TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON LO_HANG TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON LOAI_NGUYEN_LIEU TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON NHAN_VIEN TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON PHIEU_NHAP TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON PHIEU_XUAT TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON SAN_PHAM TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT,DELETE ON TAI_XE TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON THUNG TO ROLE_STAFF;
GRANT SELECT,UPDATE,INSERT ON XE_VAN_CHUYEN TO ROLE_STAFF;
-----------------------GRANT ROLE
GRANT ROLE_ADMIN TO ADMIN;
GRANT ROLE_MANAGER TO MANAGER;
GRANT ROLE_STAFF TO STAFF;


--------------------------------USER--------------------------------------
create user BinhMinh identified by BinhMinh1999;
create user VanMinh identified by VanMinh2001;
create user GiaKhuong identified by khuong2001;


grant select on Doan.NHAN_VIEN to BinhMinh; 
grant update, delete on Doan.SAN_PHAM to BinhMinh;
grant insert on Doan.BIEN_DONG_GIA to BinhMinh;
grant select, update on Doan.CO_SO to BinhMinh;
grant select on Doan.V_HOA_DON to BinhMinh;
grant insert, delete on Doan.CHI_PHI to BinhMinh;
grant insert, update, delete on Doan.TONG_THU to BinhMinh;
grant select, insert, update, delete on Doan.V_HD_TONG_TIEN to BinhMinh;

grant select, insert on Doan.HOA_DON to VanMinh;
grant update on Doan.CT_HOA_DON to VanMinh;
grant delete on Doan.XE_VAN_CHUYEN to VanMinh;
grant select, insert, update on Doan.NHA_CUNG_CAP to VanMinh;
grant update, delete on Doan.CONG_THUC_SAN_PHAM to VanMinh;
grant select, delete on Doan.DANH_SACH_HOA_DON to VanMinh;
grant select, insert, delete on Doan.XEM_TON_KHO to VanMinh;
grant insert, update on Doan.DANH_SACH_NHAN_VIEN to VanMinh;

grant select, insert, update, delete on Doan.KHACH_HANG to GiaKhuong;
grant update on Doan.PHIEU_NHAP to GiaKhuong;
grant select, insert, update on Doan.NGUYEN_LIEU to GiaKhuong;
grant select, delete on Doan.PHIEU_XUAT to GiaKhuong;
grant insert, update on Doan.DANH_SACH_SAN_PHAm to GiaKhuong;
grant select, update, delete on Doan.LOI_NHUAN to GiaKhuong;
grant update, delete on Doan.THONG_TIN_PHIEU_NHAP to GiaKhuong;
grant select, insert, update on Doan.THONG_TIN_CHI_TIET_NHAN_VIEN to GiaKhuong;

revoke delete on Doan.SAN_PHAM from BinhMinh;
revoke update on Doan.CO_SO from BinhMinh;
revoke delete on Doan.CHI_PHI from BinhMinh;
revoke select, update on Doan.V_HD_TONG_TIEN from BinhMinh;

revoke insert on Doan.HOA_DON from VanMinh;
revoke update on Doan.NHA_CUNG_CAP from VanMinh;
revoke delete on Doan.DANH_SACH_HOA_DON from VanMinh;
revoke insert, update on Doan.DANH_SACH_NHAN_VIEN from VanMinh;

revoke update on Doan.KHACH_HANG from GiaKhuong;
revoke delete on Doan.PHIEU_XUAT from GiaKhuong;
revoke delete on Doan.LOI_NHUAN from GiaKhuong;
revoke insert, update on Doan.THONG_TIN_CHI_TIET_NHAN_VIEN from GiaKhuong;




