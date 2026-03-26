-- =============================================
-- 1. TẠO DATABASE
-- =============================================
CREATE DATABASE QuanLyThuVien;
GO

USE QuanLyThuVien;
GO

-- =============================================
-- 2. BẢNG THAM SỐ QUY ĐỊNH
-- =============================================
CREATE TABLE tham_so_quy_dinh (
    id VARCHAR(50) PRIMARY KEY,
    ten_quy_dinh NVARCHAR(100),
    so_sach_muon_toi_da INT NOT NULL,
    so_ngay_muon_toi_da INT NOT NULL,
    phi_phat_tre_han DECIMAL(10,2) NOT NULL,
    cap_nhat_luc DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- 3. BẢNG NGƯỜI DÙNG
-- =============================================
CREATE TABLE nguoi_dung (
    id VARCHAR(50) PRIMARY KEY,
    ho_ten NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mat_khau VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(15),
    vai_tro NVARCHAR(20) NOT NULL 
        CHECK (vai_tro IN (N'ADMIN', N'THỦ THƯ', N'ĐỘC GIẢ')),
    trang_thai NVARCHAR(20) DEFAULT N'HOẠT ĐỘNG' 
        CHECK (trang_thai IN (N'HOẠT ĐỘNG', N'BỊ KHÓA')),
    so_lan_vi_pham INT DEFAULT 0,
    tham_so_id VARCHAR(50) NOT NULL,
    tao_luc DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_nd_tham_so
        FOREIGN KEY (tham_so_id) REFERENCES tham_so_quy_dinh(id)
);
GO

-- =============================================
-- 4. DANH MỤC SÁCH
-- =============================================
CREATE TABLE danh_muc_sach (
    id VARCHAR(50) PRIMARY KEY,
    ten_danh_muc NVARCHAR(100) UNIQUE NOT NULL,
    mo_ta NVARCHAR(MAX)
);
GO

-- =============================================
-- 5. BẢNG SÁCH
-- =============================================
CREATE TABLE sach (
    id VARCHAR(50) PRIMARY KEY,
    ten_sach NVARCHAR(255) NOT NULL,
    tac_gia NVARCHAR(100) NOT NULL,
    nha_xuat_ban NVARCHAR(100),
    nam_xuat_ban INT,
    hinh_anh VARCHAR(255),
    mo_ta NVARCHAR(MAX),
    so_luong INT DEFAULT 0,
    danh_muc_id VARCHAR(50) NOT NULL,
    trang_thai NVARCHAR(20) DEFAULT N'CÒN SÁCH'
        CHECK (trang_thai IN (N'CÒN SÁCH', N'HẾT SÁCH', N'NGỪNG PHỤC VỤ')),
    CONSTRAINT FK_sach_danh_muc
        FOREIGN KEY (danh_muc_id) REFERENCES danh_muc_sach(id)
);
GO

-- =============================================
-- 6. YÊU CẦU MƯỢN
-- =============================================
CREATE TABLE yeu_cau_muon (
    id VARCHAR(50) PRIMARY KEY,
    nguoi_dung_id VARCHAR(50) NOT NULL,
    ngay_yeu_cau DATETIME DEFAULT GETDATE(),
    ghi_chu NVARCHAR(MAX),
    trang_thai NVARCHAR(20) DEFAULT N'CHỜ DUYỆT'
        CHECK (trang_thai IN (N'CHỜ DUYỆT', N'ĐÃ DUYỆT', N'TỪ CHỐI', N'ĐÃ HỦY')),
    CONSTRAINT FK_yc_nd
        FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id) ON DELETE CASCADE
);
GO

-- =============================================
-- 7. CHI TIẾT YÊU CẦU
-- =============================================
CREATE TABLE chi_tiet_yeu_cau (
    yeu_cau_id VARCHAR(50),
    sach_id VARCHAR(50),
    PRIMARY KEY (yeu_cau_id, sach_id),
    FOREIGN KEY (yeu_cau_id) REFERENCES yeu_cau_muon(id) ON DELETE CASCADE,
    FOREIGN KEY (sach_id) REFERENCES sach(id) ON DELETE CASCADE
);
GO

