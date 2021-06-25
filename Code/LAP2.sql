IF EXISTS (SELECT * FROM SYSDATABASES WHERE name = N'quanlylichday')
DROP DATABASE quanlylichday
GO;
--
CREATE DATABASE quanlylichday;
ON
(
NAME = N'quanlylichday',
FILENAME = 'E:\Downloads\COM2034 - Quản trị CSDL SQL\Tai_lieu_lap\quanlylichday.mdf',
size = 5MB,
maxsize = 10MB,
filegrowth = 1MB,
)
log on
(
NAME='quanlylichday_log',
FILENAME='E:\Downloads\COM2034 - Quản trị CSDL SQL\Tai_lieu_lap\quanlylichday.ldf',
size=5MB,
maxsize=10MB,
filegrowth=1MB
)