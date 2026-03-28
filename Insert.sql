-----------------INSERT DỮ LIỆU---------------------------
-- ==========================================
-- 1. ThamSoQuyDinh
-- ==========================================
INSERT INTO ThamSoQuyDinh (SoSachMuonToiDa, SoNgayMuonToiDa, PhiPhatTreHan)
VALUES 
(3, 10, 5000);

-- ==========================================
-- 2. NguoiDung
-- ==========================================
DECLARE @User1 UNIQUEIDENTIFIER = NEWID()
DECLARE @User2 UNIQUEIDENTIFIER = NEWID()
DECLARE @User3 UNIQUEIDENTIFIER = NEWID()
DECLARE @User4 UNIQUEIDENTIFIER = NEWID()
DECLARE @User5 UNIQUEIDENTIFIER = NEWID()
DECLARE @User6 UNIQUEIDENTIFIER = NEWID()
DECLARE @User7 UNIQUEIDENTIFIER = NEWID()
DECLARE @User8 UNIQUEIDENTIFIER = NEWID()
DECLARE @User9 UNIQUEIDENTIFIER = NEWID()
DECLARE @User10 UNIQUEIDENTIFIER = NEWID()

INSERT INTO NguoiDung (Id, HoTen, Email, MatKhau, VaiTro)
VALUES
(@User1, N'Nguyễn Văn An', 'a@gmail.com', '123', 1),
(@User2, N'Trần Thị Bình', 'b@gmail.com', '123', 2),
(@User3, N'Lê Văn Cường', 'c@gmail.com', '123', 3),
(@User4, N'Phạm Văn Duy', 'd@gmail.com', '123', 3),
(@User5, N'Hoàng Thị Em', 'e@gmail.com', '123', 3),
(@User6, N'Nguyễn Văn Phương', 'f@gmail.com', '123', 2),
(@User7, N'Trần Văn Giang', 'g@gmail.com', '123', 3),
(@User8, N'Lê Thị Hồng', 'h@gmail.com', '123', 3),
(@User9, N'Phạm Văn Vượng', 'i@gmail.com', '123', 3),
(@User10, N'Hoàng Văn Khuyên', 'k@gmail.com', '123', 3);

-- ==========================================
-- 3. DanhMucSach
-- ==========================================
DECLARE @DM1 UNIQUEIDENTIFIER = NEWID()
DECLARE @DM2 UNIQUEIDENTIFIER = NEWID()
DECLARE @DM3 UNIQUEIDENTIFIER = NEWID()
DECLARE @DM4 UNIQUEIDENTIFIER = NEWID()
DECLARE @DM5 UNIQUEIDENTIFIER = NEWID()

INSERT INTO DanhMucSach (Id, TenDanhMuc)
VALUES
(@DM1, N'Công nghệ'),
(@DM2, N'Khoa học'),
(@DM3, N'Tiểu thuyết'),
(@DM4, N'Kinh tế'),
(@DM5, N'Tâm lý');

-- ==========================================
-- 4. TacGia
-- ==========================================
DECLARE @TG1 UNIQUEIDENTIFIER = NEWID()
DECLARE @TG2 UNIQUEIDENTIFIER = NEWID()
DECLARE @TG3 UNIQUEIDENTIFIER = NEWID()
DECLARE @TG4 UNIQUEIDENTIFIER = NEWID()
DECLARE @TG5 UNIQUEIDENTIFIER = NEWID()

INSERT INTO TacGia (Id, TenTacGia)
VALUES
(@TG1, N'Nguyễn Nhật Ánh'),
(@TG2, N'Paulo Coelho'),
(@TG3, N'J.K. Rowling'),
(@TG4, N'Stephen King'),
(@TG5, N'Dale Carnegie');

-- ==========================================
-- 5. NhaXuatBan
-- ==========================================
DECLARE @NXB1 UNIQUEIDENTIFIER = NEWID()
DECLARE @NXB2 UNIQUEIDENTIFIER = NEWID()
DECLARE @NXB3 UNIQUEIDENTIFIER = NEWID()

INSERT INTO NhaXuatBan (Id, TenNXB)
VALUES
(@NXB1, N'NXB Trẻ'),
(@NXB2, N'NXB Kim Đồng'),
(@NXB3, N'NXB Lao Động');

