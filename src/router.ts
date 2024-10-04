import express from 'express';
import { fetchPokemonController } from './controller/pokemonController';

const app = express();
const port = 3000;

app.get('/pokemon/:name', fetchPokemonController);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
