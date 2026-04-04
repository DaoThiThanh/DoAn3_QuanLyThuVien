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
    }
}
