# Website Quản Lý Thư Viện

## 1. Giới thiệu hệ thống

Website Quản Lý Thư Viện là một hệ thống phần mềm được xây dựng nhằm hỗ trợ việc quản lý và vận hành các hoạt động trong thư viện một cách hiệu quả. Hệ thống giúp quản lý thông tin sách, người đọc và toàn bộ quá trình mượn – trả sách.

Thông qua website, người đọc có thể dễ dàng tìm kiếm sách, xem thông tin chi tiết của sách và gửi yêu cầu mượn sách. Thủ thư có thể quản lý danh sách sách, xử lý các yêu cầu mượn – trả sách và theo dõi tình trạng sách trong thư viện. Quản trị viên có thể quản lý người dùng và theo dõi hoạt động chung của hệ thống.

Việc sử dụng hệ thống quản lý thư viện giúp giảm bớt công việc thủ công, tăng độ chính xác khi lưu trữ dữ liệu và nâng cao hiệu quả quản lý thư viện.



# 2. Các Actor trong hệ thống

## Quản trị viên (Admin)

Quản trị viên là người có quyền cao nhất trong hệ thống, chịu trách nhiệm quản lý toàn bộ hoạt động của website.

### Chức năng của Admin

**Quản lý người dùng**

* Xem danh sách tất cả người dùng trong hệ thống
* Thêm mới tài khoản người dùng
* Cập nhật thông tin tài khoản
* Khóa hoặc mở khóa tài khoản khi cần thiết

**Phân quyền hệ thống**

* Phân quyền cho các tài khoản (Admin, Thủ thư, Người đọc)

**Thống kê và báo cáo**

* Thống kê tổng số sách trong thư viện
* Thống kê số lượng người dùng
* Thống kê số lượt mượn sách
* Thống kê những cuốn sách được mượn nhiều nhất



## Thủ thư

Thủ thư là người trực tiếp quản lý các hoạt động của thư viện như quản lý sách, xử lý mượn sách và trả sách.

### Chức năng của Thủ thư

**Quản lý sách**

* Thêm sách mới vào hệ thống
* Cập nhật thông tin sách
* Xóa sách khỏi hệ thống
* Cập nhật số lượng sách trong thư viện

**Quản lý danh mục sách**

* Thêm danh mục sách
* Cập nhật danh mục sách
* Xóa danh mục sách

**Quản lý mượn sách**

* Xem danh sách yêu cầu mượn sách
* Duyệt hoặc từ chối yêu cầu mượn sách
* Tạo phiếu mượn sách

**Quản lý trả sách**

* Kiểm tra phiếu mượn
* Cập nhật trạng thái trả sách
* Kiểm tra tình trạng sách khi trả



## Người đọc (User / Sinh viên)

Người đọc là người sử dụng hệ thống để tìm kiếm và mượn sách từ thư viện.

### Chức năng của Người đọc

**Quản lý tài khoản**

* Đăng ký tài khoản
* Đăng nhập hệ thống
* Cập nhật thông tin cá nhân

**Tìm kiếm sách**

* Tìm kiếm theo tên sách
* Tìm kiếm theo tác giả
* Tìm kiếm theo danh mục

**Mượn sách**

* Gửi yêu cầu mượn sách
* Theo dõi trạng thái yêu cầu mượn

**Lịch sử mượn**

* Xem danh sách sách đã mượn
* Xem trạng thái mượn sách (đang mượn hoặc đã trả)



# 3. Quy trình nghiệp vụ tổng quát

Hệ thống quản lý thư viện bao gồm các nghiệp vụ chính sau:

### 1. Quản lý sách

Cho phép thủ thư thêm mới, chỉnh sửa, xóa và cập nhật thông tin của sách trong thư viện.

### 2. Quản lý người đọc

Quản lý thông tin người dùng trong hệ thống bao gồm đăng ký tài khoản và quản lý thông tin cá nhân của người đọc.

### 3. Quản lý mượn – trả sách

Theo dõi và quản lý toàn bộ quá trình mượn và trả sách của người đọc.

### 4. Tra cứu và tìm kiếm sách

