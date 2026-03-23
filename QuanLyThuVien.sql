-- T?o Database
CREATE DATABASE QuanLyThuVien;
GO

USE QuanLyThuVien;
GO

-- 1. B?NG QUY ??NH TH? VI?N
CREATE TABLE tham_so_quy_dinh (
    id VARCHAR(50) PRIMARY KEY,
    so_sach_muon_toi_da INT NOT NULL DEFAULT 3,
    so_ngay_muon_toi_da INT NOT NULL DEFAULT 14,
    phi_phat_tre_han DECIMAL(10, 2) NOT NULL DEFAULT 1000,
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- 2. B?NG NG??I DÙNG
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    ho_ten NVARCHAR(100) NOT NULL, -- Dùng NVARCHAR ?? l?u ti?ng Vi?t có d?u
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau VARCHAR(255) NOT NULL,
    sdt VARCHAR(15),
    vai_tro NVARCHAR(20) NOT NULL CHECK (vai_tro IN (N'ADMIN', N'TH? TH?', N'??C GI?')),
    trang_thai NVARCHAR(20) DEFAULT N'HO?T ??NG' CHECK (trang_thai IN (N'HO?T ??NG', N'B? KHÓA')),
    so_lan_vi_pham INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- 3. B?NG DANH M?C SÁCH
CREATE TABLE categories (
    id VARCHAR(50) PRIMARY KEY,
    ten_danh_muc NVARCHAR(100) NOT NULL UNIQUE,
    mo_ta NVARCHAR(MAX) NULL
);
GO

-- 4. B?NG SÁCH
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
    trang_thai NVARCHAR(20) DEFAULT N'CÒN SÁCH' CHECK (trang_thai IN (N'CÒN SÁCH', N'H?T SÁCH', N'NG?NG PH?C V?')),
    CONSTRAINT FK_books_categories FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE NO ACTION
);
GO

-- 5. B?NG YÊU C?U M??N
CREATE TABLE borrow_requests (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50),
    ngay_yeu_cau DATETIME DEFAULT GETDATE(),
    ghi_chu_nguoi_muon NVARCHAR(MAX) NULL,
    trang_thai NVARCHAR(20) DEFAULT N'CH? DUY?T' CHECK (trang_thai IN (N'CH? DUY?T', N'?Ã DUY?T', N'T? CH?I', N'?Ã H?Y')),
    CONSTRAINT FK_borrow_requests_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- 6. CHI TI?T YÊU C?U M??N
