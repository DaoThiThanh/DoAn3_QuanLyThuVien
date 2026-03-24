import React from 'react';
import Header from '../components/layout/Header';

const HomePage: React.FC = () => {
  return (
    <>
      <Header />
      <main style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto', textAlign: 'left' }}>
        <h2>Dashboard Content goes here</h2>
      </main>
    </>
  );
};

export default HomePage;