Cho phép người đọc tìm kiếm sách theo nhiều tiêu chí khác nhau để nhanh chóng tìm được tài liệu cần thiết.



# 4. Quy trình nghiệp vụ chi tiết

## 4.1 Quy trình quản lý sách

Quy trình quản lý sách được thực hiện bởi **Thủ thư**.

### Các bước thực hiện

**Bước 1:** Thủ thư đăng nhập vào hệ thống bằng tài khoản được cấp.

**Bước 2:** Sau khi đăng nhập thành công, thủ thư truy cập vào chức năng **Quản lý sách**.

**Bước 3:** Thủ thư có thể thực hiện các thao tác sau:

* Thêm sách mới vào hệ thống
* Cập nhật thông tin sách như tên sách, tác giả, nhà xuất bản, năm xuất bản
* Xóa sách khỏi hệ thống nếu sách không còn sử dụng
* Cập nhật số lượng sách khi có sách mới được bổ sung

**Bước 4:** Sau khi thực hiện các thao tác, hệ thống sẽ lưu dữ liệu vào cơ sở dữ liệu (Database).



## 4.2 Quy trình quản lý người đọc

### Bước 1: Đăng ký tài khoản

Người đọc truy cập vào website và chọn chức năng **Đăng ký tài khoản**.
Người dùng nhập các thông tin cần thiết như:

* Họ và tên
* Email
* Mật khẩu
* Số điện thoại

Sau khi đăng ký thành công, hệ thống sẽ lưu thông tin người dùng vào cơ sở dữ liệu.

### Bước 2: Quản lý tài khoản

Thủ thư hoặc Admin có thể:

* Xem danh sách người đọc
* Cập nhật thông tin người đọc
* Khóa tài khoản nếu người đọc vi phạm quy định của thư viện



## 4.3 Quy trình mượn sách

Quy trình mượn sách được thực hiện theo các bước sau:

**Bước 1:** Người đọc đăng nhập vào hệ thống.

**Bước 2:** Người đọc sử dụng chức năng tìm kiếm để tìm sách muốn mượn.

**Bước 3:** Người đọc gửi **yêu cầu mượn sách** trên hệ thống.

**Bước 4:** Thủ thư nhận được yêu cầu mượn sách từ hệ thống.

**Bước 5:** Thủ thư kiểm tra:

* Tình trạng sách còn hay không
* Người đọc có vi phạm quy định mượn sách hay không

**Bước 6:** Nếu sách còn trong thư viện:

* Thủ thư duyệt yêu cầu mượn sách.

**Bước 7:** Hệ thống tạo **phiếu mượn sách**, bao gồm:

* Mã phiếu mượn
* Thông tin người mượn
* Danh sách sách mượn
* Ngày mượn
* Ngày phải trả



## 4.4 Quy trình trả sách

Quy trình trả sách được thực hiện khi người đọc mang sách đến thư viện.

### Các bước thực hiện

**Bước 1:** Người đọc mang sách đến thư viện để trả.

**Bước 2:** Thủ thư tìm kiếm **phiếu mượn sách** trong hệ thống.

**Bước 3:** Thủ thư kiểm tra:

* Tình trạng của sách
* Thời gian trả sách

**Bước 4:** Nếu sách được trả đúng hạn:

* Hệ thống cập nhật trạng thái phiếu mượn thành **đã trả**.

**Bước 5:** Hệ thống tự động:

* Tăng lại số lượng sách trong kho.

**Bước 6:** Nếu trả sách quá hạn:

* Hệ thống tính tiền phạt theo quy định của thư viện.



# 5. Các chức năng chính của hệ thống

## Người đọc

* Đăng ký tài khoản
* Đăng nhập hệ thống
* Tìm kiếm sách
* Xem thông tin chi tiết sách
* Gửi yêu cầu mượn sách
* Xem lịch sử mượn sách



## Thủ thư

* Quản lý sách
* Quản lý danh mục sách
* Duyệt yêu cầu mượn sách
* Quản lý trả sách
* Quản lý phiếu mượn



## Admin

* Quản lý người dùng
* Phân quyền hệ thống
* Thống kê và báo cáo hệ thống

