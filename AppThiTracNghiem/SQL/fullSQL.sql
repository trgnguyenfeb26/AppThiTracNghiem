USE [TN_CSDLPT]
GO
/****** Object:  User [HTKN]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE USER [HTKN] FOR LOGIN [HTKN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [MSmerge_03F96CF03EB64FD8888EA53ED58FE090]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE ROLE [MSmerge_03F96CF03EB64FD8888EA53ED58FE090]
GO
/****** Object:  DatabaseRole [MSmerge_097E6D8AF2544E8B935D1AF365C4B29D]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE ROLE [MSmerge_097E6D8AF2544E8B935D1AF365C4B29D]
GO
/****** Object:  DatabaseRole [MSmerge_D42B01EB0E9344179755717B1D6C1BA3]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE ROLE [MSmerge_D42B01EB0E9344179755717B1D6C1BA3]
GO
/****** Object:  DatabaseRole [MSmerge_PAL_role]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE ROLE [MSmerge_PAL_role]
GO
ALTER ROLE [db_owner] ADD MEMBER [HTKN]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_03F96CF03EB64FD8888EA53ED58FE090]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_097E6D8AF2544E8B935D1AF365C4B29D]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_D42B01EB0E9344179755717B1D6C1BA3]
GO
/****** Object:  Schema [MSmerge_PAL_role]    Script Date: 31/05/2022 12:58:05 CH ******/
CREATE SCHEMA [MSmerge_PAL_role]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_CheckDaThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_CheckDaThi] (
@MAMH NCHAR(8), 
@MALOP nchar(15), 
@LAN int)
RETURNS NCHAR(1)
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.BANGDIEM
	WHERE  LAN = @LAN AND MAMH = @MAMH AND MASV IN(SELECT MASV FROM SINHVIEN WHERE MALOP = @MALOP)) RETURN 'X'
	RETURN ''
END
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DiemChu]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION  [dbo].[FN_DiemChu]
	(@DIEM FLOAT)
	RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @Pn nvarchar(10), @Pt nvarchar(10)
	SET @Pn = ''
	SET @Pt =''

	IF (@DIEM - FLOOR(@DIEM) = 0.5) 
	BEGIN
		SET @Pt = N' phẩy năm'
		SET @DIEM = @DIEM - 0.5 
	END
	
	IF (@DIEM = 0) SET @Pn = N'Không' 
	ELSE IF (@DIEM = 1) SET @Pn = N'Một' 
	ELSE IF (@DIEM = 2) SET @Pn = N'Hai' 
	ELSE IF (@DIEM = 3) SET @Pn = N'Ba' 
	ELSE IF (@DIEM = 4) SET @Pn = N'Bốn' 
	ELSE IF (@DIEM = 5) SET @Pn = N'Năm' 
	ELSE IF (@DIEM = 6) SET @Pn = N'Sáu' 
	ELSE IF (@DIEM = 7) SET @Pn = N'Bảy' 
	ELSE IF (@DIEM = 8) SET @Pn = N'Tám' 
	ELSE IF (@DIEM = 9) SET @Pn = N'Chín' 
	ELSE IF (@DIEM = 10) SET @Pn = N'Mười'

	RETURN @Pn + @Pt
