import React from 'react';
import './HomeAnnouncements.css';


const HomeAnnouncements: React.FC = () => {
  return (
    <div className="announcements-container">
      <div className="announcement-item info">
        <div className="announcement-icon-wrapper">
          <span role="img" aria-label="megaphone">📢</span>
        </div>
        <p className="announcement-text">
          Thư viện mở cửa từ 7:00 – 21:00 các ngày trong tuần.
        </p>
      </div>

      <div className="announcement-item success">
        <div className="announcement-icon-wrapper">
          <span role="img" aria-label="party">🎉</span>
        </div>
        <p className="announcement-text">
          Bổ sung 50 đầu sách mới trong tháng 3/2026 – xem ngay!
        </p>
        <a href="#" className="announcement-link">Xem ngay &rarr;</a>
      </div>

      <div className="announcement-item warning">
        <div className="announcement-icon-wrapper">
          <span role="img" aria-label="warning">⚠️</span>
        </div>
        <p className="announcement-text">
          Nhắc nhở: Hạn trả sách tháng 3 là ngày 25/03/2026.
        </p>
      </div>
    </div>
  );
};

export default HomeAnnouncements;