-- ==========================================
-- 6. DauSach
-- ==========================================
DECLARE @DS1 UNIQUEIDENTIFIER = NEWID()
DECLARE @DS2 UNIQUEIDENTIFIER = NEWID()
DECLARE @DS3 UNIQUEIDENTIFIER = NEWID()
DECLARE @DS4 UNIQUEIDENTIFIER = NEWID()
DECLARE @DS5 UNIQUEIDENTIFIER = NEWID()

INSERT INTO DauSach (Id, TenSach, DanhMucId, TacGiaId, NxbId, NamXuatBan)
VALUES
(@DS1, N'Đắc nhân tâm', @DM5, @TG5, @NXB1, 2010),
(@DS2, N'Harry Potter', @DM3, @TG3, @NXB2, 2005),
(@DS3, N'Nhà giả kim', @DM3, @TG2, @NXB1, 2008),
(@DS4, N'Tôi thấy hoa vàng', @DM3, @TG1, @NXB2, 2012),
(@DS5, N'Lập trình C#', @DM1, @TG4, @NXB3, 2020);

-- ==========================================
-- 7. CuonSach
-- ==========================================
DECLARE @CS1 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS2 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS3 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS4 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS5 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS6 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS7 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS8 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS9 UNIQUEIDENTIFIER = NEWID()
DECLARE @CS10 UNIQUEIDENTIFIER = NEWID()

INSERT INTO CuonSach (Id, DauSachId, MaVach, TinhTrangVatLy)
VALUES
(@CS1, @DS1, 'CS001', N'Mới'),
(@CS2, @DS1, 'CS002', N'Cũ'),
(@CS3, @DS2, 'CS003', N'Mới'),
(@CS4, @DS2, 'CS004', N'Mới'),
(@CS5, @DS3, 'CS005', N'Cũ'),
(@CS6, @DS3, 'CS006', N'Mới'),
(@CS7, @DS4, 'CS007', N'Mới'),
(@CS8, @DS4, 'CS008', N'Cũ'),
(@CS9, @DS5, 'CS009', N'Mới'),
(@CS10, @DS5, 'CS010', N'Mới');

-- ==========================================
-- 8. YeuCauMuon
-- ==========================================
DECLARE @YC1 UNIQUEIDENTIFIER = NEWID()
DECLARE @YC2 UNIQUEIDENTIFIER = NEWID()

INSERT INTO YeuCauMuon (Id, DocGiaId, NgayHenNhan)
VALUES
(@YC1, @User3, GETDATE()),
(@YC2, @User4, GETDATE());

-- ==========================================
-- 9. ChiTietYeuCau
-- ==========================================
INSERT INTO ChiTietYeuCau (YeuCauId, DauSachId)
VALUES
(@YC1, @DS1),
(@YC1, @DS2),
(@YC2, @DS3),
(@YC2, @DS4);

-- ==========================================
-- 10. PhieuMuon
-- ==========================================
DECLARE @PM1 UNIQUEIDENTIFIER = NEWID()
DECLARE @PM2 UNIQUEIDENTIFIER = NEWID()

INSERT INTO PhieuMuon (Id, DocGiaId, ThuThuId, NgayPhaiTra)
VALUES
(@PM1, @User3, @User2, DATEADD(DAY, 7, GETDATE())),
(@PM2, @User4, @User2, DATEADD(DAY, 10, GETDATE()));

-- ==========================================
-- 11. ChiTietPhieuMuon
-- ==========================================
INSERT INTO ChiTietPhieuMuon (PhieuMuonId, CuonSachId, TinhTrangKhiMuon)
VALUES
(@PM1, @CS1, N'Mới'),
(@PM1, @CS3, N'Mới'),
(@PM2, @CS5, N'Cũ'),
(@PM2, @CS7, N'Mới');

-- ==========================================
-- 12. PhieuPhat
-- ==========================================
INSERT INTO PhieuPhat (PhieuMuonId, DocGiaId, LyDoPhat, TongTienPhat)
VALUES
(@PM1, @User3, N'Trễ hạn', 10000),
(@PM2, @User4, N'Làm hỏng sách', 50000);