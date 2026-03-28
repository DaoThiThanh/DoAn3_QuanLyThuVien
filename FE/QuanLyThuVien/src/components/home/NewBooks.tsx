import React from 'react';
import './NewBooks.css';

interface Book {
  id: number;
  title: string;
  category: string;
  isNew: boolean;
  status: 'available' | 'borrowed';
  image: string;
}

const newBooks: Book[] = [
  { id: 1, title: 'Kinh tế vi mô - Nguyên lý và ứng dụng', category: 'Kinh tế', isNew: true, status: 'available', image: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&q=80&w=400' },
  { id: 2, title: 'Cấu trúc dữ liệu và giải thuật', category: 'Công nghệ thông tin', isNew: true, status: 'available', image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=400' },
  { id: 3, title: 'Nhập môn Trí tuệ nhân tạo', category: 'Công nghệ thông tin', isNew: true, status: 'available', image: 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=400' },
];

const NewBooks: React.FC = () => {
  return (
    <div className="new-books-container">
      <div className="section-header">
        <div className="header-left">
          <div className="icon-sparkle">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z"/></svg>
          </div>
          <div className="header-titles">
            <h2 className="section-title">Sách mới bổ sung</h2>
            <p className="section-subtitle">Cập nhật tháng 3/2026</p>
          </div>
        </div>
        <a href="#" className="view-all-link">
          Xem tất cả <span className="arrow">&gt;</span>
        </a>
      </div>

      <div className="new-books-list">
        {newBooks.map((book) => (
          <div className="new-book-card" key={book.id}>
            <div className="book-cover-wrapper">
              <img src={book.image} alt={book.title} className="book-cover-image" />
              {book.isNew && <div className="badge-new-blue">MỚI</div>}
              {book.status === 'available' && (
                <div className="badge-status online">• Có sẵn</div>
              )}
            </div>
            <div className="book-info">
              <span className="book-category">{book.category}</span>
              <h3 className="book-title">{book.title}</h3>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default NewBooks;