-- =============================================
-- 8. PHIẾU MƯỢN
-- =============================================
CREATE TABLE phieu_muon (
    id VARCHAR(50) PRIMARY KEY,
    doc_gia_id VARCHAR(50) NOT NULL,
    thu_thu_id VARCHAR(50) NOT NULL,
    yeu_cau_id VARCHAR(50) UNIQUE,
    ngay_muon DATETIME DEFAULT GETDATE(),
    ngay_phai_tra DATETIME NOT NULL,
    tong_tien_phat DECIMAL(10,2) DEFAULT 0,
    trang_thai NVARCHAR(20) DEFAULT N'ĐANG MƯỢN'
        CHECK (trang_thai IN (N'ĐANG MƯỢN', N'ĐÃ TRẢ', N'QUÁ HẠN')),
    FOREIGN KEY (doc_gia_id) REFERENCES nguoi_dung(id),
    FOREIGN KEY (thu_thu_id) REFERENCES nguoi_dung(id),
    FOREIGN KEY (yeu_cau_id) REFERENCES yeu_cau_muon(id) ON DELETE SET NULL
);
GO

-- =============================================
-- 9. CHI TIẾT PHIẾU MƯỢN
-- =============================================
CREATE TABLE chi_tiet_phieu_muon (
    phieu_muon_id VARCHAR(50),
    sach_id VARCHAR(50),
    tinh_trang_khi_muon NVARCHAR(255),
    tinh_trang_khi_tra NVARCHAR(255),
    tien_phat DECIMAL(10,2) DEFAULT 0,
    trang_thai NVARCHAR(20) DEFAULT N'ĐANG MƯỢN'
        CHECK (trang_thai IN (N'ĐANG MƯỢN', N'ĐÃ TRẢ', N'LÀM MẤT', N'HỎNG')),
    PRIMARY KEY (phieu_muon_id, sach_id),
    FOREIGN KEY (phieu_muon_id) REFERENCES phieu_muon(id) ON DELETE CASCADE,
    FOREIGN KEY (sach_id) REFERENCES sach(id)
);
GO

-- =============================================
-- 10. DỮ LIỆU MẪU
-- =============================================

-- THAM SỐ
INSERT INTO tham_so_quy_dinh VALUES
('QD01', N'Quy định thường', 3, 14, 1000, GETDATE()),
('QD02', N'VIP', 5, 30, 500, GETDATE()),
('QD03', N'Hạn chế', 1, 7, 3000, GETDATE());

-- NGƯỜI DÙNG
INSERT INTO nguoi_dung VALUES
('ND01', N'Nguyễn Văn A', 'a@gmail.com', '123', '0901', N'ADMIN', N'HOẠT ĐỘNG', 0, 'QD01', GETDATE()),
('ND02', N'Trần Thị B', 'b@gmail.com', '123', '0902', N'THỦ THƯ', N'HOẠT ĐỘNG', 0, 'QD01', GETDATE()),
('ND03', N'Lê Văn C', 'c@gmail.com', '123', '0903', N'ĐỘC GIẢ', N'HOẠT ĐỘNG', 0, 'QD02', GETDATE()),
('ND04', N'Phạm Văn D', 'd@gmail.com', '123', '0904', N'ĐỘC GIẢ', N'HOẠT ĐỘNG', 2, 'QD03', GETDATE());

-- DANH MỤC
INSERT INTO danh_muc_sach VALUES
('DM01', N'Công nghệ thông tin', N'Lập trình'),
('DM02', N'Kinh tế', N'Kinh doanh');

-- SÁCH
INSERT INTO sach VALUES
('S01', N'Lập trình C#', N'Nguyễn A', N'NXB GD', 2020, NULL, NULL, 10, 'DM01', N'CÒN SÁCH'),
('S02', N'Kinh tế học', N'Lê B', N'NXB KT', 2019, NULL, NULL, 5, 'DM02', N'CÒN SÁCH');

-- YÊU CẦU
INSERT INTO yeu_cau_muon VALUES
('YC01', 'ND03', GETDATE(), NULL, N'CHỜ DUYỆT');

-- CHI TIẾT YÊU CẦU
INSERT INTO chi_tiet_yeu_cau VALUES
('YC01', 'S01');

-- PHIẾU MƯỢN
INSERT INTO phieu_muon VALUES
('PM01', 'ND03', 'ND02', 'YC01', GETDATE(), DATEADD(DAY, 30, GETDATE()), 0, N'ĐANG MƯỢN');

-- CHI TIẾT PHIẾU
INSERT INTO chi_tiet_phieu_muon VALUES
('PM01', 'S01', N'Mới', NULL, 0, N'ĐANG MƯỢN');