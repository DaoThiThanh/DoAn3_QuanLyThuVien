using Microsoft.Data.SqlClient;
using System.Data.SqlTypes;
namespace IdentityService.Repositories
{
    public class UserRepository
    {
        private readonly string _connectionString;

        public UserRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        //ktra đăng nhập
        public bool ValidateUser(string email, string matkhau, out int role, out Guid userid)
        {
            bool isValid = false;
            role = 0;
            userid = Guid.Empty;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {

                string query = "SELECT Id, VaiTro FROM NguoiDung WHERE Email = @Email AND MatKhau = @MatKhau  AND TrangThai = 1;";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@MatKhau", matkhau);
                conn.Open();
                using(SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        isValid = true;
                        userid = reader.GetGuid(0);
                        role = reader.GetInt32(1);
                    }
                }
            }
            return isValid;
        }

        //Đăng ký
        public bool RegisterUser(string hoten,string email, string matkhau, string sodienthoai, out string message)
        {
            bool isSuccess = false;
            message = "";
            using(SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                // 1. Kiểm tra xem Email đã tồn tại trong hệ thống chưa
                string checkQuery = "SELECT COUNT(1) FROM NguoiDung WHERE Email = @Email";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        message = "Email này đã được sử dụng bởi một tài khoản khác.";
                        return false;
                    }
                }

                // 2. Nếu Email chưa tồn tại, tiến hành thêm mới (Insert)
                // Lưu ý: Tôi giả định Id là kiểu UNIQUEIDENTIFIER (Guid) và tự động tạo mới bằng NEWID()
                string insertQuery = @"INSERT INTO NguoiDung (Id, Email, MatKhau, VaiTro, TrangThai) 
                               VALUES (NEWID(), @Email, @MatKhau, @VaiTro, 1);";

                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@HoTen", email);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@MatKhau", matkhau); // Nên mã hóa Hash mật khẩu trước khi truyền vào đây
                    insertCmd.Parameters.AddWithValue("@SoDienThoai", sodienthoai);

                    int rowsAffected = insertCmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        isSuccess = true;
                        message = "Đăng ký tài khoản thành công!";
                    }
                    else
                    {
                        message = "Đã xảy ra lỗi trong quá trình lưu dữ liệu.";
                    }
                }
            }

            return isSuccess;
        }
        }

    }
}
