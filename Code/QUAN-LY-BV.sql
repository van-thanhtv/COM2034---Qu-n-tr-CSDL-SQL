﻿--Ôn tập 2
CREATE DATABASE QUAN_LY_BV;
CREATE TABLE Thuoc(
	MaThuoc VARCHAR(10) PRIMARY KEY,
	TenThuoc NVARCHAR(50),
	Dvt INT,
	Gia DECIMAL (20,0),
	NhomDTri NVARCHAR(50),
);
CREATE TABLE HoSo(
	MaHS VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATE,
	GioiTinh NVARCHAR(10),
	CMND INT UNIQUE,
	NgayLap DATE,
);
CREATE TABLE KhamBenh(
	MaKB VARCHAR(10) PRIMARY KEY,
	MaHS VARCHAR(10),
	NguoiKhamBenh NVARCHAR(50),
	BacSi NVARCHAR(50),
	KetLuan NVARCHAR(100),
);
ALTER TABLE KhamBenh
ADD FOREIGN KEY (MaHS) REFERENCES HoSo(MaHS);
CREATE TABLE ToaThuoc(
	MaKB VARCHAR(10),
	MaThuoc VARCHAR(10),
	SoLuong INT,
	PRIMARY KEY (MaKB,MaThuoc),
	CONSTRAINT FK_1 FOREIGN KEY (MaKB) REFERENCES KhamBenh(MaKB),
	CONSTRAINT FK_2 FOREIGN KEY (MaThuoc) REFERENCES Thuoc(MaThuoc),
);
