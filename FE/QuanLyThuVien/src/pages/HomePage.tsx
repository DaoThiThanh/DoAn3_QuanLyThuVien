import React from 'react';
import Header from '../components/layout/Header';
import LibraryHero from '../components/layout/LibraryHero';

const HomePage: React.FC = () => {
  return (
    <>
      <Header />
      <LibraryHero />
      <main style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto', textAlign: 'left' }}>
        {/* Placeholder for standard dashboard content below the hero */}
      </main>
    </>
  );
};

export default HomePage;
