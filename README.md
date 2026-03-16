# DoAn3_QuanLyThuVien
# 📚 Website Quản Lý Thư Viện

## 1. Giới thiệu
Website Quản Lý Thư Viện là hệ thống giúp quản lý sách, người đọc và quá trình mượn trả sách trong thư viện. 
Hệ thống cho phép người dùng tìm kiếm sách, đăng ký mượn sách và giúp quản trị viên quản lý toàn bộ hoạt động của thư viện.

## 1. Các Actor trong hệ thống
### 👨‍💼 Quản trị viên (Admin)
* Quản lý toàn bộ hệ thống
* Quản lý người dùng
* Xem thống kê hệ thống

### 📚 Thủ thư
* Quản lý sách, danh mục sách
* Quản lý mượn và trả sách
* Kiểm tra tình trạng sách
* Xử lý yêu cầu mượn sách
* Thống kê hoạt động của thư viện
  
### 👤 Người đọc (User / Sinh viên)
* Tìm kiếm sách
* Đăng ký mượn sách
* Xem lịch sử mượn

---
# 2. Quy trình nghiệp vụ tổng quát
Hệ thống thư viện có các nghiệp vụ chính:
* Quản lý sách
* Quản lý người đọc
* Quản lý mượn trả sách
* Tra cứu và tìm kiếm sách

---
# 3. Quy trình nghiệp vụ chi tiết
## 3.1 Quy trình quản lý sách
1. Thủ thư đăng nhập hệ thống
2. Chọn chức năng quản lý sách
3. Thực hiện các thao tác:
   * Thêm sách mới
   * Cập nhật thông tin sách
   * Xóa sách
   * Quản lý số lượng sách
4. Hệ thống lưu dữ liệu vào Database

## 3.2 Quy trình quản lý người đọc
1. Người dùng đăng ký tài khoản
2. Hệ thống lưu thông tin người đọc
3. Thủ thư có thể:
   * Xem danh sách người đọc
   * Cập nhật thông tin
   * Khóa tài khoản nếu vi phạm
   * 
## 3.3 Quy trình mượn sách
1. Người đọc đăng nhập website
2. Tìm kiếm sách cần mượn
3. Gửi yêu cầu mượn sách
4. Thủ thư nhận yêu cầu
5. Kiểm tra tình trạng sách (còn hay không)
6. Nếu sách còn:
   * Duyệt yêu cầu mượn
7. Hệ thống tạo phiếu mượn

---
## 3.4 Quy trình trả sách
1. Người đọc mang sách đến trả
2. Thủ thư tìm phiếu mượn và kiểm tra tình trạng sách
3. Cập nhật trạng thái đã trả
4. Hệ thống:
   * Tăng lại số lượng sách
Nếu trả muộn:
* Hệ thống tính tiền phạt

---
# 5. Các chức năng chính của hệ thống
### Người đọc
* Đăng ký tài khoản
* Đăng nhập
* Tìm kiếm sách
* Mượn sách
* Xem lịch sử mượn

### Thủ thư
* Quản lý sách
* Duyệt yêu cầu mượn
* Quản lý trả sách
* Quản lý phiếu mượn

### Admin
* Quản lý người dùng
* Thống kê hệ thống
