import React from 'react';
import './BookCategories.css';

interface Category {
  id: string;
  title: string;
  count: number;
  icon: string;
  iconClass: string;
}

const categories: Category[] = [
  { id: 'cntt', title: 'Công nghệ thông tin', count: 3, icon: '💻', iconClass: 'icon-cntt' },
  { id: 'toan', title: 'Toán học', count: 1, icon: '📐', iconClass: 'icon-toan' },
  { id: 'vatly', title: 'Vật lý', count: 1, icon: '⚛️', iconClass: 'icon-vatly' },
  { id: 'lichsu', title: 'Lịch sử', count: 1, icon: '📜', iconClass: 'icon-lichsu' },
  { id: 'kinhte', title: 'Kinh tế', count: 2, icon: '📊', iconClass: 'icon-kinhte' },
  { id: 'ngoaingu', title: 'Ngoại ngữ', count: 1, icon: '🌍', iconClass: 'icon-ngoaingu' },
  { id: 'vanhoc', title: 'Văn học', count: 1, icon: '📝', iconClass: 'icon-vanhoc' },
  { id: 'hoahoc', title: 'Hóa học', count: 1, icon: '🧪', iconClass: 'icon-hoahoc' },
  { id: 'triethoc', title: 'Triết học', count: 1, icon: '🧠', iconClass: 'icon-triethoc' },
];

const BookCategories: React.FC = () => {
  return (
    <div className="categories-section">
      <div className="section-header">
        <div className="header-left">
          <div className="icon-grid">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
          </div>
          <div className="header-titles">
            <h2 className="section-title">Thể loại sách</h2>
            <p className="section-subtitle">Duyệt theo chủ đề</p>
          </div>
        </div>
      </div>

      <div className="categories-grid">
        {categories.map((category) => (
          <div className="category-card" key={category.id}>
            <div className={`category-icon-wrapper ${category.iconClass}`}>
              <span className="category-emoji" role="img" aria-label={category.title}>
                {category.icon}
              </span>
            </div>
            <h3 className="category-title">{category.title}</h3>
            <p className="category-count">{category.count} sách</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default BookCategories;
