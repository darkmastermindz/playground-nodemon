import express from 'express';
import { Request, Response, NextFunction } from 'express';
import cors from 'cors';
import { fetchPokemonController } from './controller/pokemonController';

const app = express();
const port = 3000;

app.use(cors)

app.get('/pokemon/:name', fetchPokemonController);
app.get('/', (req: Request, res: Response, next: NextFunction) => {
  res.send('Welcome to the Pokémon API! Use /pokemon/:name to fetch Pokémon data.');
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

export const viteNodeApp = app;