END
GO
/****** Object:  Table [dbo].[BAITHI]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAITHI](
	[IDBAITHI] [int] NOT NULL,
	[CAUHOI] [int] NOT NULL,
	[DACHON] [nchar](1) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_434433CE398B482C907A92BA8BEBFFF0]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BAITHI] PRIMARY KEY CLUSTERED 
(
	[IDBAITHI] ASC,
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BANGDIEM]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BANGDIEM](
	[MASV] [char](8) NOT NULL,
	[MAMH] [char](5) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[NGAYTHI] [datetime] NULL,
	[DIEM] [float] NULL,
	[BAITHI] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_B1A3E7049B814C32A94870D1B562B388]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BANGDIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BODE]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BODE](
	[CAUHOI] [int] NOT NULL,
	[MAMH] [char](5) NULL,
	[TRINHDO] [char](1) NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [char](1) NULL,
	[MAGV] [char](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_305A09D027F44466834298F562E0223A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BODE] PRIMARY KEY CLUSTERED 
(
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COSO]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSO](
	[MACS] [nchar](3) NOT NULL,
	[TENCS] [nvarchar](50) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_8FB6C8D8904343A688BEAD82CF7FF4B6]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_COSO] PRIMARY KEY CLUSTERED 
(
	[MACS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAGV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MAKH] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_F0FC03E12C684504BE4FEB173DCD4B7A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GIAOVIEN_DANGKY]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DANGKY](
	[MAGV] [char](8) NOT NULL,
	[MAMH] [char](5) NOT NULL,
	[MALOP] [nchar](15) NOT NULL,
	[TRINHDO] [char](1) NOT NULL,
	[NGAYTHI] [datetime] NOT NULL,
	[LAN] [smallint] NOT NULL,
	[SOCAUTHI] [smallint] NOT NULL,
	[THOIGIAN] [smallint] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_4DEF800852D84C39B9EE1730F719778D]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN_DANGKY] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MALOP] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [nchar](8) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[MACS] [nchar](3) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_4BE296F37E9C4A9B8457EA2E26954C41]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOP]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [nchar](15) NOT NULL,
	[TENLOP] [nvarchar](50) NOT NULL,
	[MAKH] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_F94D3E522FCD4AD0B342980109D4416A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [char](5) NOT NULL,
	[TENMH] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_86102A4063464A6C810D752E7475EBEE]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_TENMH] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NOT NULL,
	[TEN] [nvarchar](10) NOT NULL,
	[NGAYSINH] [date] NULL,
	[DIACHI] [nvarchar](100) NULL,
	[MALOP] [nchar](15) NOT NULL,
	[MATKHAU] [varchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_91BE2FE8E2B94DB3BC480F271ACC0C1A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Get_Roles]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_Roles]
AS
SELECT GV.MAGV, GV.HO, GV.TEN, GV.DIACHI, GV.MAKH, sys.sysusers.name
FROM     sys.sysusers CROSS JOIN
                  dbo.GIAOVIEN AS GV
WHERE  (sys.sysusers.uid IN
                      (SELECT groupuid
                       FROM      sys.sysmembers
                       WHERE   (memberuid IN
                                             (SELECT uid
                                              FROM      sys.sysusers AS sysusers_1
                                              WHERE   (name IN
                                                                    (SELECT MAGV
                                                                     FROM      dbo.GIAOVIEN
                                                                     WHERE   (MAGV = GV.MAGV)))))))

GO
/****** Object:  View [dbo].[Get_TaoTK]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_TaoTK]
AS
SELECT MAGV, HO, TEN, DIACHI, MAKH
FROM     dbo.GIAOVIEN
WHERE  (MAGV NOT IN
                      (SELECT MAGV
                       FROM      dbo.Get_Roles)) AND (MAKH IN
                      (SELECT MAKH
                       FROM      dbo.KHOA))

GO
/****** Object:  View [dbo].[Get_SearchSubscribes]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_SearchSubscribes]
AS
SELECT        PUBS.description AS TENCN, SUBS.subscriber_server AS TENSERVER
FROM            dbo.sysmergepublications AS PUBS INNER JOIN
                         dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server
WHERE        (PUBS.description = N'TRA CỨU')

GO
/****** Object:  View [dbo].[Get_Subscribes]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_Subscribes]
AS
SELECT        PUBS.description AS TENCS, SUBS.subscriber_server AS TENSERVER
FROM            dbo.sysmergepublications AS PUBS INNER JOIN
                         dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server
WHERE        (PUBS.name <> 'TN_CSDLPT_TRACUU')

GO
/****** Object:  View [dbo].[Get_SVDaThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_SVDaThi] AS
select SINHVIEN.MASV,HO,TEN,NGAYSINH,DIACHI,MALOP from SINHVIEN, BANGDIEM WHERE SINHVIEN.MASV=BANGDIEM.MASV
GO
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 20, N'X', N'f89febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 21, N'A', N'f29febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 22, N'X', N'f49febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 23, N'X', N'f99febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 24, N'A', N'f39febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 25, N'X', N'fc9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 26, N'X', N'f79febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 27, N'X', N'fa9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 28, N'B', N'eb9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 29, N'B', N'ec9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 50, N'X', N'ee9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 51, N'B', N'ea9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 52, N'X', N'f19febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 53, N'X', N'f69febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 54, N'X', N'f09febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 55, N'X', N'f59febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 56, N'X', N'fb9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 57, N'X', N'fd9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 58, N'X', N'ed9febfc-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BAITHI] ([IDBAITHI], [CAUHOI], [DACHON], [rowguid]) VALUES (2045, 59, N'X', N'ef9febfc-95dc-ec11-8c6a-0cdd242d94ec')
SET IDENTITY_INSERT [dbo].[BANGDIEM] ON 

INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [BAITHI], [rowguid]) VALUES (N'123     ', N'AVCB ', 1, CAST(N'2022-05-26 08:48:50.320' AS DateTime), 1, 2045, N'e99febfc-95dc-ec11-8c6a-0cdd242d94ec')
SET IDENTITY_INSERT [dbo].[BANGDIEM] OFF
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (1, N'MMTCB', N'A', N'mạng máy tính(compute netword) so với hệ thống tập trung multi-user', N'dễ phát triển hệ thống', N'tăng độ tin cậy', N'tiết kiệm chi phí', N'tất cả đều đúng', N'D', N'TH657   ', N'69361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (3, N'MMTCB', N'A', N'để một máy tính truyền dữ liệu cho một số máy khác trong mạng, ta dùng loại địa chỉ', N'Broadcast', N'Broadband', N'multicast', N'multiple access', N'C', N'TH123   ', N'6a361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (4, N'MMTCB', N'A', N'thứ tự phân loại mạng theo chiều dài đường truyền', N'internet, lan, man, wan', N'internet, wan, man, lan', N'lan, wan, man, internet', N'man, lan, wan, internet', N'B', N'TH123   ', N'6b361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (5, N'MMTCB', N'A', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N'TH123   ', N'6c361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (6, N'MMTCB', N'A', N'thuật ngữ man được viết tắt bởi:', N'middle area network', N'metropolitan area network', N'medium area network', N'multiple access network', N'D', N'TH123   ', N'6d361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (7, N'MMTCB', N'A', N'mạng man không kết nối theo sơ đồ:', N'bus', N'ring', N'star', N'tree', N'D', N'TH123   ', N'6e361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (8, N'MMTCB', N'A', N'kiến trúc mạng (network architechture) là:', N'tập các chức năng trong mạng', N'tập các cấp và các protocol trong mỗi cấp', N'tập các dịch vụ trong mạng', N'tập các protocol trong mạng', N'B', N'TH123   ', N'6f361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (9, N'MMTCB', N'A', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N'TH123   ', N'70361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (10, N'MMTCB', N'A', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N'TH123   ', N'71361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (11, N'MMTCB', N'A', N'dịch vụ không xác nhận (unconfirmed) chỉ sử dụng 2 phép toán cơ bản:', N'response and confirm', N'confirm and request', N'request and indication', N'indication and response', N'C', N'TH123   ', N'72361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (12, N'MMTCB', N'A', N'Chọn câu sai trong các nguyên lý phân cấp của mô hình OSI', N'Mỗi cấp thực hiện 1 chức năng rõ ràng', N'Mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'Mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'Mỗi cấp phải cung cấp cùng 1 kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'73361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (13, N'MMTCB', N'A', N'Chức năng của cấp vật lý(physical)', N'Qui định truyền 1 hay 2 chiều', N'Quản lý lỗi sai', N'Xác định thời gian truyền 1 bit dữ liệu', N'Quản lý địa chỉ vật lý', N'C', N'TH123   ', N'74361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (14, N'MMTCB', N'A', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N'TH123   ', N'75361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (15, N'MMTCB', N'A', N'Chức năng cấp mạng (network)', N'Quản lý lưu lượng đường truyền', N'Điều khiển hoạt động subnet', N'Nén dữ liệu', N'Chọn điện áp trên kênh truyền', N'B', N'TH123   ', N'76361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (16, N'MMTCB', N'A', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N'TH123   ', N'77361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (17, N'MMTCB', N'A', N'Cáp xoắn đôi trong mạng LAN dùng đầu nối', N'AUI', N'BNC', N'RJ11', N'RJ45', N'D', N'TH123   ', N'78361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (18, N'MMTCB', N'A', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N'TH123   ', N'79361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (19, N'MMTCB', N'A', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'7a361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (20, N'AVCB ', N'A', N'The publishers suggested that the envelopes be sent to ...... by courier so that the film can be developed as soon as possible', N'they', N'their', N'theirs', N'them', N'D', N'TH234   ', N'7b361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (21, N'AVCB ', N'A', N'Board members ..... carefully define their goals and objectives for the agency before the monthly meeting next week.', N'had', N'should', N'used ', N'have', N'B', N'TH234   ', N'7c361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (22, N'AVCB ', N'A', N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'TH234   ', N'7d361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (23, N'AVCB ', N'A', N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N'TH234   ', N'7e361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (24, N'AVCB ', N'A', N'Making advance arrangements for audiovisual equipment is....... recommended for all seminars.', N'sternly', N'strikingly', N'stringently', N'strongly', N'A', N'TH234   ', N'7f361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (25, N'AVCB ', N'A', N'Two assistants will be required to ...... reporter''s names when they arrive at the press conference', N'remark', N'check', N'notify', N'ensure', N'B', N'TH234   ', N'80361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (26, N'AVCB ', N'A', N'The present government has an excellent ......to increase exports', N'popularity', N'regularity', N'celebrity', N'opportunity', N'D', N'TH234   ', N'81361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (27, N'AVCB ', N'A', N'While you are in the building, please wear your identification badge at all times so that you are ....... as a company employee.', N'recognize', N'recognizing', N'recognizable', N'recognizably', N'C', N'TH234   ', N'82361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (28, N'AVCB ', N'A', N'Our studies show that increases in worker productivity have not been adequately .......rewarded by significant increases in ......', N'compensation', N'commodity', N'compilation', N'complacency', N'B', N'TH234   ', N'83361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (29, N'AVCB ', N'A', N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N'TH234   ', N'84361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (30, N'AVCB ', N'B', N'Battery-operated reading lamps......very well right now', N'sale', N'sold', N'are selling', N'were sold', N'C', N'TH234   ', N'85361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (31, N'AVCB ', N'B', N'In order to place a call outside the office, you have to .......nine first. ', N'tip', N'make', N'dial', N'number', N'D', N'TH234   ', N'86361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (32, N'AVCB ', N'B', N'We are pleased to inform...... that the missing order has been found.', N'you', N'your', N'yours', N'yourseld', N'A', N'TH234   ', N'87361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (33, N'AVCB ', N'B', N'Unfortunately, neither Mr.Sachs....... Ms Flynn will be able to attend the awards banquet this evening', N'but', N'and', N' nor', N'either', N'C', N'TH234   ', N'88361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (34, N'AVCB ', N'B', N'According to the manufacturer, the new generatir is capable of....... the amount of power consumed by our facility by nearly ten percent.', N'reduced', N'reducing', N'reduce', N'reduces', N'B', N'TH234   ', N'89361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (35, N'AVCB ', N'B', N'After the main course, choose from our wide....... of homemade deserts', N'varied', N'various', N'vary', N'variety', N'D', N'TH234   ', N'8a361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (36, N'AVCB ', N'B', N'One of the most frequent complaints among airline passengers is that there is not ...... legroom', N'enough', N'many', N'very', N'plenty', N'A', N'TH234   ', N'8b361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (37, N'AVCB ', N'B', N'Faculty members are planning to..... a party in honor of Dr.Walker, who will retire at the end of the semester', N'carry', N'do', N'hold', N'take', N'D', N'TH234   ', N'8c361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (38, N'AVCB ', N'B', N'Many employees seem more ....... now about how to use the new telephone system than they did before they attended the workshop', N'confusion', N'confuse', N'confused', N'confusing', N'C', N'TH234   ', N'8d361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (39, N'AVCB ', N'B', N'.........our production figures improve in the near future, we foresee having to hire more people between now and July', N'During', N'Only', N'Unless', N'Because', N'D', N'TH234   ', N'8e361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (40, N'AVCB ', N'C', N'Though their performance was relatively unpolished, the actors held the audience''s ........for the duration of the play.', N'attentive', N'attentively', N'attention', N'attentiveness', N'C', N'TH234   ', N'8f361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (41, N'AVCB ', N'C', N'Dr. Abernathy''s donation to Owstion College broke the record for the largest private gift...... give to the campus', N'always', N'rarely', N'once', N'ever', N'C', N'TH234   ', N'90361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (42, N'AVCB ', N'C', N'Savat Nation Park is ....... by train,bus, charter plane, and rental car.', N'accessible', N'accessing', N'accessibility', N'accesses', N'A', N'TH234   ', N'91361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (43, N'AVCB ', N'C', N'In Piazzo''s lastest architectural project, he hopes to......his flare for blending contemporary and traditional ideals.', N'demonstrate', N'appear', N'valve', N'position', N'A', N'TH234   ', N'92361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (44, N'AVCB ', N'C', N'Replacing the offic equipment that the company purchased only three years ago seems quite.....', N'waste', N'wasteful', N'wasting', N'wasted', N'C', N'TH234   ', N'93361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (45, N'AVCB ', N'C', N'On........, employees reach their peak performance level when they have been on the job for at least two years.', N'common', N'standard', N'average', N'general', N'D', N'TH234   ', N'94361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (46, N'AVCB ', N'C', N'We were........unaware of the problems with the air-conidtioning units in the hotel rooms until this week.', N'complete ', N'completely', N'completed', N'completing', N'D', N'TH234   ', N'95361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (47, N'AVCB ', N'C', N'If you send in an order ....... mail, we recommend that you phone our sales division directly to confirm the order.', N'near', N'by', N'for', N'on', N'A', N'TH234   ', N'96361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (48, N'AVCB ', N'C', N'A recent global survey suggests.......... demand for aluminum and tin will remain at its current level for the next five to ten years.', N'which', N'it ', N'that', N'both', N'C', N'TH234   ', N'97361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (49, N'AVCB ', N'C', N'Rates for the use of recreational facilities do not include ta and are subject to change without.........', N'signal', N'cash', N'report', N'notice', N'A', N'TH234   ', N'98361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (50, N'AVCB ', N'A', N'Aswering telephone calls is the..... of an operator', N'responsible', N'responsibly', N'responsive', N'responsibility', N'D', N'TH234   ', N'99361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (51, N'AVCB ', N'A', N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'TH234   ', N'9a361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (52, N'AVCB ', N'A', N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N'TH234   ', N'9b361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (53, N'AVCB ', N'A', N'Because we value your business, we have .......for card members like you to receive one thousand  dollars of complimentary life insurance', N'arrange', N'arranged', N'arranges', N'arranging', N'B', N'TH234   ', N'9c361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (54, N'AVCB ', N'A', N'Employees are........that due to the new government regulations. there is to be no smoking in the factory', N'reminded', N'respected', N'remembered', N'reacted', N'A', N'TH234   ', N'9d361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (55, N'AVCB ', N'A', N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'TH234   ', N'9e361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (56, N'AVCB ', N'A', N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N'TH234   ', N'9f361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (57, N'AVCB ', N'A', N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'TH234   ', N'a0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (58, N'AVCB ', N'A', N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N'TH234   ', N'a1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (59, N'AVCB ', N'A', N'The sales representive''s presentation was difficult to understand ........ he spoke very quickly', N'because', N'althought', N'so that', N'than', N'A', N'TH234   ', N'a2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (60, N'AVCB ', N'B', N'It has been predicted that an.......weak dollar will stimulate tourism in the United States', N'increased', N'increasingly', N'increases', N'increase', N'B', N'TH234   ', N'a3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (61, N'AVCB ', N'B', N'The firm is not liable for damage resulting from circumstances.........its control.', N'beyond', N'above', N'inside', N'around', N'A', N'TH234   ', N'a4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (62, N'AVCB ', N'B', N'Because of.......weather conditions, California has an advantage in the production of fruits and vegetables', N'favorite', N'favor', N'favorable', N'favorably', N'C', N'TH234   ', N'a5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (63, N'AVCB ', N'B', N'On international shipments, all duties and taxes are paid by the..........', N'recipient', N'receiving', N'receipt', N'receptive', N'A', N'TH234   ', N'a6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (64, N'AVCB ', N'B', N'Although the textbook gives a definitive answer,wise managers will look for........ own creative solutions', N'them', N'their', N'theirs', N'they', N'B', N'TH234   ', N'a7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (65, N'AVCB ', N'B', N'Initial ....... regarding the merger of the companies took place yesterday at the Plaza Conference Center.', N'negotiations', N'dedications', N'propositions', N'announcements', N'A', N'TH234   ', N'a8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (66, N'AVCB ', N'B', N'Please......... photocopies of all relevant docunments to this office ten days prior to your performance review date', N'emerge', N'substantiate', N'adapt', N'submit', N'D', N'TH234   ', N'a9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (67, N'AVCB ', N'B', N'The auditor''s results for the five year period under study were .........the accountant''s', N'same', N'same as', N'the same', N'the same as', N'D', N'TH234   ', N'aa361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (68, N'AVCB ', N'B', N'.........has the marketing environment been more complex and subject to change', N'Totally', N'Negatively', N'Decidedly', N'Rarely', N'D', N'TH234   ', N'ab361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (69, N'AVCB ', N'B', N'All full-time staff are eligible to participate in the revised health plan, which becomes effective the first ......... the month.', N'of', N'to', N'from', N'for', N'A', N'TH234   ', N'ac361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (70, N'AVCB ', N'C', N'Contracts must be read........ before they are signed.', N'thoroughness', N'more thorough', N'thorough', N'thoroughly', N'D', N'TH234   ', N'ad361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (71, N'AVCB ', N'C', N'Passengers should allow for...... travel time to the airport in rush hour traffic', N'addition', N'additive', N'additionally', N'additional', N'D', N'TH234   ', N'ae361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (72, N'AVCB ', N'C', N'This fiscal year, the engineering team has worked well together on all phases ofproject.........', N'development', N'developed', N'develops', N'developer', N'A', N'TH234   ', N'af361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (73, N'AVCB ', N'C', N'Mr.Dupont had no ....... how long it would take to drive downtown', N'knowledge', N'thought', N'idea', N'willingness', N'C', N'TH234   ', N'b0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (74, N'AVCB ', N'C', N'Small company stocks usually benefit..........the so called January effect that cause the price of these stocks to rise between November and January', N'unless', N'from', N'to ', N'since', N'B', N'TH234   ', N'b1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (75, N'AVCB ', N'C', N'It has been suggested that employees ........to work in their current positions until the quarterly review is finished.', N'continuity', N'continue', N'continuing', N'continuous', N'B', N'TH234   ', N'b2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (76, N'AVCB ', N'C', N'It is admirable that Ms.Jin wishes to handle all transactions by........, but it might be better if several people shared the responsibility', N'she', N'herself', N'her', N'hers', N'B', N'TH234   ', N'b3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (77, N'AVCB ', N'C', N'This new highway construction project will help the company.........', N'diversity', N'clarify', N'intensify', N'modify', N'A', N'TH234   ', N'b4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (78, N'AVCB ', N'C', N'Ms.Patel has handed in an ........business plan to the director', N'anxious', N'evident', N'eager', N'outstanding', N'D', N'TH234   ', N'b5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (79, N'AVCB ', N'C', N'Recent changes in heating oil costs have affected..........production of turniture', N'local', N'locality', N'locally', N'location', N'A', N'TH234   ', N'b6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (80, N'MMTCB', N'A', N'Termiator là linh kiện dùng trong loại cáp mạng', N'Cáp quang', N'UTP và STP ', N'Xoắn đôi', N'Đồng trục', N'D', N'TH123   ', N'b7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (81, N'MMTCB', N'A', N'Mạng không dây dùng loại sóng nào không bị ảnh hưởng bởi khoảng cách địa lý', N'Sóng radio', N'Sống hồng ngoại', N'Sóng viba', N'Song cực ngắn', N'A', N'TH123   ', N'b8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (82, N'MMTCB', N'A', N'Đường truyền E1 gồm 32 kênh, trong đó sử dụng cho dữ liệu là:', N'32 kênh', N'31 kênh', N'30 kênh', N'24 kênh', N'C', N'TH123   ', N'b9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (83, N'MMTCB', N'A', N'Mạng máy tính thường sử dụng loại chuyển mach', N'Gói (packet switch)', N'Kênh (Circuit switch)', N'Thông báo(message switch)', N'Tất cả đều đúng', N'A', N'TH123   ', N'ba361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (84, N'MMTCB', N'A', N'Cáp UTP hỗ trợ tôc độ truyền 100MBps là loại', N'Cat 3', N'Cat 4', N'Cat 5', N'Cat 6', N'C', N'TH123   ', N'bb361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (85, N'MMTCB', N'A', N'Thiết bị nào làm việc trong cấp vật lý (physical) ', N'Terminator', N'Hub', N'Repeater', N'Tất cả đều đúng', N'D', N'TH123   ', N'bc361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (86, N'MMTCB', N'A', N'Phương pháp dồn kênh phân chia tần số gọi là', N'FDM', N'WDM', N'TDM', N'CSMA', N'A', N'TH123   ', N'bd361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (87, N'MMTCB', N'A', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N'TH123   ', N'be361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (88, N'MMTCB', N'A', N'Nguyên nhân gây sai sót khi gửi/nhận dữ liệu trên mạng', N'Mất đồng bộ trong khi truyền', N'Nhiễu từ môi trường', N'Lỗi phần cứng hoặc phần mềm', N'Tất cả đều đúng ', N'D', N'TH123   ', N'bf361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (89, N'MMTCB', N'A', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N'TH123   ', N'c0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (90, N'MMTCB', N'A', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N'TH123   ', N'c1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (91, N'MMTCB', N'A', N'Hoạt động của protocol Stop and Wait', N'Chờ một khoảng thời gian time-out rồi gửi tiếp frame kế', N'Chờ 1 khoảng thời gian time-out rồi gửi lại frame trước', N'Chờ nhận được ACK của frame trước mới gửi tiếp frame kế', N'Không chờ mà gửi liên tiếp các frame kế nhau', N'C', N'TH123   ', N'c2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (92, N'MMTCB', N'A', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N'TH123   ', N'c3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (93, N'MMTCB', N'A', N'Phương pháp nào được dủng trong việc phát hiện lỗi', N'Timer', N'Ack', N'Checksum', N'Tất cả đều đúng', N'C', N'TH123   ', N'c4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (94, N'MMTCB', N'A', N'Kiểm soát lưu lượng (flow control) có nghĩa là', N'Thay đổi thứ tự truyền frame', N'Điều tiết tốc độ truyền frame', N'Thay đổi thời gian chờ time-out', N'Điều chỉnh kích thước frame', N'B', N'TH123   ', N'c5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (95, N'MMTCB', N'A', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N'TH123   ', N'c6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (96, N'MMTCB', N'A', N'Mạng nào không có khả năng nhận biết tình trạng đường truyền (carrier sence)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng ', N'A', N'TH123   ', N'c7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (97, N'MMTCB', N'A', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N'TH123   ', N'c8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (98, N'MMTCB', N'A', N'Chuẩn mạng nào có khả năng pkhát hiện xung đột (collision) trong khi truyền', N'1-persistent CSMA', N'p-persistent CSMA', N'Non-persistent CSMA', N'CSMA/CD', N'D', N'TH123   ', N'c9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (99, N'MMTCB', N'A', N'Loại mạng cục bộ nào dùng chuẩn CSMA/CD', N'Token-ring', N'Token-bus', N'Ethernet', N'ArcNet', N'C', N'TH123   ', N'ca361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (100, N'MMTCB', N'A', N'Mạng Ethernet được IEEE đưa vào chuẩn', N'IEEE 802.2', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'B', N'TH123   ', N'cb361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (101, N'MMTCB', N'A', N'Chuẩn nào không dùng trong mạng cục bộ (LAN )', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'IEEE 802.6', N'D', N'TH123   ', N'cc361c73-3edc-ec11-8c6a-0cdd242d94ec')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (102, N'MMTCB', N'A', N'Loại mạng nào dùng 1 máy tính làm Monitor để bảo trì mạng', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'B', N'TH123   ', N'cd361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (103, N'MMTCB', N'A', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N'TH123   ', N'ce361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (104, N'MMTCB', N'A', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N'TH123   ', N'cf361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (105, N'MMTCB', N'A', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N'TH123   ', N'd0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (106, N'MMTCB', N'A', N'Chọn câu sai:" Cầu nối (bridge) có thể kết nối các mạng có...."', N'Chiều dài frame khác nhau', N'Cấu trúc frame khác nhau', N'Tốc độ truyền khác nhau', N'Chuẩn khác nhau', N'A', N'TH123   ', N'd1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (107, N'MMTCB', N'A', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N'TH123   ', N'd2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (108, N'MMTCB', N'A', N'Mạng Ethernet sử dụng được loại cáp', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúgn', N'D', N'TH123   ', N'd3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (109, N'MMTCB', N'A', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N'TH123   ', N'd4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (110, N'MMTCB', N'A', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N'TH123   ', N'd5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (111, N'MMTCB', N'A', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N'TH123   ', N'd6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (112, N'MMTCB', N'A', N'Kiểu datagram trong cấp network', N'Chỉ tìm đường 1 lần khi tạo kết nối', N'Phải tìm đường riêng cho từng packet', N'THông tin có sẵn trong packet, không cần tìm đường', N'Thông tin có sẵn trong router , không cần tìm đường', N'B', N'TH123   ', N'd7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (113, N'MMTCB', N'A', N'Kiểm soát tắc nghẽn (congestion) là nhiệm vụ của cấp', N'Physical', N'Transport', N'Data link', N'Network', N'D', N'TH123   ', N'd8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (114, N'MMTCB', N'A', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N'TH123   ', N'd9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (115, N'MMTCB', N'A', N'Cấp appliation trong mô hình TCP/IP tương đương với cấp nào trong mô hình OSI', N'Session', N'Application', N'Presentation', N'Tất cả đều đúng', N'D', N'TH123   ', N'da361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (116, N'MMTCB', N'A', N'Cấp nào trong mô hình mạng OSI tương đương với cấp Internet trong mô hình TCP/IP ', N'Network', N'Transport', N'Physical', N'Data link', N'A', N'TH123   ', N'db361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (117, N'MMTCB', N'A', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N'TH123   ', N'dc361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (118, N'MMTCB', N'A', N'Kỹ thuật Multiplexing được dùng khi', N'Có nhiều kênh truyền hơn đường truyền', N'Có nhiều đường truyền hơn kênh truyền', N'Truyền dữ liệu số trên mạng điện thoại', N'Truyền dữ liệu tương tự trên mạng điện thọai', N'A', N'TH123   ', N'dd361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (119, N'MMTCB', N'A', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N'TH123   ', N'de361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (120, N'MMTCB', N'A', N'Địa chỉ IP lớp B nằm trong phạm vi nào', N'192.0.0.0 - 223.0.0.0', N'127.0.0.0 - 191.0.0.0', N'128.0.0.0 - 191.0.0.0 ', N'1.0.0.0 - 126.0.0.0', N'C', N'TH123   ', N'df361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (121, N'MMTCB', N'A', N'Subnet Mask nào sau đây chỉ cho tối đa 2 địa chỉ host', N'255.255.255.252', N'255.255.255.254', N'255.255.255.248', N'255.255.255.240', N'A', N'TH123   ', N'e0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (122, N'MMTCB', N'A', N'Thành phần nào không thuộc socket', N'Port', N'Địa chỉ IP', N'Địa chỉ cấp MAC', N'Protocol cấp Transport', N'C', N'TH123   ', N'e1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (123, N'MMTCB', N'A', N'Mục đích của Subnet Mask trong địa chỉ IP là', N'Xác định host của địa chỉ IP', N'Xác định vùng network của địa chỉ IP', N'Lấy các bit trong vùng subnet làm địa chỉ host', N'Lấy các bit trong vùng địa chỉ host làm subnet', N'A', N'TH123   ', N'e2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (124, N'MMTCB', N'A', N'Bước đầu tiên cần thực hiện để truyền dữ liệu theo ALOHA là', N'Chờ 1 thời gian ngẫu nhiên', N'Gửi tín hiệu tạo kết nối', N'Kiểm tra tình trạng đường truyền', N'Lập tức truyền dữ liệu', N'D', N'TH123   ', N'e3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (125, N'MMTCB', N'A', N'Cầu nối trong suốt hoạt động trong cấp nào', N'Data link', N'Physical', N'Network', N'Transport', N'A', N'TH123   ', N'e4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (126, N'MMTCB', N'A', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N'TH123   ', N'e5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (127, N'MMTCB', N'A', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N'TH123   ', N'e6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (128, N'MMTCB', N'A', N'Loại frame nào được sử dụng trong mạng Token-ring', N'Monitor', N'Token', N'Data', N'Token và Data', N'D', N'TH123   ', N'e7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (129, N'MMTCB', N'A', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N'TH123   ', N'e8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (130, N'MMTCB', N'A', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N'TH123   ', N'e9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (131, N'MMTCB', N'A', N'Trong mạng cục bộ, để xác định 1 máy trong mạng ta dùng địa chỉ', N'MAC', N'Socket', N'Domain', N'Port', N'A', N'TH123   ', N'ea361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (132, N'MMTCB', N'A', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N'TH123   ', N'eb361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (133, N'MMTCB', N'A', N'Cấp vật lý (physical) không quản lý', N'Mức điện áp', N'Địa chỉ vật lý', N'Mạch giao tiếp vật lý', N'Truyền các bit dữ liêu', N'B', N'TH123   ', N'ec361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (134, N'MMTCB', N'A', N'TCP sử dụng loại dịch vụ', N'Có kết nối, độ tin cậy cao', N'Có kết nối, độ tin cậy thấp', N'Không kết nối, độ tin cậy cao', N'Không kết nối, độ tin cậy thấp', N'A', N'TH123   ', N'ed361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (135, N'MMTCB', N'A', N'Địa chỉ IP bao gồm', N'Địa chỉ Network và địa chỉ host', N'Địa chỉ physical và địa chỉ logical', N'Địa chỉ cấp MAC và và địa chỉ LLC', N'Địa chỉ hardware và địa chỉ software', N'A', N'TH123   ', N'ee361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (136, N'MMTCB', N'A', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N'TH123   ', N'ef361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (137, N'MMTCB', N'A', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N'TH123   ', N'f0361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (138, N'MMTCB', N'A', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N'TH123   ', N'f1361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (139, N'MMTCB', N'A', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N'TH123   ', N'f2361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (140, N'MMTCB', N'A', N'Chức năng của cấp Network là', N'Tìm đường', N'Mã hóa dữ liệu', N'Tạo địa chỉ vật lý', N'Kiểm soát lưu lượng', N'A', N'TH123   ', N'f3361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (141, N'MMTCB', N'B', N'Sự khác nhau giữa địa chỉ cấp Data link và Network là', N'Địa chỉ cấp Data link có kích thước nhỏ hơn địa chỉ cấp Network', N'Địa chỉ cấp Data link là đia chỉ Physic, địa chỉ cấp Network là địa chỉ Logic', N'Địa chỉ cấp Data Link là địa chỉ Logic, địa chỉ câp Network là địa chỉ Physic', N'Địa chỉ Data link cấu hình theo mạng, địa chỉ cấp Network xác định theo IEEE', N'B', N'TH123   ', N'f4361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (142, N'MMTCB', N'B', N'Kỹ thuật nào không sử dụng được trong việc kiểm soát lưu lượng(flow control)', N'Ack', N'Buffer', N'Windowing', N'Multiplexing', N'D', N'TH123   ', N'f5361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (143, N'MMTCB', N'B', N'Cấp cao nhất trong mô hình mạng OSI là', N'Transport', N'Physical', N'Network', N'Application', N'D', N'TH123   ', N'f6361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (144, N'MMTCB', N'B', N'Tại sao mạng máy tình dùng mô hình phân cấp', N'Để mọi người sử dụng cùng 1 ứng dụng mạng', N'Để phân biệt giữa chuẩn mạng và ứng dụng mạng', N'Giảm độ phức tạp trong việc thiết kế và cài đặt', N'Các cấp khác không cần sửa đổi khi thay đổi 1 cấp mạng', N'D', N'TH123   ', N'f7361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (145, N'MMTCB', N'B', N'Router làm gì để giảm tăc nghẽn (congestion)', N'Nén dữ liệu', N'Lọc bớt dữ liệu theo địa chỉ vật lý', N'Lọc bớt dữ liệu theo địa chỉ logic', N'Cấm truyền dữ liệu broadcasr', N'D', N'TH123   ', N'f8361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (146, N'MMTCB', N'B', N'Byte đầu của 1 IP có giá trị 222, địa chỉ này thuộc lớp địa chỉ nào', N'Lớp A', N'Lớp B', N'Lớp C', N'Lớp D', N'C', N'TH123   ', N'f9361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (147, N'MMTCB', N'B', N'Chọn câu đúng đối với switch của mạng LAN', N'Là 1 cầu nối tốc độ cao', N'Nhận data từ 1 cổng và xuất ra mọi cổng còn lại', N'Nhận data từ 1 cổng và xuất ra  cổng đích tùy theo địa chỉ cấp IP', N'Nhận data từ 1 cổng và xuất ra 1 cổng đích tùy theo địa chỉ cấp MAC', N'D', N'TH123   ', N'fa361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (148, N'MMTCB', N'B', N'Thuật ngữ nào cho biết loại mạng chỉ truyền được  chiều tại 1 thời điểm', N'Half duplex', N'Full duplex', N'Simplex', N'Monoplex', N'A', N'TH123   ', N'fb361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (149, N'MMTCB', N'B', N'Protocol nghĩa là', N'Tập các chuẩn truyền dữ liệu', N'Tập các cấp mạng trong mô hình OSI', N'Tập các chức năng của từng cấp trong mạng', N'Tập các qui tắc và cấu trúc dữ liệu để truyền thông giữa các cấp mạng', N'D', N'TH123   ', N'fc361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (150, N'MMTCB', N'B', N'Truyền dữ liệu theo kiểu có kết nối không cần thực hiện việc', N'Hủy kết nối', N'Tạo kết nối', N'Truyền dữ liệu', N'Tìm đường cho từng gói tin', N'D', N'TH123   ', N'fd361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (151, N'MMTCB', N'B', N'Byte đầu của địa chỉ IP lớp E nằm trong phạm vi', N'128 - 191', N'192 - 232 ', N'224 - 239 ', N'240 - 247', N'D', N'TH123   ', N'fe361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (152, N'MMTCB', N'B', N'Khi truyền đi chuỗi "VIET NAM" nhưng nhận được chuỗi"MAN TEIV ". Cần phải hiệu chỉnh các protocol trong cấp nào để truyền chính xác', N'Session', N'Transport', N'Application', N'Presentation', N'B', N'TH123   ', N'ff361c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (153, N'MMTCB', N'B', N'Tên cáp UTP dùng torng mạng Fast Ethernet là', N'100BaseF', N'100Base2', N'100BaseT', N'100Base5', N'C', N'TH123   ', N'00371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (154, N'MMTCB', N'B', N'Tốc độ truyền của mạng Ethernet là', N'1 Mbps', N'10 Mbps', N'100 Mbps', N'1000 Mbps', N'B', N'TH123   ', N'01371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (155, N'MMTCB', N'B', N'Dịch vụ mạng thường được phân chia thành', N'Dịch vụ không kết nối và có kết nối', N'Dich vụ có xác nhận và không xác nhận', N'Dịch vụ có độ tin cậy cao và có độ tin cậy thấp', N'Tất cả đều đúng', N'D', N'TH123   ', N'02371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (156, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu trong cấp Network gọi là', N'Bit', N'Frame', N'Packet', N'Segment', N'C', N'TH123   ', N'03371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (157, N'MMTCB', N'B', N'Protocol nào trong mạng TCP/IP chuyển đổi địa chỉ vật lý thành địa chỉ IP', N'IP', N'ARP', N'ICMP', N'RARP', N'D', N'TH123   ', N'04371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (158, N'MMTCB', N'B', N'Đầu nới AUI dùng cho loại cáp nào?', N'Đồng trục', N'Xoắn đôi', N'Cáp quang', N'Tất cả đều đúng', N'A', N'TH123   ', N'05371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (159, N'MMTCB', N'B', N'Subnet mask chuẩn của địa chỉ IP lớp B là', N'255.0.0.0', N'255.255.0.0', N'255.255.255.0', N'255.255.255.255', N'B', N'TH123   ', N'06371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (160, N'MMTCB', N'B', N'Lý do nào khiến người ta chọn protocol TCP hơn là UDP', N'Không ACK', N'Dễ sử dụng', N'Độ tin cậy', N'Không kết nối', N'C', N'TH123   ', N'07371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (161, N'MMTCB', N'B', N'Nhược điểm của dịch vụ có kết nối so với không kết nối', N'Độ tin cậy', N'Thứ tự nhận dữ liệu không đúng', N'Đường truyền không thay đổi', N'Đường truyền thay đổi liên tục', N'C', N'TH123   ', N'08371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (162, N'MMTCB', N'B', N'Cấp Data link không thực hiện chức năng nào?', N'Kiểm soát lỗi', N'Địa chỉ vật lý', N'Kiểm soát lưu lượng', N'Thiết lập kết nối', N'D', N'TH123   ', N'09371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (163, N'MMTCB', N'B', N'Cầu nối (bridge)dựa vào thông tin nào để truyền tiếp hoặc hủy bỏ 1 frame', N'Điạ chỉ nguồn', N'Địa chỉ đích', N'Địa chỉ mạng', N'Tất cả đều đúng', N'C', N'TH123   ', N'0a371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (164, N'MMTCB', N'B', N'Chuẩn nào sử dụng trong cấp presentation?', N'UTP và STP', N'SMTP và HTTP', N'ASCII và EBCDIC', N'TCP và UDP', N'C', N'TH123   ', N'0b371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (165, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu giữa các cấp trong mạng theo thứ tự', N'bit,frame,packet,data', N'bit,packet,frame,data', N'data,frame,packet,bit', N'data,bit,packet,frame', N'A', N'TH123   ', N'0c371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (166, N'MMTCB', N'B', N'Mạng Ethernet do cơ quan nào phát minh', N'ANSI', N'ISO', N'IEEE', N'XEROX', N'D', N'TH123   ', N'0d371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (167, N'MMTCB', N'B', N'Chiều dài loại cáp nào tối đa 100 m? ', N'10Base2', N'10Base5', N'10BaseT', N'10BaseF', N'C', N'TH123   ', N'0e371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (168, N'MMTCB', N'B', N'Địa chỉ IP 100.150.200.250 có nghĩa là', N'Địa chỉ network 100, địa chỉ host 150.200.250', N'Địa chỉ network 100.150, địa chỉ host 200.250', N'Địa chỉ network 100.150.200, địa chỉ host 250', N'Tất cả đều sai', N'D', N'TH123   ', N'0f371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (169, N'MMTCB', N'B', N'Switching hun khác hub thông thường ở chỗ nó làm', N'Giảm collision trên mạng', N'Tăng collision trên mạng', N'Giảm congestion trên mạng', N'Tăng congestion trên mạng', N'A', N'TH123   ', N'10371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (170, N'MMTCB', N'B', N'Loại cáp nào chỉ truyền dữ liệu 1 chiều', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúng', N'A', N'TH123   ', N'11371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (171, N'MMTCB', N'B', N'Thiết bị Modem dùng để', N'Tách và ghép tín hiệu', N'Nén và gải nén tín hiệu', N'Mã hóa và giải mã tín hiệu', N'Điều chế và giải điều chế tín hiệu', N'D', N'TH123   ', N'12371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (172, N'MMTCB', N'B', N'Việc cấp phát kênh truyền áp dụng cho loại mạng', N'Peer to peer', N'Point to point', N'Broadcast', N'Multiple Access', N'C', N'TH123   ', N'13371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (173, N'MMTCB', N'B', N'Mạng nào dùng phương pháp mã hóa Manchester Encoding', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều đúng ', N'D', N'TH123   ', N'14371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (174, N'MMTCB', N'B', N'Phương pháp tìm đường có tính đến thời gian trễ', N'Tìm đường theo chiều sâu', N'Tìm đường theo chiều rộng', N'Tìm đường theo vector khoảng cách', N'Tìm đường theo trạng thái đường truyền', N'D', N'TH123   ', N'15371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (175, N'MMTCB', N'B', N'Chuẩn mạng nào khi có dữ liệu không truyền ngay mà chờ 1 thời gian ngẫu nhiên?', N'1-presistent CSMA', N'p-presistent CSMA', N'Non-presistent CSMA', N'CSMA/CD', N'C', N'TH123   ', N'16371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (176, N'MMTCB', N'B', N'Phương pháp chèn bit (bit stuffing) được dùng để', N'Phân biệt đầu và cuối frame', N'Bổ sung cho đủ kích thước frame tối thiểu', N'Phân cách nhiều bit 0 bằng bit 1', N'Biến đổi dạng dữ liệu 8 bit ra 16 bit', N'A', N'TH123   ', N'17371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (177, N'MMTCB', N'B', N'Để chống nhiễu trên đường truyền tốt nhất, nên dùng loại cáp:', N'Xoắn đôi', N'Đồng trục', N'Cáp quang', N'Mạng không dây', N'C', N'TH123   ', N'18371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (178, N'MMTCB', N'B', N'Phần mềm gửi/nhận thư điện tử thuộc cấp nào trong mô hình OSI', N'Data link', N'Network', N'Application', N'Presentation', N'C', N'TH123   ', N'19371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (179, N'MMTCB', N'B', N'Chức năng của thiết bị Hub trong mạng LAN', N'Mã hóa tín hiệu', N'Triệt tiêu tín hiệu', N'Phân chia tín hiệu', N'Điều chế tín hiếu', N'C', N'TH123   ', N'1a371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (180, N'MMTCB', N'B', N'Switch là thiết bị mạng làm việc tương tự như', N'Hub', N'Repeater', N'Router', N'Bridge', N'D', N'TH123   ', N'1b371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (181, N'MMTCB', N'C', N'Thiết bị nào làm việc trong cấp Network', N'Bridge', N'Repeater', N'Router', N'Gateway', N'C', N'TH123   ', N'1c371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (182, N'MMTCB', N'C', N'Thiết bị nào cần có bộ nhớ làm buffer', N'Hub', N'Switch', N'Repeater', N'Router', N'D', N'TH123   ', N'1d371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (183, N'MMTCB', N'C', N'Luật 5-4-3 cho phép tối đa', N'5 segment trong 1 mạng', N'5 repeater trong 1 mạng', N'5 máy tính trong 1 mạng', N'5 máy tính trong 1 segment', N'A', N'TH123   ', N'1e371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (184, N'MMTCB', N'C', N'Thiết bị nào có thể thêm vào mạng LAN mà không sợ vi phạm luật 5-4-3', N'Router', N'Repeater', N'Máy tính', N'Tất cả đều đúng', N'A', N'TH123   ', N'1f371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (185, N'MMTCB', N'C', N'Thêm thiết bị nào vào mạng có thể qui phạm luật 5-4-3', N'Router', N'Repeater', N'Bridge', N'Tất cả đều đúng', N'B', N'TH123   ', N'20371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (186, N'MMTCB', N'C', N'Mạng nào cóxảy ra xung đột (collision) trên đường truyền', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'A', N'TH123   ', N'21371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (187, N'MMTCB', N'C', N'Từ "Broad" trong tên cáp 10Broad36 viết tắt bởi', N'Broadcast', N'Broadbase', N'Broadband', N'Broadway', N'C', N'TH123   ', N'22371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (188, N'MMTCB', N'C', N'Protocol nào sử dụng trong cấp Network', N'IP', N'TCP', N'UDP', N'FTP', N'A', N'TH123   ', N'23371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (189, N'MMTCB', N'C', N'Protocol nào torng cấp Transport cung cấp dịch vụ không kết nối', N'IP', N'TCP', N'UDP', N'FTP', N'C', N'TH123   ', N'24371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (190, N'MMTCB', N'C', N'Protocol nào trong cấp Transport dùng kiểu dịch vụ có kết nối?', N'IP', N'TCP', N'UDP', N'FTP', N'B', N'TH123   ', N'25371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (191, N'MMTCB', N'C', N'Địa chỉ IP được chia làm mấy lớp', N'2', N'3', N'4', N'5', N'D', N'TH123   ', N'26371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (192, N'MMTCB', N'C', N'Chức năng nào không phải của cấp Network', N'Tìm đường', N'Địa chỉ logic', N'Kiểm soát tắc nghẽn', N'Chất lượng dịch vụ', N'B', N'TH123   ', N'27371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (193, N'MMTCB', N'C', N'Phương pháp chèn kí tự dùng để', N'Phân cách các frame', N'Phân biệt dữ liệu và ký tự điều khiển', N'Nhận diện đầu cuối frame', N'Bổ sung cho đủ kich thước frame tối thiểu', N'B', N'TH123   ', N'28371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (194, N'MMTCB', N'C', N'Kỹ thuật truyền nào mã hóa trực tiếp dữ liệu ra đường truyền không cần sóng mang', N'Broadcast', N'Digital', N'Baseband', N'Broadband', N'C', N'TH123   ', N'29371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (195, N'MMTCB', N'C', N'Sóng viba sử dụng băng tần', N'SHF', N'LF và MF', N'UHF và VHF', N'Tất cả đều đúng', N'D', N'TH123   ', N'2a371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (196, N'MMTCB', N'C', N'Sóng viba bị ảnh hưởng bời', N'Trời mưa', N'Sấm chớp', N'Giông bão', N'Ánh sáng mặt trời', N'A', N'TH123   ', N'2b371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (197, N'MMTCB', N'C', N'Đường dây trung kế trong mạng điện thoại sử dụng', N'Tín hiệu số', N'Kỹ thuật dồn kênh', N'Cáp quang, cáp đồng và viba', N'Tất cả đêu đúng', N'D', N'TH123   ', N'2c371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (198, N'MMTCB', N'C', N'Cáp quang dùng công nghệ dồn kênh nào', N'TDM', N'FDM', N'WDM', N'CDMA', N'C', N'TH123   ', N'2d371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (199, N'MMTCB', N'C', N'Nhược điểm của phương pháp chèn ký tự', N'Giảm tốc độ đường truyền', N'Tăng phí tổn đường truyền', N'Mất đồng bộ frame', N'Không nhận diện được frame', N'B', N'TH123   ', N'2e371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (200, N'MMTCB', N'C', N'Mất đồng bộ frame xảy ra đối với phương pháp', N'Chèn bit', N'Đếm ký tự', N'Chèn ký tự', N'Tất cả đều đúng', N'B', N'TH123   ', N'2f371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (201, N'MMTCB', N'C', N'Mạng nào dùng công nghệ Token-bus', N'FDDI', N'CDDI', N'Fast Ethernet', N'100VG-AnyLAN', N'D', N'TH123   ', N'30371c73-3edc-ec11-8c6a-0cdd242d94ec')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (202, N'MMTCB', N'C', N'Thiết bị nào tự trao đổi thông tin lẫn nhau để quản lý mạng', N'Hub', N'Bridge', N'Router', N'Repeater', N'C', N'TH123   ', N'31371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (203, N'MMTCB', N'C', N'Tần số sóng điện từ dùng trong mạng vô tuyến sắp theo thứ tự tăng dần', N'Radio,viba,hồng ngoại', N'Radio,hồng ngoại,viba', N'Hồng ngoại,viba,radio', N'Viba,radio,hồng ngoại', N'A', N'TH123   ', N'32371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (204, N'MMTCB', N'C', N'Đường dây hạ kế (local loop) trong mạch điện thoại dùng tín hiệu', N'Digital', N'Analog', N'Manchester', N'T1 hoặc E1', N'B', N'TH123   ', N'33371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (205, N'MMTCB', N'C', N'Để tránh nhận trùng dữ liệu người ta dùng phương pháp', N'Đánh số thứ tự các frame', N'Quy định kích thước frame cố định', N'Chờ nhận ACK mới gửi frame kế tiếp', N'So sánh và loại bỏ các frame giống nhau', N'A', N'TH123   ', N'34371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (206, N'MMTCB', N'C', N'Cơ chế Timer dùng để', N'Đo thời gian chơ frame', N'Tránh tình trạng mất frame', N'Chọn thời điểm truyền frame', N'Kiểm soát thòi gian truyền frame', N'A', N'TH123   ', N'35371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (207, N'MMTCB', N'C', N'Cấp nào trong mô hình OSI quan tâm tới topology mạng', N'Transport', N'Network', N'Data link', N'Physical', N'B', N'TH123   ', N'36371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (208, N'MMTCB', N'C', N'Loại mạng nào sử dụng trên WAN', N'Ethernet và Token-bus', N'ISDN và Frame relay', N'Token-ring và FDDI', N'SDLC và HDLC', N'A', N'TH123   ', N'37371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (209, N'MMTCB', N'C', N'Repeater nhiều port là tên gọi của', N'Hub', N'Host', N'Bridge', N'Router', N'A', N'TH123   ', N'38371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (210, N'MMTCB', N'C', N'Đơn vị đo tốc độ đường truyền', N'bps(bit per second)', N'Bps(Byte per second)', N'mps(meter per second)', N'hertz (ccle per second)', N'A', N'TH123   ', N'39371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (211, N'MMTCB', N'C', N'Repeater dùng để', N'Lọc bớt dữ liệu trên mạng', N'Tăng tốc độ lưu thông trên mạng', N'Tăng thời gian trễ trên mạng', N'Mở rộng chiều dài đường truyền', N'D', N'TH123   ', N'3a371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (212, N'MMTCB', N'C', N'Cáp đồng trục (coaxial)', N'Có 4 đôi dây', N'Không cần repeater', N'Truyền tín hiệu ánh sáng', N'Chống nhiễu tốt hơn UTP', N'D', N'TH123   ', N'3b371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (213, N'MMTCB', N'C', N'Câp Data link ', N'Truyền dữ liệu cho các cấp khác trong mạng', N'Cung cấp dịch vụ cho chương trình ứng dụng', N'Nhận tín hiệu yếu,lọc,khuếch đại và phát lại trên mạng', N'Bảo đảm đường truyền dữ liệu tin cậy giữa 2 đầu đường truyền', N'D', N'TH123   ', N'3c371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (214, N'MMTCB', N'C', N'Địa chỉ IP còn gọi là', N'Địa chĩ vật lý', N'Địa chỉ luận lý', N'Địa chỉ thập phân', N'Địa chỉ thập lục phân', N'B', N'TH123   ', N'3d371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (215, N'MMTCB', N'C', N'Cấp Presentation', N'Thiết lập, quản lý và kết thúc các ứng dụng', N'Hướng dẫn cách mô tả hình ảnh, âm thanh, tiếng nói', N'Cung cấp dịch vụ truyền dữ liệu từ nguồn đến đích', N'Hỗ trợ việc truyền thông trong các ứng dụng như web, mail...', N'C', N'TH123   ', N'3e371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (216, N'MMTCB', N'C', N'Tập các luật để định dạng và truyền dữ liệu gọi là', N'Qui luật (rule)', N'Nghi thức (protocol)', N'Tiêu chuẩn (standard)', N'Mô hình (model)', N'B', N'TH123   ', N'3f371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (217, N'MMTCB', N'C', N'Tại sao cần có tiêu chuẩn về mang', N'Định hướng phát triển phần cứng và phần mềm mới', N'LAN,MAN và WAN sử dụng các thiết bị khác nhau', N'Kết nối mạng giữa các quôc gia khác nhau', N'Tương thích về công nghệ để truyền thông được lẫn nhau', N'D', N'TH123   ', N'40371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (218, N'MMTCB', N'C', N'Dữ liệu truyền trên mạng bằng', N'Mã ASCII', N'Số nhị phân', N'Không và một', N'Xung điện áp', N'D', N'TH123   ', N'41371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (219, N'MMTCB', N'C', N'Mạng CSMA/CD', N'Kiểm tra để bảo đảm dữ liệu truyền đến đích', N'Kiểm tra đường truyền nếu rảnh mới truyền dữ liệu', N'Chờ 1 thời gian ngẫu nhiên rồi truyền  dữ liệu kế tiếp', N'Tất cả đều đúng', N'B', N'TH123   ', N'42371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (220, N'MMTCB', N'C', N'Địa chỉ MAC ', N'Gồm có 32 bit', N'Còn gọi là địa chỉ logic', N'Nằm trong cấp Network', N'Dùng để phân biệt các máy trong mạng', N'D', N'TH123   ', N'43371c73-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS1', N'Cơ sở 1 ', N'11 Nguyễn Đình Chiểu, Phường Đakao, Quận 1, TP. HCM', N'3200ceed-31ce-ec11-8c66-0cdd242d94ec')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS2', N'Cơ sở 2', N'Số 9 Man Thiện , quận 9, TP. HCM', N'3300ceed-31ce-ec11-8c66-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH101   ', N'KIEU DAC', N'THIEN', N'9,3A, Q.BINH TAN', N'CNTT    ', N'8dc9b823-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH123   ', N'PHAN VAN ', N'HAI', N'15/72 LE VAN THO F8 GO VAP', N'CNTT    ', N'8ec9b823-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH234   ', N'DAO VAN ', N'TUYET', N'14/7 BUI DINH TUY TAN BINH', N'CNTT    ', N'8fc9b823-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH657   ', N'PHAN HONG', N'NGOC', N'', N'VT      ', N'90c9b823-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH678   ', N'PHAN THANH ', N'NGOC', N'TAN PHU TPHCM', N'VT      ', N'a830a4eb-3edc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'AVCB ', N'D18CQCN01      ', N'A', CAST(N'2022-05-25 00:00:00.000' AS DateTime), 1, 10, 15, N'12b8fa03-40dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH04           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 1, 20, 15, N'd8eb3d61-95dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'MMTCB', N'TH04           ', N'B', CAST(N'2022-05-25 00:00:00.000' AS DateTime), 1, 15, 20, N'fc0efb36-41dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'CNTT    ', N'Công nghệ thông tin', N'CS1', N'b122fc4b-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'DT      ', N'Điện tử', N'CS2', N'b222fc4b-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'VT      ', N'Viễn thông', N'CS2', N'b322fc4b-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D18CQCN01      ', N'Ngành CNTT Khóa 2018 -1', N'CNTT    ', N'5fbc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH04           ', N'TIN HOC 2004', N'CNTT    ', N'60bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH05           ', N'TIN HOC 2005', N'CNTT    ', N'61bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH06           ', N'TIN HOC 2006', N'CNTT    ', N'62bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH07           ', N'TIN HOC 2007', N'CNTT    ', N'63bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH08           ', N'TIN HOC 2008', N'CNTT    ', N'64bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'VT04           ', N'VIỄN THÔNG 2004', N'VT      ', N'65bc49d8-3ddc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'AVCB ', N'ANH VĂN CĂN BẢN', N'e9611de9-38dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDL ', N'CƠ SỞ DỮ LIỆU', N'eb611de9-38dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CTDL ', N'CẤU TRÚC DỮ LIỆU', N'ea611de9-38dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'MMTCB', N'MẠNG MÁY TÍNH CĂN BẢN', N'ec611de9-38dc-ec11-8c6a-0cdd242d94ec')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'123     ', N'Nguyên Trung', N'Nguyên', CAST(N'2001-02-26' AS Date), N'Tân phú', N'TH04           ', N'202CB962AC59075B964B07152D234B70', N'3605a628-40dc-ec11-8c6a-0cdd242d94ec')
/****** Object:  Index [unique_tenbaithi]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[BANGDIEM] ADD  CONSTRAINT [unique_tenbaithi] UNIQUE NONCLUSTERED 
(
	[BAITHI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_tencoso]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[COSO] ADD  CONSTRAINT [unique_tencoso] UNIQUE NONCLUSTERED 
(
	[TENCS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_tenkhoa]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[KHOA] ADD  CONSTRAINT [unique_tenkhoa] UNIQUE NONCLUSTERED 
(
	[TENKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENLOP]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [UN_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_tenlop]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [unique_tenlop] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENMH]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [UN_TENMH] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_monhoc]    Script Date: 31/05/2022 12:58:05 CH ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [unique_monhoc] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAITHI]  WITH CHECK ADD  CONSTRAINT [fk_bai_thi] FOREIGN KEY([IDBAITHI])
REFERENCES [dbo].[BANGDIEM] ([BAITHI])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [fk_bai_thi]
GO
ALTER TABLE [dbo].[BAITHI]  WITH CHECK ADD  CONSTRAINT [fk_cau_hoi] FOREIGN KEY([CAUHOI])
REFERENCES [dbo].[BODE] ([CAUHOI])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [fk_cau_hoi]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_MONHOC]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_SINHVIEN1] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_SINHVIEN1]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_GIAOVIEN] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_GIAOVIEN]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_MONHOC]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_KHOA]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1]
GO
ALTER TABLE [dbo].[KHOA]  WITH CHECK ADD  CONSTRAINT [FK_KHOA_COSO] FOREIGN KEY([MACS])
REFERENCES [dbo].[COSO] ([MACS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHOA] CHECK CONSTRAINT [FK_KHOA_COSO]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_DIEM]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_LANTHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_LANTHI]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [repl_identity_range_BDF44F4F_494E_45FA_B665_5B1444F7441B] CHECK NOT FOR REPLICATION (([BAITHI]>=(1) AND [BAITHI]<=(1001) OR [BAITHI]>(1001) AND [BAITHI]<=(2001)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [repl_identity_range_BDF44F4F_494E_45FA_B665_5B1444F7441B]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_BODE] CHECK  (([TRINHDO]='A' OR [TRINHDO]='B' OR [TRINHDO]='C'))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_BODE]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN] CHECK  (([DAP_AN]='D' OR ([DAP_AN]='C' OR ([DAP_AN]='B' OR [DAP_AN]='A'))))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_DAPAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_LAN] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_LAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_SOCAUTHI] CHECK  (([SOCAUTHI]>=(10) AND [SOCAUTHI]<=(100)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_SOCAUTHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_THOIGIAN] CHECK  (([THOIGIAN]>=(15) AND [THOIGIAN]<=(60)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_THOIGIAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_TRINHDO] CHECK  (([TRINHDO]='C' OR ([TRINHDO]='B' OR [TRINHDO]='A')))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_TRINHDO]
GO
/****** Object:  StoredProcedure [dbo].[NewSelectCommand]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewSelectCommand]
AS
	SET NOCOUNT ON;
SELECT Get_SVDaThi.*
FROM     Get_SVDaThi
GO
/****** Object:  StoredProcedure [dbo].[ScalarQuery]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ScalarQuery]
AS
	SET NOCOUNT ON;
SELECT Get_SVDaThi.*
FROM     Get_SVDaThi
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckDaThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckDaThi] (
@MASV NCHAR(8),
@MAMH NCHAR(5),
@LAN INT)
AS
BEGIN
	IF EXISTS(SELECT MASV FROM dbo.BANGDIEM WHERE MAMH = @MAMH AND MASV = @MASV AND LAN = @LAN)
		RAISERROR ('MÔN NÀY ĐÃ THI!', 16, 1)
	ELSE
		RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_checkMaGV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_checkMaGV](@magv char(8))
as 
	if exists( select MAGV from GIAOVIEN where MAGV=@magv)
		raiserror ('Mã giáo viên đã tồn tại',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckMaKH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CheckMaKH]
	@MAKH CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @MAKH)
	BEGIN
		RAISERROR ('Mã khoa đã tồn tại!',16,1)
		RETURN
	END
   	IF EXISTS(SELECT MAKH FROM  LINK0.TN_CSDLPT.dbo.KHOA WHERE MAKH = @MAKH)
	BEGIN
		RAISERROR ('Mã khoa đã tồn tại!',16,1)
		RETURN
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckMaLop]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CheckMaLop]
	@MALOP CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @MALOP)
	BEGIN
		RAISERROR ('Mã lớp đã tồn tại!',16,1)
		RETURN
	END
   	IF EXISTS(SELECT MALOP FROM  LINK2.TN_CSDLPT.dbo.LOP WHERE MALOP = @MALOP)
	BEGIN
		RAISERROR ('Mã lớp đã tồn tại!',16,1)
		RETURN
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckMaMH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_CheckMaMH](
@MAMH char(5))
as

begin
	if exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH =@MAMH)
   		raiserror ('MÃ MÔN HỌC ĐÃ TỒN TẠI!',16,1)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckMaSV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckMaSV]
	@MASV CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MASV FROM  dbo.SINHVIEN WHERE MASV = @MASV)
   		BEGIN
			RAISERROR ('Mã sinh viên đã tồn tại!',16,1)
			RETURN 
		END 
	IF EXISTS(SELECT MASV FROM LINK2.TN_CSDLPT.dbo.SINHVIEN WHERE MASV = @MASV)
		BEGIN
			RAISERROR ('Mã sinh viên đã tồn tại!',16,1)
			RETURN 
		END
	RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckTenKH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CheckTenKH]
	@TENKH NVARCHAR(50)
AS
BEGIN
	IF EXISTS(SELECT TENKH FROM  dbo.KHOA WHERE TENKH = @TENKH)
	BEGIN
		RAISERROR ('Tên khoa đã tồn tại!',16,1)
		RETURN
	END
   	IF EXISTS(SELECT TENKH FROM  LINK0.TN_CSDLPT.dbo.KHOA WHERE TENKH = @TENKH)
	BEGIN
		RAISERROR ('Tên khoa đã tồn tại!',16,1)
		RETURN
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckTenLop]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CheckTenLop]
	@TENLOP NVARCHAR(50)
AS
BEGIN
	IF EXISTS(SELECT TENLOP FROM  dbo.LOP WHERE TENLOP = @TENLOP)
	BEGIN
		RAISERROR ('Tên lớp đã tồn tại!',16,1)
		RETURN
	END
   	IF EXISTS(SELECT TENLOP FROM  LINK0.TN_CSDLPT.dbo.LOP WHERE TENLOP = @TENLOP)
	BEGIN
		RAISERROR ('Tên lớp đã tồn tại!',16,1)
		RETURN
	END	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckTenMH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_CheckTenMH](
@TENMH nvarchar(50))
as

begin
	if exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TENMH)
   		raiserror ('TÊN MÔN HỌC ĐÃ TỒN TẠI!',16,1)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_ChuanBiThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChuanBiThi] (
@MAMH NCHAR(5),
@MALOP NCHAR(8),
@TRINHDO NCHAR(1), 
@SOCAUTHI INT,
@LAN INT,
@NGAYTHI VARCHAR(10))
AS
BEGIN
	DECLARE @TRINHDOTHAP CHAR(1), @SOCAUHOI INT, @SOCAUHOI_TDT INT
	IF EXISTS(SELECT * FROM DBO.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = @LAN)
	BEGIN
		RAISERROR('ĐÃ LẬP LỊCH THI CHO MÔN NÀY!', 16, 1)
		RETURN
	END
	IF(@LAN = 2)
	BEGIN
		IF NOT EXISTS(SELECT * FROM DBO.BANGDIEM 
		WHERE MAMH = @MAMH AND LAN = 1 AND MASV IN(SELECT MASV FROM SINHVIEN WHERE MALOP = @MALOP))
		BEGIN
			RAISERROR('LẦN 1 CHƯA THI, KHÔNG ĐƯỢC ĐĂNG KÝ LẦN 2!', 16, 1)
			RETURN
		END

		IF NOT EXISTS(SELECT * FROM DBO.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = 1 AND NGAYTHI < CONVERT(DATETIME, @NGAYTHI))
		BEGIN
			RAISERROR('NGÀY THI LẦN 2 PHẢI LỚN HƠN NGÀY THI CỦA LẦN 1!', 16, 1)
			RETURN
		END
	END
	
	
	IF @TRINHDO = 'A' SET @TRINHDOTHAP = 'B'
	IF @TRINHDO = 'B' SET @TRINHDOTHAP = 'C'
	
	SET @SOCAUHOI = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO) 

	IF @TRINHDO = 'C'
		IF @SOCAUTHI <= @SOCAUHOI RETURN
		ELSE 
		BEGIN
			RAISERROR (N'THIẾU CÂU HỎI! KHÔNG THỂ LẬP LỊCH THI',16,1)
			RETURN
		END		

	SET @SOCAUHOI_TDT = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDOTHAP)

	IF @TRINHDO = 'A' OR @TRINHDO = 'B'
	BEGIN
		IF	@SOCAUTHI <= @SOCAUHOI + @SOCAUHOI_TDT AND @SOCAUTHI*0.7 <= @SOCAUHOI RETURN
		BEGIN
			RAISERROR (N'THIẾU CÂU HỎI! THIẾU CÂU HỎI KHÔNG THỂ LẬP LỊCH THI',16,1)
			RETURN
		END	
	END
END	
GO
/****** Object:  StoredProcedure [dbo].[SP_ChuanBiThi1]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChuanBiThi1] (
@MAMH NCHAR(5),
@TRINHDO NCHAR(1), 
@SOCAUTHI INT)
AS
BEGIN
	DECLARE @TRINHDOTHAP CHAR(1), @SOCAUHOICS1 INT,@SOCAUHOICS2 INT,@SOCAUHOI_TDTCS1 INT,@SOCAUHOI_TDTCS2 INT
	
	IF @TRINHDO = 'A' SET @TRINHDOTHAP = 'B'
	IF @TRINHDO = 'B' SET @TRINHDOTHAP = 'C'
	
	SET @SOCAUHOICS1 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
	
	SET @SOCAUHOICS2 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDOTHAP AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))

	IF @TRINHDO = 'C'
	BEGIN
		IF @SOCAUTHI <= @SOCAUHOICS1 RETURN
		ELSE
			IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 RETURN
			ELSE 
			BEGIN
				RAISERROR (N'THIẾU CÂU HỎI',16,1)
				RETURN
			END		
	END

	SET @SOCAUHOI_TDTCS1 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))

	SET @SOCAUHOI_TDTCS2 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDOTHAP AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
	IF @TRINHDO = 'A' OR @TRINHDO = 'B'
	BEGIN
		IF @SOCAUTHI <= @SOCAUHOICS1 RETURN 
		ELSE
			IF @SOCAUHOICS1 >= @SOCAUTHI*0.7 
				IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 RETURN
				ELSE
					IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 RETURN
					ELSE
						IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS2 RETURN
						ELSE 
						BEGIN
							RAISERROR (N'THIẾU CÂU HỎI',16,1)
							RETURN
						END
			ELSE 
				IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 RETURN
				ELSE 
					IF @SOCAUTHI*0.7 <= @SOCAUHOICS1 + @SOCAUHOICS2 
						IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS1 RETURN
						ELSE 
							IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS2 RETURN
							ELSE 
							BEGIN
								RAISERROR (N'THIẾU CÂU HỎI',16,1)
								RETURN
							END
					ELSE 
					BEGIN
						RAISERROR (N'THIẾU CÂU HỎI',16,1)
						RETURN
					END					
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DoiMatKhauSV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DoiMatKhauSV](
@MASV CHAR(10),
@OLDPASSWORD VARCHAR(50),
@NEWPASSWORD VARCHAR(50)
)
AS
BEGIN
	
	IF NOT EXISTS(SELECT MASV FROM [DBO].[SINHVIEN] WHERE MASV = @MASV AND @OLDPASSWORD=MATKHAU)
	BEGIN
		RAISERROR('MẬT KHẨU CŨ KHÔNG CHÍNH XÁC!!!',16,1)
	END
	IF EXISTS(SELECT MASV FROM [DBO].[SINHVIEN] WHERE MASV = @MASV AND @OLDPASSWORD=MATKHAU AND @NEWPASSWORD=MATKHAU)
	BEGIN
		RAISERROR('MẬT KHẨU MỚI TRÙNG VỚI MẬT KHẨU HIỆN TẠI !!!',16,1)
	END
	UPDATE [DBO].[SINHVIEN] SET MATKHAU = @NEWPASSWORD WHERE MASV = @MASV AND @OLDPASSWORD=MATKHAU
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRole]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GetRole]
@MAGV NVARCHAR( 100)
AS
DECLARE @UID INT
SELECT @UID=UID  FROM SYS.SYSUSERS 
  WHERE NAME=@MAGV
  IF NOT EXISTS (SELECT NAME FROM SYS.SYSUSERS
     WHERE UID = (SELECT GROUPUID FROM SYS.SYSMEMBERS WHERE MEMBERUID=@UID))
	RETURN
ELSE
SELECT NAME
  FROM SYS.SYSUSERS
    WHERE UID = (SELECT GROUPUID FROM SYS.SYSMEMBERS WHERE MEMBERUID=@UID)
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertBaiThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC	[dbo].[SP_InsertBaiThi](
@IDBAITHI INT,
@CAUHOI INT,
@DACHON NCHAR(1)
)
AS
INSERT INTO BAITHI ( IDBAITHI, CAUHOI, DACHON) 
VALUES (@IDBAITHI,@CAUHOI,@DACHON)
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertTableBangDiem]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_InsertTableBangDiem](
@MASV CHAR(8),
@MAMH CHAR(5),
@LAN SMALLINT,
@DIEM FLOAT)
AS
INSERT INTO BANGDIEM ( MASV, MAMH , LAN , NGAYTHI , DIEM  ) 
VALUES  ( @MASV,@MAMH,@LAN,GETDATE(),@DIEM)
GO
/****** Object:  StoredProcedure [dbo].[SP_LayIDBaiThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LayIDBaiThi](
@MASV CHAR(8),
@MAMH CHAR(5),
@LAN SMALLINT
)
AS
SELECT BAITHI FROM [dbo].[BANGDIEM] WHERE MASV=@MASV AND LAN=@LAN AND MAMH=@MAMH

GO
/****** Object:  StoredProcedure [dbo].[SP_LayThongTinGiaoVien]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LayThongTinGiaoVien]
@TENLOGIN NVARCHAR( 100)
AS
DECLARE @UID INT
DECLARE @MANV NVARCHAR(100)
SELECT @UID= UID , @MANV= NAME FROM SYS.SYSUSERS 
  WHERE SID = SUSER_SID(@TENLOGIN)
IF NOT EXISTS(SELECT MAGV FROM DBO.GIAOVIEN WHERE MAGV=@MANV )
	BEGIN
			RAISERROR ('GIẢNG VIÊN KHÔNG TỒN TẠI !!',16,1)
			RETURN 
	END
SELECT MAGV= @MANV, 
       HOTEN = (SELECT HO+ ' '+TEN FROM DBO.GIAOVIEN WHERE MAGV=@MANV ), 
       TENNHOM=NAME
  FROM SYS.SYSUSERS
    WHERE UID = (SELECT GROUPUID FROM SYS.SYSMEMBERS WHERE MEMBERUID=@UID)
GO
/****** Object:  StoredProcedure [dbo].[SP_LayThongTinSinhVien]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_LayThongTinSinhVien] @login_name nvarchar(20), @password nvarchar(50)
as
begin
	if exists(select masv from sinhvien where masv=@login_name AND MATKHAU=@password)
				select masv, hoten=ho+' '+ten, GROUPNAME='SinhVien' , NGAYSINH, DIACHI, MALOP from sinhvien where masv=@login_name
			else
				RAISERROR (N'Mã sinh viên hoặc mật khẩu không chính xác', 16, 1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_TaoTaiKhoan]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TaoTaiKhoan] @LGNAME VARCHAR(50),
	@PASS VARCHAR(50),
	@USERNAME VARCHAR(50),
	@ROLE VARCHAR(50)
AS
BEGIN
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS,'TN_CSDLPT'                     

  IF (@RET =1)  
     BEGIN
		RAISERROR('TÊN LOGIN ĐÃ TỒN TẠI!! ',16,1)
	 END


  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME
  IF (@RET =1)  
  BEGIN
       EXEC SP_DROPLOGIN @LGNAME
       RAISERROR('TÊN USER ĐÃ TỒN TẠI!! ',16,1)
  END

  EXEC sp_addrolemember @ROLE, @USERNAME
  IF @ROLE='TRUONG' OR @ROLE='COSO' EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
  RETURN 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Thi1]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Thi1] (@MAMH CHAR(5), @TRINHDO CHAR(1), @SOCAUTHI SMALLINT)
AS
BEGIN
	DECLARE @TRINHDO_THAP NCHAR(1), @DEM1 INT, @DEM2 INT, @DEM3 INT, @DEM4 INT, @ErorStr nvarchar(200)

	CREATE TABLE #TAM (
		CAUHOI INT,
		MAMH CHAR(5),
		TRINHDO CHAR(1),
		NOIDUNG NVARCHAR(500),
		A NVARCHAR(100),
		B NVARCHAR(100),
		C NVARCHAR(100),
		D NVARCHAR(100),
		DAP_AN CHAR(1),
		MAGV CHAR(8)
	);

	IF @TRINHDO = 'A'
	BEGIN
		SET @TRINHDO_THAP = 'B'
	END
	IF @TRINHDO = 'B'
	BEGIN
		SET @TRINHDO_THAP = 'C'
	END

	IF @TRINHDO = 'A' OR @TRINHDO = 'B' --  VI DUOI TRINH DO C KHONG CO TRINH DO NAO NUA NEN XET TRUONG HOP RIENG
	BEGIN
		SET @DEM1 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
		IF @DEM1 >= @SOCAUTHI -- DU CAU THI
		BEGIN
			--RAISERROR('YES', 16, 1)
			--DEM1 >= 100%
			INSERT INTO #TAM SELECT TOP (@SOCAUTHI) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM BODE  WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
		END
		ELSE IF @DEM1 >= FLOOR(@SOCAUTHI*0.7) -- BEN CS1 %CAU TDA >= 70%, LAY THEM CAU TDB
		BEGIN
			--LAY HET DEM1 ( 100% > DEM1 >= 70% )
			INSERT INTO #TAM SELECT TOP (@DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
			
			SET @DEM2 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO_THAP AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
			IF @DEM2 >= (@SOCAUTHI - @DEM1) -- DU CAU THI
			BEGIN
				--RAISERROR('YES', 16, 1)
				--DA CO DEM1, DEM1+DEM2 >= 100%, LAY VUA DU DEM2
				INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
			END
			ELSE -- QUA BEN CS2 LAY THEM CAU TDA
			BEGIN
				--DA CO DEM1, LAY HET DEM2
				INSERT INTO #TAM SELECT TOP (@DEM2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				 
				SET @DEM3 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
				IF @DEM3 >= (@SOCAUTHI - @DEM1 - @DEM2) -- DU CAU THI
				BEGIN
					--RAISERROR('YES', 16, 1)
					--DA CO DEM1, DEM2, LAY VUA DU DEM3
					INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1 - @DEM2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				END
				ELSE -- SO CAU TDA BEN CS2 CHUA DU LAY THEM CAU TDB
				BEGIN
					--DA CO DEM1, DEM2, LAY HET DEM3
					INSERT INTO #TAM SELECT TOP (@DEM3) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

					SET @DEM4 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO_THAP AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
					IF @DEM4 >= (@SOCAUTHI - @DEM1 - @DEM2 - @DEM3) -- DU CAU THI
					BEGIN
						--RAISERROR('YES', 16, 1)
						--DA CO DEM1, DEM2, DEM3, LAY VUA DU DEM4
						INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1 - @DEM2 - @DEM3) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
					END
					ELSE -- KHONG DU CAU THI, BAO LOI
					BEGIN
						SET @ErorStr = N'Thiếu câu hỏi thi! Thiếu "'+ rtrim(convert(nvarchar(200),@SoCauThi - (@DEM1 + @DEM2 + @DEM3 + @DEM4))) +N'" câu hỏi, cần thêm câu hỏi vào trình độ hiện tại (hoặc thấp hơn 1 bậc)!' 
						RAISERROR(@ErorStr, 16, 1)
						RETURN
					END
				END
			END
		END
		ELSE -- BEN CS1 %CAU TDA < 70%, LAY THEM CAU TDA BEN CS2
		BEGIN
			--LAY HET DEM1
			INSERT INTO #TAM SELECT TOP (@DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

			SET @DEM2 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
			IF @DEM2 >= (@SOCAUTHI - @DEM1) -- DU CAU THI
			BEGIN
				--RAISERROR('YES', 16, 1)
				--DA CO DEM1, LAY VUA DU DEM2
				INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
			END
			ELSE IF @DEM2 >= (FLOOR(@SOCAUTHI*0.7) - @DEM1) -- %CAU TDA (CS1 + CS2) >= 70%, LAY CAU TDB BEN CS1 THEM
			BEGIN
				--DA CO DEM1, LAY HET DEM2
				INSERT INTO #TAM SELECT TOP (@DEM2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

				SET @DEM3 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO_THAP AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
				IF @DEM3 >= (@SOCAUTHI - @DEM1 - @DEM2) -- DU CAU THI
				BEGIN
					--RAISERROR('YES', 16, 1)
					--DA CO DEM1, DEM2, LAY VUA DU DEM3
					INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1 - @DEM2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				END
				ELSE -- CAU TDB BEN CS1 CHUA DU, LAY THEM CAU TDB BEN CS2
				BEGIN
					--DA CO DEM1, DEM2, LAY HET DEM3
					INSERT INTO #TAM SELECT TOP (@DEM3) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

					SET @DEM4 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO_THAP AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
					IF @DEM4 >= (@SOCAUTHI - @DEM1 - @DEM2 - @DEM3) -- DU CAU THI
					BEGIN
						--RAISERROR('YES', 16, 1)
						--DA CO DEM1, DEM2, DEM3, LAY VUA DU DEM4
						INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1 - @DEM2 - @DEM3) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE WHERE TRINHDO = @TRINHDO_THAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
					END
					ELSE -- KHONG DU CAU THI, BAO LOI
					BEGIN
						SET @ErorStr = N'Thiếu câu hỏi thi! Thiếu "'+ rtrim(convert(nvarchar(200),@SoCauThi - (@DEM1 + @DEM2 + @DEM3 + @DEM4))) +N'" câu hỏi, cần thêm câu hỏi vào trình độ hiện tại (hoặc thấp hơn 1 bậc)!' 
						RAISERROR(@ErorStr, 16, 1)
						RETURN
					END
				END
			END
			ELSE -- %CAU TDA (CS1 + CS2) < 70% => KHONG DU CAU THI, BAO LOI
			BEGIN
				SET @ErorStr = N'Thiếu câu hỏi thi! Thiếu "'+ rtrim(convert(nvarchar(200),FLOOR(@SoCauThi*0.7) - (@DEM1 + @DEM2))) +N'" câu hỏi cùng trình độ để đủ chỉ tiêu ít nhất 70 phần trăm câu hỏi cùng trình độ!' 
				RAISERROR(@ErorStr, 16, 1)
				RETURN
			END
		END
	END
	ELSE -- TRINH DO C
	BEGIN
		SET @DEM1 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
		IF @DEM1 >= @SOCAUTHI -- DU CAU THI
		BEGIN
			--RAISERROR('YES', 16, 1)
			--LAY VUA DU DEM1
			INSERT INTO #TAM SELECT TOP (@SOCAUTHI) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID() 
		END
		ELSE  -- BEN CS1 CHUA DU CAU THI
		BEGIN
			--LAY HET DEM1
			INSERT INTO #TAM SELECT TOP (@DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID() 

			SET @DEM2 = (SELECT COUNT(*) FROM dbo.BODE WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
			IF @DEM2 >= @SOCAUTHI - @DEM1 -- BEN CS2 + CS1 DU CAU THI
			BEGIN
				--RAISERROR('YES', 16, 1)
				--DA CO DEM1, LAY VUA DU DEM2
				INSERT INTO #TAM SELECT TOP (@SOCAUTHI - @DEM1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID() 
			END
			ELSE -- KHONG DU CAU THI, BAO LOI
			BEGIN
				SET @ErorStr = N'Thiếu câu hỏi thi! Thiếu "'+ rtrim(convert(nvarchar(200),@SoCauThi - (@DEM1 + @DEM2))) +N'" câu hỏi cùng trình độ !' 
				RAISERROR(@ErorStr, 16, 1)
				RETURN
			END
		END
	END

	SELECT * FROM #TAM ORDER BY NEWID() 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ThiTracNghiem]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ThiTracNghiem] (
@MAMH NCHAR(5),
@TRINHDO NCHAR(1), 
@SOCAUTHI INT)
AS
BEGIN
	DECLARE @TRINHDOTHAP CHAR(1), @SOCAUHOICS1 INT,@SOCAUHOICS2 INT,@SOCAUHOI_TDTCS1 INT,@SOCAUHOI_TDTCS2 INT
	
	CREATE TABLE #BODETHI (
		CAUHOI INT,
		MAMH CHAR(5),
		TRINHDO CHAR(1),
		NOIDUNG NVARCHAR(500),
		A NVARCHAR(100),
		B NVARCHAR(100),
		C NVARCHAR(100),
		D NVARCHAR(100),
		DAP_AN CHAR(1),
		MAGV CHAR(8)
	)

	IF @TRINHDO = 'A' SET @TRINHDOTHAP = 'B'
	IF @TRINHDO = 'B' SET @TRINHDOTHAP = 'C'
	
	SET @SOCAUHOICS1 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))
	SET @SOCAUHOICS2 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDO AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))
	
	
	IF @TRINHDO = 'C'
	BEGIN
		IF @SOCAUTHI <= @SOCAUHOICS1 
		BEGIN
			INSERT INTO #BODETHI 
			SELECT TOP (@SOCAUTHI) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  
			WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
		END
		ELSE
			IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 
			BEGIN
				INSERT INTO #BODETHI SELECT TOP (@SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  
				WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				
				INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE  
				WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()  
			END
			ELSE 
			BEGIN
				RAISERROR (N'THIẾU CÂU HỎI',16,1)
				RETURN
			END		
	END

	
	SET @SOCAUHOI_TDTCS1 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDOTHAP AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM dbo.KHOA)))

	SET @SOCAUHOI_TDTCS2 = (SELECT COUNT(*) FROM dbo.BODE 
		WHERE MAMH = @MAMH AND TRINHDO = @TRINHDOTHAP AND 
		MAGV IN (SELECT MAGV FROM dbo.GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM dbo.KHOA)))

	IF @TRINHDO = 'A' OR @TRINHDO = 'B'
	BEGIN
		IF @SOCAUTHI <= @SOCAUHOICS1 
		BEGIN
			INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM BODE  
			WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
		END
		ELSE
			IF @SOCAUHOICS1 >= @SOCAUTHI*0.7 
			BEGIN
				INSERT INTO #BODETHI SELECT TOP (@SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
				WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				
				IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 	
				BEGIN
					INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
					WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				END
				ELSE
				BEGIN
					INSERT INTO #BODETHI SELECT TOP (@SOCAUHOI_TDTCS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
					WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				 
					IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 
					BEGIN
						INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1 - @SOCAUHOI_TDTCS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
						WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
					END
					ELSE
					BEGIN
						INSERT INTO #BODETHI SELECT TOP (@SOCAUHOICS2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
						WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
						
						IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS2 
						BEGIN
							INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1 - @SOCAUHOI_TDTCS1 - @SOCAUHOICS2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
							WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
						END
						ELSE 
						BEGIN
							RAISERROR (N'THIẾU CÂU HỎI',16,1)
							RETURN
						END
					END
				END
			END
			ELSE 
			BEGIN
				INSERT INTO #BODETHI SELECT TOP (@SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
				WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

				IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 
				BEGIN
					INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
					WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
				END
				ELSE 
					IF @SOCAUTHI*0.7 <= @SOCAUHOICS1 + @SOCAUHOICS2 
					BEGIN
						INSERT INTO #BODETHI SELECT TOP (@SOCAUHOICS2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
						WHERE TRINHDO = @TRINHDO AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()

						IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS1 
						BEGIN
							INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1 - @SOCAUHOICS2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
							WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
						END
						ELSE
						BEGIN
							INSERT INTO #BODETHI SELECT TOP (@SOCAUHOI_TDTCS1) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
							WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
 
							IF @SOCAUTHI <= @SOCAUHOICS1 + @SOCAUHOI_TDTCS1 + @SOCAUHOICS2 + @SOCAUHOI_TDTCS2 
							BEGIN
								INSERT INTO #BODETHI SELECT TOP (@SOCAUTHI - @SOCAUHOICS1 - @SOCAUHOI_TDTCS1 - @SOCAUHOICS2) CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV FROM dbo.BODE 
								WHERE TRINHDO = @TRINHDOTHAP AND MAMH = @MAMH AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA)) ORDER BY NEWID()
							END
							ELSE 
							BEGIN
								RAISERROR (N'THIẾU CÂU HỎI',16,1)
								RETURN
							END
						END
					END
					ELSE 
					BEGIN
						RAISERROR (N'THIẾU CÂU HỎI',16,1)
						RETURN
					END
				
			END					
	END
	SELECT * FROM #BODETHI ORDER BY NEWID() 
END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaBD]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoSuaBD]
(	@CH int, 
	@MAMH char(5),
	@TRINHDO char(1), 
	@NOIDUNG ntext,
	@A ntext,
	@B ntext,
	@C ntext,
	@D ntext,
	@DAPAN char(1))
	
AS

BEGIN
	UPDATE [dbo].[BODE] SET MAMH = @MAMH, TRINHDO = @TRINHDO,  DAP_AN = @DAPAN,NOIDUNG=@NOIDUNG,A=@A,B=@B,C=@C,D=@D
	WHERE CAUHOI = @CH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaGV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_UndoSuaGV]
(	@MAGV CHAR(8), 
	@HO NVARCHAR(50),
	@TEN NVARCHAR(10), 
	@DIACHI NVARCHAR(500))
AS

BEGIN
	UPDATE [dbo].[GIAOVIEN] SET HO = @HO, TEN = @TEN,  DIACHI = @DIACHI
	WHERE MAGV = @MAGV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaKH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoSuaKH](
@MAKH NCHAR(8), 
@TENKH NVARCHAR(50))
AS

BEGIN
	IF NOT EXISTS(SELECT MAKH FROM  DBO.KHOA WHERE MAKH = @MAKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! MÃ KHOA MỚI ĐÃ SỬA KHÔNG TỒN TẠI',16,1)
			RETURN
		END	

	IF EXISTS(SELECT TENKH FROM  DBO.KHOA WHERE TENKH = @TENKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! TÊN KHOA CŨ ĐÃ SỬA ĐANG TỒN TẠI',16,1)
			RETURN
		END		
	IF EXISTS(SELECT TENKH FROM  LINK0.TN_CSDLPT.DBO.KHOA WHERE TENKH = @TENKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! TÊN KHOA CŨ ĐÃ SỬA ĐANG TỒN TẠI',16,1)
			RETURN
		END	
UPDATE [DBO].[KHOA] SET TENKH = @TENKH WHERE MAKH = @MAKH
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaLop]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoSuaLop](
@MALOP CHAR(8), 
@TENLOP NVARCHAR(50))
AS

BEGIN
	IF NOT EXISTS(SELECT MALOP FROM  DBO.LOP WHERE MALOP = @MALOP)
		BEGIN
			RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! MÃ LỚP MỚI ĐÃ SỬA KHÔNG TỒN TẠI',16,1)
			RETURN
		END	
	IF EXISTS(SELECT TENLOP FROM  DBO.LOP WHERE TENLOP = @TENLOP)
			BEGIN
				RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! TÊN LỚP CŨ ĐÃ SỬA ĐANG TỒN TẠI',16,1)
				RETURN
			END	
	
	IF EXISTS(SELECT TENLOP FROM  LINK2.TN_CSDLPT.DBO.LOP WHERE TENLOP = @TENLOP)
			BEGIN
				RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! TÊN LỚP CŨ ĐÃ SỬA ĐANG TỒN TẠI',16,1)
				RETURN
			END	
	
	UPDATE [DBO].[LOP] SET TENLOP = @TENLOP WHERE MALOP = @MALOP
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaMH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoSuaMH](
@MAMH CHAR(5), 
@TENMH NVARCHAR(50))
AS

BEGIN

	IF NOT EXISTS(SELECT MAMH FROM  DBO.MONHOC WHERE MAMH = @MAMH)
		BEGIN
			RAISERROR (N'PHỤC HỒI SỬA THẤT BẠI! MÃ MÔN HỌC MỚI ĐÃ SỬA LÚC TRƯỚC KHÔNG TỒN TẠI"',16,1)
			RETURN
		END	
	
	UPDATE [DBO].[MONHOC] SET TENMH = @TENMH WHERE MAMH = @MAMH
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoSuaSV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoSuaSV]
(	@MASV CHAR(8), 
	@HO NVARCHAR(50),
	@TEN NVARCHAR(10), 
	@NGAYSINH CHAR(121), 
	@DIACHI NVARCHAR(500), 
	@MALOP CHAR(8))
AS

BEGIN
	UPDATE [DBO].[SINHVIEN] SET HO = @HO, TEN = @TEN, NGAYSINH = convert(datetime, @NGAYSINH, 103), DIACHI = @DIACHI, MALOP = @MALOP
	WHERE MASV = @MASV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemBD]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoThemBD](
@MABD CHAR(8))
AS

BEGIN

	IF EXISTS(SELECT CAUHOI FROM  BODE WHERE CAUHOI = @MABD)		
   			DELETE  DBO.BODE WHERE CAUHOI = @MABD
	ELSE
		BEGIN
			RAISERROR (N'Phục hồi thất bại, câu hỏi không tồn tại',16,1)
		END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemGV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_UndoThemGV](
@MAGV CHAR(8))
AS

BEGIN

	IF EXISTS(SELECT MAGV FROM  DBO.GIAOVIEN WHERE MAGV = @MAGV)		
   			DELETE  DBO.GIAOVIEN WHERE MAGV = @MAGV
	ELSE
		BEGIN
			RAISERROR (N'Phục hồi thất bại, Giáo viên không tồn tại',16,1)
		END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemKH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoThemKH](
@MAKH NCHAR(8))
AS

BEGIN
	

	IF NOT EXISTS(SELECT MAKH FROM  DBO.KHOA WHERE MAKH = @MAKH)
		RAISERROR (N'PHỤC HỒI THÊM THẤT BẠI! MÃ KHOA ĐÃ THÊM KHÔNG TỒN TẠI',16,1)				
	ELSE
		DELETE  DBO.KHOA WHERE MAKH = @MAKH
			
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemLop]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoThemLop](
@MALOP CHAR(8))
AS

BEGIN
	IF NOT EXISTS(SELECT MALOP FROM  DBO.LOP WHERE MALOP = @MALOP)		
   			RAISERROR (N'PHỤC HỒI THÊM THẤT BẠI! MÃ LỚP ĐÃ THÊM KHÔNG TỒN TẠI',16,1)
	ELSE
		DELETE  DBO.LOP WHERE MALOP = @MALOP
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemMH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoThemMH](
@MAMH CHAR(5))
AS

BEGIN
	IF EXISTS(SELECT MAMH FROM  DBO.MONHOC WHERE MAMH = @MAMH)		
   			DELETE  DBO.MONHOC WHERE MAMH = @MAMH
	ELSE
		BEGIN
			RAISERROR (N'PHỤC HỒI THÊM THẤT BẠI! MÃ MÔN HỌC ĐÃ THÊM KHÔNG TỒN TẠI',16,1)
			RETURN
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoThemSV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoThemSV](
@MASV CHAR(8))
AS

BEGIN

	IF EXISTS(SELECT MASV FROM  DBO.SINHVIEN WHERE MASV = @MASV)		
   			DELETE  DBO.SINHVIEN WHERE MASV = @MASV
	ELSE
		BEGIN
			RAISERROR (N'Phục hồi thất bại, Sinh viên không tồn tại',16,1)
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaBD]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoXoaBD]
(	@CH int, 
	@MAMH char(5),
	@TRINHDO char(1), 
	@NOIDUNG ntext,
	@A ntext,
	@B ntext,
	@C ntext,
	@D ntext,
	@DAPAN char(1),
	@MAGV char(8))
AS

BEGIN	
	IF NOT EXISTS (SELECT CAUHOI FROM  BODE WHERE CAUHOI = @CH)
	BEGIN
		INSERT INTO [dbo].[BODE] (CAUHOI,MAMH,TRINHDO,NOIDUNG,A,B,C,D,DAP_AN,MAGV) 
		VALUES (@CH ,@MAMH ,@TRINHDO  ,@NOIDUNG,@A,@B,@C,@D,@DAPAN,@MAGV)
	END
	ELSE BEGIN
			RAISERROR (N'Phục hồi thất bại, câu hỏi đã tồn tại',16,1)
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaGV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UndoXoaGV]
(@MAGV CHAR(8), 
@HO NVARCHAR(50), 
@TEN NVARCHAR(10), 
@DIACHI NVARCHAR(500),
@MAKHOA CHAR(8)
) 
AS

BEGIN	
	INSERT INTO [DBO].[GIAOVIEN] (MAGV,HO,TEN,DIACHI,MAKH ) 
	VALUES (@MAGV ,@HO ,@TEN  ,@DIACHI,@MAKHOA )
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaKH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoXoaKH](
@MAKH NCHAR(8), 
@TENKH NVARCHAR(50), 
@MACS NCHAR(3))
AS

BEGIN


	IF EXISTS(SELECT MAKH FROM  DBO.KHOA WHERE MAKH = @MAKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! MÃ KHOA ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END	
	IF EXISTS(SELECT MAKH FROM  LINK0.TN_CSDLPT.DBO.KHOA WHERE MAKH = @MAKH)
		BEGIN 
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! MÃ KHOA ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END	
   	IF EXISTS(SELECT TENKH FROM  DBO.KHOA WHERE TENKH = @TENKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! TÊN KHOA ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END		
   	IF EXISTS(SELECT TENKH FROM  LINK0.TN_CSDLPT.DBO.KHOA WHERE TENKH = @TENKH)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! TÊN KHOA ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END	

	INSERT INTO [DBO].[KHOA] ( MAKH, TENKH, MACS ) 
		VALUES (@MAKH, @TENKH, @MACS)
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaLop]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoXoaLop](
@MALOP CHAR(8),
@TENLOP NVARCHAR(50), 
@MAKH NCHAR(8))
AS

BEGIN
	IF EXISTS(SELECT MALOP FROM  DBO.LOP WHERE MALOP = @MALOP)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! MÃ LỚP ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END	
	IF EXISTS(SELECT MALOP FROM  LINK0.TN_CSDLPT.DBO.LOP WHERE MALOP = @MALOP)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! MÃ LỚP ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END		
   	IF EXISTS(SELECT TENLOP FROM  DBO.LOP WHERE TENLOP = @TENLOP)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! TÊN LỚP ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END
	IF EXISTS(SELECT TENLOP FROM  LINK2.TN_CSDLPT.DBO.LOP WHERE TENLOP = @TENLOP)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! TÊN LỚP ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END		
	INSERT INTO [DBO].LOP ( MALOP, TENLOP, MAKH ) 
			VALUES (@MALOP, @TENLOP, @MAKH)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaMH]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoXoaMH](
@MAMH CHAR(5), 
@TENMH NVARCHAR(50))
AS

BEGIN

	IF EXISTS(SELECT MAMH FROM  DBO.MONHOC WHERE MAMH = @MAMH)
		BEGIN
			RAISERROR (N'PHỤC HỒI XOÁ THẤT BẠI! MÃ MÔN HỌC ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END		
   	IF EXISTS(SELECT TENMH FROM  DBO.MONHOC WHERE TENMH = @TENMH)
		BEGIN
			RAISERROR ( N'PHỤC HỒI XOÁ THẤT BẠI! TÊN MÔN HỌC ĐÃ XOÁ ĐANG TỒN TẠI',16,1)
			RETURN
		END		
	
	INSERT INTO [DBO].[MONHOC] ( MAMH, TENMH ) 
		VALUES (@MAMH, @TENMH)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UndoXoaSV]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UndoXoaSV]
(@MASV CHAR(8), 
@HO NVARCHAR(50), 
@TEN NVARCHAR(10), 
@NGAYSINH CHAR(121), 
@DIACHI NVARCHAR(500), 
@MALOP CHAR(8))
AS

BEGIN	
	INSERT INTO [DBO].[SINHVIEN] (MASV,HO,TEN,NGAYSINH,DIACHI,MALOP) 
	VALUES (@MASV ,@HO ,@TEN ,convert(datetime, @NGAYSINH, 103) ,@DIACHI,@MALOP)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_XemBangDiem]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XemBangDiem]
	@MALOP NCHAR(8),
	@MAMH NCHAR(5),
	@LAN SMALLINT
	
AS
BEGIN
	SELECT SINHVIEN.MASV, HO, TEN, DIEM,[dbo].[FN_DiemChu](DIEM)As 'DIEM CHU'
	FROM dbo.SINHVIEN JOIN dbo.BANGDIEM
	ON BANGDIEM.MASV = SINHVIEN.MASV
	WHERE BANGDIEM.MAMH = @MAMH AND BANGDIEM.LAN = @LAN AND SINHVIEN.MALOP = @MALOP
END
GO
/****** Object:  StoredProcedure [dbo].[SP_XemDSDKThi]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XemDSDKThi]
@fromDate datetime,
@toDate datetime
AS

	SELECT DISTINCT  LOP.TENLOP, MONHOC.TENMH, CONCAT(GIAOVIEN.HO,' ',GIAOVIEN.TEN) AS HOTEN, GVDK.SOCAUTHI, CONVERT(DATE, GVDK.NGAYTHI) AS NGAYTHI,[dbo].[FN_CheckDaThi](GVDK.MAMH, GVDK.MALOP, GVDK.LAN) AS DATHI  FROM GIAOVIEN_DANGKY GVDK 
	inner join LOP ON ( (GVDK.NGAYTHI BETWEEN @fromDate AND @toDate) AND lOP.MALOP = GVDK.MALOP)
	inner join MONHOC ON (GVDK.MAMH = MONHOC.MAMH)
	inner join GIAOVIEN ON (GVDK.MAGV = GIAOVIEN.MAGV)

	ORDER BY NGAYTHI ASC

GO
/****** Object:  StoredProcedure [dbo].[SP_XemKetQua]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XemKetQua]
	@MASV NCHAR(8),
	@MAMH NCHAR(5),
	@LAN SMALLINT
AS
BEGIN
	SELECT  BAITHI.CAUHOI,BODE.NOIDUNG,BODE.A,BODE.B,BODE.C,BODE.D,BODE.DAP_AN,BAITHI.DACHON FROM BODE,BAITHI
WHERE BODE.MAMH=@MAMH AND BAITHI.CAUHOI=BODE.CAUHOI AND BAITHI.IDBAITHI IN (SELECT BANGDIEM.BAITHI FROM BANGDIEM WHERE MASV=@MASV AND LAN=@LAN)
ORDER by BAITHI.rowguid  

END	
GO
/****** Object:  StoredProcedure [dbo].[SP_XoaTaiKhoan]    Script Date: 31/05/2022 12:58:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_XoaTaiKhoan]
  @LGNAME VARCHAR(50),
  @USRNAME VARCHAR(50)
  
AS
  EXEC SP_DROPUSER @USRNAME
  EXEC SP_DROPLOGIN @LGNAME

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "sysusers (sys)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GV"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Get_Roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Get_Roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GIAOVIEN"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Get_TaoTK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Get_TaoTK'
GO
