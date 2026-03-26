import React from 'react';
import Header from '../components/layout/Header';
import LibraryHero from '../components/layout/LibraryHero';
import HomeAnnouncements from '../components/home/HomeAnnouncements';
import PopularBooks from '../components/home/PopularBooks';

const HomePage: React.FC = () => {
  return (
    <div style={{ backgroundColor: '#fff', minHeight: '100vh', paddingBottom: '40px' }}>
      <Header />
      <LibraryHero />
      <main>
        <HomeAnnouncements />
        <PopularBooks />
      </main>
    </div>
  );
};

export default HomePage;
