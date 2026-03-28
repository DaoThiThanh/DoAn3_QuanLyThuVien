import React from 'react';
import Header from '../components/layout/Header';
import LibraryHero from '../components/layout/LibraryHero';
import HomeAnnouncements from '../components/home/HomeAnnouncements';
import PopularBooks from '../components/home/PopularBooks';
import BookCategories from '../components/home/BookCategories';
import NewBooks from '../components/home/NewBooks';

const HomePage: React.FC = () => {
  return (
    <div style={{ backgroundColor: '#fff', minHeight: '100vh', paddingBottom: '40px' }}>
      <Header />
      <LibraryHero />
      <main>
        <HomeAnnouncements />
        <PopularBooks />
        <BookCategories />
        <NewBooks />
      </main>
    </div>
  );
};

export default HomePage;
