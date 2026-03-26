import React from 'react';
import './PopularBooks.css';

interface Book {
  id: number;
  title: string;
  rating: number;
  isNew: boolean;
  image: string;
}

const popularBooks: Book[] = [
  { id: 1, title: 'Tiếng Anh học thuật cho sinh viên đại học', rating: 4.8, isNew: false, image: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&q=80&w=400' },
  { id: 2, title: 'Nhập môn Trí tuệ nhân tạo', rating: 4.8, isNew: true, image: 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=400' },
  { id: 3, title: 'Cấu trúc dữ liệu và giải thuật', rating: 4.9, isNew: true, image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=400' },
  { id: 4, title: 'Giải tích 1 - Toán cao cấp', rating: 4.5, isNew: false, image: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&q=80&w=400' },
  { id: 5, title: 'Triết học Mác - Lênin', rating: 4.4, isNew: false, image: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?auto=format&fit=crop&q=80&w=400' },
  { id: 6, title: 'Kinh tế vi mô - Nguyên lý và ứng dụng', rating: 4.4, isNew: true, image: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&q=80&w=400' },
  { id: 7, title: 'Lập trình C++ cơ bản đến nâng cao', rating: 4.7, isNew: false, image: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?auto=format&fit=crop&q=80&w=400' },
];

const PopularBooks: React.FC = () => {
  return (
    <div className="popular-books-container">
      <div className="section-header">
        <div className="header-left">
          <div className="icon-fire">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M8.5 14.5A2.5 2.5 0 0 0 11 12c-2.2 0-4-1.8-4-4a8 8 0 0 1 8-8 8 8 0 0 1 8 8c0 2.2-1.8 4-4 4a2.5 2.5 0 0 0 2.5 2.5C21.5 18 18 22 12 22s-9.5-4-9.5-7.5c0-2.3 2.1-4.7 4.1-6 2.3-1.6 3.4-3.5 3.4-3.5"/></svg>
          </div>
          <div className="header-titles">
            <h2 className="section-title">Sách phổ biến nhất</h2>
            <p className="section-subtitle">Được mượn nhiều nhất</p>
          </div>
        </div>
        <a href="#" className="view-all-link">
          Xem tất cả <span className="arrow">&gt;</span>
        </a>
      </div>

      <div className="books-list">
        {popularBooks.map((book) => (
          <div className="book-card" key={book.id}>
            <div 
              className="book-image-bg" 
              style={{ backgroundImage: `url(${book.image})` }}
            >
              <div className="book-gradient-overlay"></div>
              {book.isNew && <div className="badge-new">MỚI</div>}
              
              <div className="book-info">
                <h3 className="book-title">{book.title}</h3>
                <div className="book-rating">
                  <span className="star">★</span> {book.rating}
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default PopularBooks;
