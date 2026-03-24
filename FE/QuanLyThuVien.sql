-- Tạo Database
CREATE DATABASE QuanLyThuVien;
GO

USE QuanLyThuVien;
GO

-- 1. BẢNG QUY ĐỊNH THƯ VIỆN
CREATE TABLE tham_so_quy_dinh (
    id VARCHAR(50) PRIMARY KEY,
    so_sach_muon_toi_da INT NOT NULL DEFAULT 3,
    so_ngay_muon_toi_da INT NOT NULL DEFAULT 14,
    phi_phat_tre_han DECIMAL(10, 2) NOT NULL DEFAULT 1000,
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- 2. BẢNG NGƯỜI DÙNG
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    ho_ten NVARCHAR(100) NOT NULL, -- Dùng NVARCHAR để lưu tiếng Việt có dấu
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau VARCHAR(255) NOT NULL,
    sdt VARCHAR(15),
    vai_tro NVARCHAR(20) NOT NULL CHECK (vai_tro IN (N'ADMIN', N'THỦ THƯ', N'ĐỘC GIẢ')),
    trang_thai NVARCHAR(20) DEFAULT N'HOẠT ĐỘNG' CHECK (trang_thai IN (N'HOẠT ĐỘNG', N'BỊ KHÓA')),
    so_lan_vi_pham INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- 3. BẢNG DANH MỤC SÁCH
CREATE TABLE categories (
    id VARCHAR(50) PRIMARY KEY,
    ten_danh_muc NVARCHAR(100) NOT NULL UNIQUE,
    mo_ta NVARCHAR(MAX) NULL
);
GO

-- 4. BẢNG SÁCH
CREATE TABLE books (
    id VARCHAR(50) PRIMARY KEY,
    ten_sach NVARCHAR(255) NOT NULL,
    tac_gia NVARCHAR(100) NOT NULL,
    nha_xuat_ban NVARCHAR(100),
    nam_xuat_ban INT,
    hinh_anh VARCHAR(255) NULL,
    mo_ta_sach NVARCHAR(MAX) NULL,
    so_luong_kho INT NOT NULL DEFAULT 0,
    category_id VARCHAR(50) NOT NULL,
    trang_thai NVARCHAR(20) DEFAULT N'CÒN SÁCH' CHECK (trang_thai IN (N'CÒN SÁCH', N'HẾT SÁCH', N'NGỪNG PHỤC VỤ')),
    CONSTRAINT FK_books_categories FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE NO ACTION
);
GO

-- 5. BẢNG YÊU CẦU MƯỢN
CREATE TABLE borrow_requests (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50),
    ngay_yeu_cau DATETIME DEFAULT GETDATE(),
    ghi_chu_nguoi_muon NVARCHAR(MAX) NULL,
    trang_thai NVARCHAR(20) DEFAULT N'CHỜ DUYỆT' CHECK (trang_thai IN (N'CHỜ DUYỆT', N'ĐÃ DUYỆT', N'TỪ CHỐI', N'ĐÃ HỦY')),
    CONSTRAINT FK_borrow_requests_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- 6. CHI TIẾT YÊU CẦU MƯỢN
CREATE TABLE request_details (
    request_id VARCHAR(50) NOT NULL,
    book_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (request_id, book_id),
    CONSTRAINT FK_req_details_req FOREIGN KEY (request_id) REFERENCES borrow_requests(id) ON DELETE CASCADE,
    CONSTRAINT FK_req_details_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
GO

-- 7. BẢNG PHIẾU MƯỢN
CREATE TABLE borrow_tickets (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL, 
    librarian_id VARCHAR(50) NOT NULL, 
    request_id VARCHAR(50) NULL UNIQUE, 
    ngay_muon DATETIME DEFAULT GETDATE(),
    ngay_phai_tra DATETIME NOT NULL,
    tong_tien_phat DECIMAL(10, 2) DEFAULT 0.00,
    trang_thai NVARCHAR(20) DEFAULT N'ĐANG MƯỢN' CHECK (trang_thai IN (N'ĐANG MƯỢN', N'ĐÃ TRẢ ĐỦ', N'QUÁ HẠN')),
    CONSTRAINT FK_tickets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE NO ACTION,
    CONSTRAINT FK_tickets_librarian FOREIGN KEY (librarian_id) REFERENCES users(id) ON DELETE NO ACTION,
    CONSTRAINT FK_tickets_request FOREIGN KEY (request_id) REFERENCES borrow_requests(id) ON DELETE SET NULL
);
GO

-- 8. CHI TIẾT PHIẾU MƯỢN
CREATE TABLE ticket_details (
    ticket_id VARCHAR(50) NOT NULL,
    book_id VARCHAR(50) NOT NULL,
    tinh_trang_khi_muon NVARCHAR(255) NOT NULL,
    tinh_trang_khi_tra NVARCHAR(255) NULL,
    tien_phat_sach DECIMAL(10, 2) DEFAULT 0.00,
    trang_thai_sach NVARCHAR(20) DEFAULT N'ĐANG MƯỢN' CHECK (trang_thai_sach IN (N'ĐANG MƯỢN', N'ĐÃ TRẢ', N'LÀM MẤT', N'HỎNG')),
    PRIMARY KEY (ticket_id, book_id),
    CONSTRAINT FK_ticket_details_ticket FOREIGN KEY (ticket_id) REFERENCES borrow_tickets(id) ON DELETE CASCADE,
    CONSTRAINT FK_ticket_details_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE NO ACTION
);
GO

-- 9. TRIGGER CẬP NHẬT THỜI GIAN CHO BẢNG QUY ĐỊNH
CREATE TRIGGER trg_Update_ThamSoQuyDinh
ON tham_so_quy_dinh
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE tham_so_quy_dinh
    SET updated_at = GETDATE()
    WHERE id IN (SELECT id FROM inserted);
END;
GO

INSERT INTO tham_so_quy_dinh (id, so_sach_muon_toi_da, so_ngay_muon_toi_da, phi_phat_tre_han)
VALUES
('QD01', 3, 14, 1000),
('QD02', 5, 10, 2000),
('QD03', 2, 7, 1500),
('QD04', 4, 20, 1200),
('QD05', 6, 15, 2500),
('QD06', 3, 30, 500),
('QD07', 1, 5, 3000),
('QD08', 7, 25, 800),
('QD09', 2, 12, 1000),
('QD10', 4, 18, 1800);

INSERT INTO users (
    id, ho_ten, email, mat_khau, sdt, vai_tro,
    trang_thai, so_lan_vi_pham, created_at
)
VALUES
('U01', N'Nguyễn Văn An', 'an@gmail.com', 'an123', '090000001', N'ADMIN', N'HOẠT ĐỘNG', 0, GETDATE()),
('U02', N'Trần Thị Bình', 'binh@gmail.com', 'binh123', '090000002', N'THỦ THƯ', N'HOẠT ĐỘNG', 0, GETDATE()),
('U03', N'Lê Văn Cương', 'cuong@gmail.com', 'cuong123', '090000003', N'ĐỘC GIẢ', N'HOẠT ĐỘNG', 1, GETDATE()),
('U04', N'Phạm Thị Duyên', 'duyen@gmail.com', 'duyen123', '090000004', N'ĐỘC GIẢ', N'HOẠT ĐỘNG', 0, GETDATE()),
('U05', N'Hoàng Văn Uyên', 'uyen@gmail.com', 'uyen123', '090000005', N'ĐỘC GIẢ', N'BỊ KHÓA', 2, GETDATE());

INSERT INTO categories (id, ten_danh_muc, mo_ta)
VALUES
('C01', N'Công nghệ thông tin', N'Sách về lập trình, phần mềm, AI'),
('C02', N'Kinh tế', N'Sách về kinh doanh, tài chính'),
('C03', N'Văn học', N'Truyện, tiểu thuyết, thơ'),
('C04', N'Khoa học', N'Sách khoa học tự nhiên, nghiên cứu'),
('C05', N'Thiếu nhi', N'Sách dành cho trẻ em');

INSERT INTO books (
    id, ten_sach, tac_gia, nha_xuat_ban, nam_xuat_ban,
    hinh_anh, mo_ta_sach, so_luong_kho, category_id, trang_thai
)
VALUES
('B01', N'Lập trình C# cơ bản', N'Nguyễn Văn A', N'NXB Giáo Dục', 2020, NULL, N'Sách học C# cho người mới', 10, 'C01', N'CÒN SÁCH'),
('B02', N'ASP.NET Core nâng cao', N'Trần Văn B', N'NXB Khoa Học', 2021, NULL, N'Phát triển web với .NET', 5, 'C01', N'CÒN SÁCH'),
('B03', N'Kinh tế vi mô', N'Lê Văn C', N'NXB Kinh Tế', 2019, NULL, N'Kiến thức kinh tế cơ bản', 7, 'C02', N'CÒN SÁCH'),
('B04', N'Dế mèn phiêu lưu ký', N'Tô Hoài', N'NXB Kim Đồng', 2018, NULL, N'Truyện thiếu nhi nổi tiếng', 3, 'C05', N'CÒN SÁCH'),
('B05', N'Truyện Kiều', N'Nguyễn Du', N'NXB Văn Học', 2015, NULL, N'Tác phẩm văn học kinh điển', 0, 'C03', N'HẾT SÁCH');

INSERT INTO borrow_requests (
    id, user_id, ngay_yeu_cau, ghi_chu_nguoi_muon, trang_thai
)
VALUES
('R01', 'U03', GETDATE(), N'Mượn để học', N'CHỜ DUYỆT'),
('R02', 'U04', GETDATE(), N'Mượn đọc giải trí', N'ĐÃ DUYỆT'),
('R03', 'U03', GETDATE(), NULL, N'TỪ CHỐI');

INSERT INTO request_details (request_id, book_id)
VALUES
('R01', 'B01'),
('R01', 'B02'),
('R02', 'B04'),
('R03', 'B05');

INSERT INTO borrow_tickets (
    id, user_id, librarian_id, request_id,
    ngay_muon, ngay_phai_tra, tong_tien_phat, trang_thai
)
VALUES
('T01', 'U04', 'U02', 'R02', GETDATE(), DATEADD(DAY, 14, GETDATE()), 0, N'ĐANG MƯỢN');

INSERT INTO ticket_details (
    ticket_id, book_id, tinh_trang_khi_muon,
    tinh_trang_khi_tra, tien_phat_sach, trang_thai_sach
)
VALUES
('T01', 'B04', N'Sách mới', NULL, 0, N'ĐANG MƯỢN');