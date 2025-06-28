import React, { useEffect, useState } from 'react';
import axios from 'axios';

const HomeScreen = () => {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    axios.get(`https://api.themoviedb.org/3/discover/movie?api_key=${import.meta.env.VITE_APP_TMDB_V3_API_KEY}`)
      .then((res) => setMovies(res.data.results));
  }, []);

  return (
    <div>
      <h1>Netflix Clone</h1>
      <div style={{ display: 'flex', overflowX: 'scroll' }}>
        {movies.map(movie => (
          <img
            key={movie.id}
            src={`https://image.tmdb.org/t/p/w200${movie.poster_path}`}
            alt={movie.title}
          />
        ))}
      </div>
    </div>
  );
};

export default HomeScreen;

