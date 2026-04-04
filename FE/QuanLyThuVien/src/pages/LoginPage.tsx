import React, { useState } from 'react';
import './LoginPage.css';
import { Link, useNavigate } from 'react-router-dom';
import authService from '../services/modules/authService';

const LoginPage: React.FC = () => {
  const navigate = useNavigate(); // Khởi tạo hook điều hướng
  const [formData, setFormData] = useState({
    email: '',
    password: '',
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      console.log('Đang gửi dữ liệu đăng nhập:', formData);

      // Gọi API thông qua authService
      // Lưu ý: Nếu API của bạn dùng 'username' thay vì 'email', 
      // hãy đổi key tương ứng: { username: formData.email, password: formData.password }
      const response: any = await authService.login(formData);

      // Giả sử API trả về token khi thành công
      if (response && response.token) {
        // 1. Lưu token vào localStorage để dùng cho các request sau
        localStorage.setItem('accessToken', response.token);

        // 2. (Tùy chọn) Lưu thông tin user nếu cần
        // localStorage.setItem('user', JSON.stringify(response.user));

        alert('Đăng nhập thành công!');

        // 3. Chuyển hướng về trang chủ hoặc trang quản lý
        navigate('/');
      }
    } catch (error: any) {
      console.error('Lỗi đăng nhập:', error);

      // Hiển thị thông báo lỗi cho người dùng
      const errorMessage = error.response?.data?.message || 'Email hoặc mật khẩu không chính xác!';
      alert(errorMessage);
    }
  };

  return (
    <div className="login-page">
      {/* Decorative background circles */}
      <div className="bg-circles">
        <div className="circle circle-1"></div>
        <div className="circle circle-2"></div>
        <div className="circle circle-3"></div>
      </div>

      <div className="login-container">
        <div className="login-card">
          {/* Left side (Information/Welcome) */}
          <div className="login-left">
            <div className="brand-logo">
              <div className="logo-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20" /></svg>
              </div>
              <span className="brand-text">UniLibrary</span>
            </div>

            <h1 className="login-title">
              Chào mừng <br /> <span className="highlight-text">trở lại!</span>
            </h1>
            <p className="login-description">
              Đăng nhập để xem các sách đang mượn, quản lý yêu cầu mượn sách trực tuyến và nhận các thông báo từ thư viện trung tâm.
            </p>

            <div className="stats-container">
              <div className="stat-item">
                <span className="stat-value">1,200+</span>
                <span className="stat-label">Đầu sách</span>
              </div>
              <div className="stat-item">
                <span className="stat-value">24/7</span>
                <span className="stat-label">Truy cập</span>
              </div>
            </div>
          </div>

          {/* Right side (Form) */}
          <div className="login-right">
            <h2 className="form-title">Đăng nhập</h2>
            <p className="form-subtitle">
              Chưa có tài khoản? <Link to="/register" className="register-link">Đăng ký ngay</Link>
            </p>

            <form className="login-form" onSubmit={handleSubmit}>
              <div className="form-group">
                <label htmlFor="email">Email</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="4" /><path d="M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-4 8" /></svg>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Nhập email của bạn"
                    value={formData.email}
                    onChange={handleChange}
                    required
                  />
                </div>
              </div>

              <div className="form-group">
                <label htmlFor="password">Mật khẩu</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect width="18" height="11" x="3" y="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" /></svg>
                  <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="••••••••"
                    value={formData.password}
                    onChange={handleChange}
                    required
                  />
                </div>
              </div>

              <div className="form-options">
                <div className="remember-me">
                  <input type="checkbox" id="remember" />
                  <label htmlFor="remember">Ghi nhớ đăng nhập</label>
                </div>
                <a href="#" className="forgot-password">Quên mật khẩu?</a>
              </div>

              <button type="submit" className="btn-login">Đăng nhập</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};
export default LoginPage;
