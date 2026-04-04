using IdentityService.Models;
using IdentityService.Repositories;
using IdentityService.Services;
using Microsoft.AspNetCore.Mvc;
namespace IdentityService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserRepository _userRepo;
        private readonly TokenGenerator _tokenGen;

        public AuthController(UserRepository userRepository, TokenGenerator tokenGen)
        {
            _userRepo = userRepository;
            _tokenGen = tokenGen;
        }
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            bool isValid = _userRepo.ValidateUser(request.Email, request.MatKhau, out int role, out Guid userid);

            if (!isValid)
            {
                return Unauthorized(ResultRepository<object>.Fail("Sai email, mật khẩu hoặc tài khoản bị khóa!"));
            }

            // 2. Nếu đúng, tạo Token (sẽ code phần này sau)
            string tokenString =  _tokenGen.GenerateToken(userid, request.Email, role);
            // string token = _tokenGen.GenerateToken(request.Username, "Candidate");

            var responseData = new { 
                token = tokenString,
                userid = userid,
                role = role
            };
            return Ok(ResultRepository<object>.Ok(responseData, "Đăng nhập thành công!"));
        }

    }
}
