-- Tạo Database
CREATE DATABASE QuanLyThuVien;
GO

USE QuanLyThuVien;
GO

-- ==========================================
-- NHÓM 1: QUẢN TRỊ HỆ THỐNG & NGƯỜI DÙNG
-- ==========================================

-- 1. Bảng Cấu hình tham số
CREATE TABLE ThamSoQuyDinh (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    SoSachMuonToiDa INT NOT NULL,
    SoNgayMuonToiDa INT NOT NULL,
    PhiPhatTreHan DECIMAL(10,2) NOT NULL,
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Người dùng (Admin, Thủ thư, Độc giả)
CREATE TABLE NguoiDung (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(15),
    VaiTro INT NOT NULL, -- 1: Admin, 2: Thủ thư, 3: Độc giả
    TrangThai INT NOT NULL DEFAULT 1, -- 1: Hoạt động, 0: Bị khóa
    TaoLuc DATETIME DEFAULT GETDATE()
);

-- ==========================================
-- NHÓM 2: QUẢN LÝ SÁCH & DANH MỤC
-- ==========================================

-- 3. Bảng Danh mục (Thể loại)
CREATE TABLE DanhMucSach (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    TenDanhMuc NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX)
);

-- 4. Bảng Tác giả
CREATE TABLE TacGia (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    TenTacGia NVARCHAR(100) NOT NULL,
    GioiThieu NVARCHAR(MAX)
);

-- 5. Bảng Nhà xuất bản
CREATE TABLE NhaXuatBan (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    TenNXB NVARCHAR(100) NOT NULL
);

-- 6. Bảng Đầu sách (Thông tin chung về sách)
CREATE TABLE DauSach (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    TenSach NVARCHAR(255) NOT NULL,
    DanhMucId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES DanhMucSach(Id),
    TacGiaId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES TacGia(Id),
    NxbId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES NhaXuatBan(Id),
    NamXuatBan INT,
    HinhAnh VARCHAR(255),
    MoTa NVARCHAR(MAX)
);

-- 7. Bảng Cuốn sách (Bản sao vật lý cụ thể)
CREATE TABLE CuonSach (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    DauSachId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES DauSach(Id),
    MaVach VARCHAR(50) UNIQUE NOT NULL, -- Mã vạch thực tế dán trên sách (VD: CS001) để thủ thư dễ quét/nhập tay
    TinhTrangVatLy NVARCHAR(100) NOT NULL, -- Mới, Cũ, Rách bìa...
    TrangThaiMuon INT NOT NULL DEFAULT 1 -- 1: Sẵn sàng, 2: Đang cho mượn, 3: Đã mất, 4: Hỏng/Đang bảo trì
);

-- ==========================================
-- NHÓM 3: QUẢN LÝ MƯỢN TRẢ & VI PHẠM
-- ==========================================

-- 8. Bảng Yêu cầu mượn trực tuyến
CREATE TABLE YeuCauMuon (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    DocGiaId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES NguoiDung(Id),
    NgayYeuCau DATETIME DEFAULT GETDATE(),
    NgayHenNhan DATE,
    TrangThai INT NOT NULL DEFAULT 0 -- 0: Chờ duyệt, 1: Đã duyệt, 2: Bị từ chối, 3: Đã hủy
);

-- 9. Bảng Chi tiết yêu cầu mượn
CREATE TABLE ChiTietYeuCau (
    YeuCauId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES YeuCauMuon(Id),
    DauSachId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES DauSach(Id),
    PRIMARY KEY (YeuCauId, DauSachId)
);

-- 10. Bảng Phiếu mượn thực tế
CREATE TABLE PhieuMuon (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    DocGiaId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES NguoiDung(Id),
    ThuThuId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES NguoiDung(Id),
    YeuCauId UNIQUEIDENTIFIER NULL FOREIGN KEY REFERENCES YeuCauMuon(Id), -- Có thể NULL nếu độc giả đến mượn trực tiếp
    NgayMuon DATETIME DEFAULT GETDATE(),
    NgayPhaiTra DATETIME NOT NULL,
    TrangThai INT NOT NULL DEFAULT 1 -- 1: Đang mượn, 2: Đã trả đủ, 3: Đã trả nợ phạt
);

-- 11. Bảng Chi tiết phiếu mượn
CREATE TABLE ChiTietPhieuMuon (
    PhieuMuonId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES PhieuMuon(Id),
    CuonSachId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES CuonSach(Id),
    NgayTraThucTe DATETIME NULL,
    TinhTrangKhiMuon NVARCHAR(255),
    TinhTrangKhiTra NVARCHAR(255) NULL,
    TrangThaiTra INT NOT NULL DEFAULT 0, -- 0: Chưa trả, 1: Đã trả bình thường, 2: Trả trễ, 3: Làm mất/hỏng
    PRIMARY KEY (PhieuMuonId, CuonSachId)
);

-- 12. Bảng Phiếu phạt
CREATE TABLE PhieuPhat (
    Id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    PhieuMuonId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES PhieuMuon(Id),
    DocGiaId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES NguoiDung(Id),
    LyDoPhat NVARCHAR(255) NOT NULL,
    TongTienPhat DECIMAL(10,2) NOT NULL,
    TrangThaiThanhToan INT NOT NULL DEFAULT 0 -- 0: Chưa đóng, 1: Đã đóng
);