CREATE TABLE request_details (
    request_id VARCHAR(50) NOT NULL,
    book_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (request_id, book_id),
    CONSTRAINT FK_req_details_req FOREIGN KEY (request_id) REFERENCES borrow_requests(id) ON DELETE CASCADE,
    CONSTRAINT FK_req_details_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
GO

-- 7. B?NG PHI?U M??N
CREATE TABLE borrow_tickets (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL, 
    librarian_id VARCHAR(50) NOT NULL, 
    request_id VARCHAR(50) NULL UNIQUE, 
    ngay_muon DATETIME DEFAULT GETDATE(),
    ngay_phai_tra DATETIME NOT NULL,
    tong_tien_phat DECIMAL(10, 2) DEFAULT 0.00,
    trang_thai NVARCHAR(20) DEFAULT N'?ANG M??N' CHECK (trang_thai IN (N'?ANG M??N', N'?Ã TR? ??', N'QUÁ H?N')),
    CONSTRAINT FK_tickets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE NO ACTION,
    CONSTRAINT FK_tickets_librarian FOREIGN KEY (librarian_id) REFERENCES users(id) ON DELETE NO ACTION,
    CONSTRAINT FK_tickets_request FOREIGN KEY (request_id) REFERENCES borrow_requests(id) ON DELETE SET NULL
);
GO

-- 8. CHI TI?T PHI?U M??N
CREATE TABLE ticket_details (
    ticket_id VARCHAR(50) NOT NULL,
    book_id VARCHAR(50) NOT NULL,
    tinh_trang_khi_muon NVARCHAR(255) NOT NULL,
    tinh_trang_khi_tra NVARCHAR(255) NULL,
    tien_phat_sach DECIMAL(10, 2) DEFAULT 0.00,
    trang_thai_sach NVARCHAR(20) DEFAULT N'?ANG M??N' CHECK (trang_thai_sach IN (N'?ANG M??N', N'?Ã TR?', N'LÀM M?T', N'H?NG')),
    PRIMARY KEY (ticket_id, book_id),
    CONSTRAINT FK_ticket_details_ticket FOREIGN KEY (ticket_id) REFERENCES borrow_tickets(id) ON DELETE CASCADE,
    CONSTRAINT FK_ticket_details_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE NO ACTION
);
GO

-- 9. TRIGGER C?P NH?T TH?I GIAN CHO B?NG QUY ??NH
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
('U01', N'Nguy?n V?n An', 'an@gmail.com', 'an123', '090000001', N'ADMIN', N'HO?T ??NG', 0, GETDATE()),
('U02', N'Tr?n Th? Bình', 'binh@gmail.com', 'binh123', '090000002', N'TH? TH?', N'HO?T ??NG', 0, GETDATE()),
('U03', N'Lê V?n C??ng', 'cuong@gmail.com', 'cuong123', '090000003', N'??C GI?', N'HO?T ??NG', 1, GETDATE()),
('U04', N'Ph?m Th? Duyên', 'duyen@gmail.com', 'duyen123', '090000004', N'??C GI?', N'HO?T ??NG', 0, GETDATE()),
('U05', N'Hoàng V?n Uyên', 'uyen@gmail.com', 'uyen123', '090000005', N'??C GI?', N'B? KHÓA', 2, GETDATE());

INSERT INTO categories (id, ten_danh_muc, mo_ta)
VALUES
('C01', N'Công ngh? thông tin', N'Sách v? l?p trình, ph?n m?m, AI'),
('C02', N'Kinh t?', N'Sách v? kinh doanh, tài chính'),
('C03', N'V?n h?c', N'Truy?n, ti?u thuy?t, th?'),
('C04', N'Khoa h?c', N'Sách khoa h?c t? nhiên, nghiên c?u'),
('C05', N'Thi?u nhi', N'Sách dành cho tr? em');

INSERT INTO books (
    id, ten_sach, tac_gia, nha_xuat_ban, nam_xuat_ban,
    hinh_anh, mo_ta_sach, so_luong_kho, category_id, trang_thai
)
VALUES
('B01', N'L?p trình C# c? b?n', N'Nguy?n V?n A', N'NXB Giáo D?c', 2020, NULL, N'Sách h?c C# cho ng??i m?i', 10, 'C01', N'CÒN SÁCH'),
('B02', N'ASP.NET Core nâng cao', N'Tr?n V?n B', N'NXB Khoa H?c', 2021, NULL, N'Phát tri?n web v?i .NET', 5, 'C01', N'CÒN SÁCH'),
('B03', N'Kinh t? vi mô', N'Lê V?n C', N'NXB Kinh T?', 2019, NULL, N'Ki?n th?c kinh t? c? b?n', 7, 'C02', N'CÒN SÁCH'),
('B04', N'D? mèn phiêu l?u ký', N'Tô Hoài', N'NXB Kim ??ng', 2018, NULL, N'Truy?n thi?u nhi n?i ti?ng', 3, 'C05', N'CÒN SÁCH'),
('B05', N'Truy?n Ki?u', N'Nguy?n Du', N'NXB V?n H?c', 2015, NULL, N'Tác ph?m v?n h?c kinh ?i?n', 0, 'C03', N'H?T SÁCH');

INSERT INTO borrow_requests (
    id, user_id, ngay_yeu_cau, ghi_chu_nguoi_muon, trang_thai
)
VALUES
('R01', 'U03', GETDATE(), N'M??n ?? h?c', N'CH? DUY?T'),
('R02', 'U04', GETDATE(), N'M??n ??c gi?i trí', N'?Ã DUY?T'),
('R03', 'U03', GETDATE(), NULL, N'T? CH?I');

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
('T01', 'U04', 'U02', 'R02', GETDATE(), DATEADD(DAY, 14, GETDATE()), 0, N'?ANG M??N');

INSERT INTO ticket_details (
    ticket_id, book_id, tinh_trang_khi_muon,
    tinh_trang_khi_tra, tien_phat_sach, trang_thai_sach
)
VALUES
('T01', 'B04', N'Sách m?i', NULL, 0, N'?ANG M??N');