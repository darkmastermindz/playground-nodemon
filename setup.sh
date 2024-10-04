#!/bin/bash

# Exit on error
set -e

# Script to set up Pokémon API app with TypeScript, Webpack, and Axios

# Step 1: Initialize npm project
echo "Initializing npm project..."
npm init -y

# Step 2: Install dependencies
echo "Installing dependencies..."
npm install express axios

# Step 3: Install dev dependencies for TypeScript, Webpack, and Babel
echo "Installing dev dependencies for TypeScript, Webpack, and Babel..."
npm install typescript @types/express @babel/core @babel/preset-env @babel/preset-typescript babel-loader webpack webpack-cli ts-loader nodemon --save-dev

# Step 4: Initialize TypeScript
echo "Initializing TypeScript..."
npx tsc --init

# Step 5: Create project directories
echo "Creating project directories..."
mkdir -p src/controller src/service

# Step 6: Create necessary files
echo "Creating necessary files..."

# Create package.json script for running the server
cat <<EOL > package.json
{
  "name": "pokemon-api-app",
  "version": "1.0.0",
  "description": "A Node.js app using the Pokémon API with TypeScript and Axios",
  "main": "index.js",
  "scripts": {
    "build": "webpack",
    "start": "nodemon dist/bundle.js"
  },
  "dependencies": {
    "axios": "^0.21.1",
    "express": "^4.17.1"
  },
  "devDependencies": {
    "@babel/core": "^7.13.10",
    "@babel/preset-env": "^7.13.12",
    "@babel/preset-typescript": "^7.13.0",
    "babel-loader": "^8.2.2",
    "ts-loader": "^9.1.2",
    "typescript": "^4.2.3",
    "webpack": "^5.27.2",
    "webpack-cli": "^4.5.0",
    "nodemon": "^2.0.7"
  }
}
EOL

# Create Webpack config
cat <<EOL > webpack.config.js
const path = require('path');

module.exports = {
  entry: './src/router.ts',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  target: 'node',
  mode: 'development',
};
EOL

# Create Babel config
cat <<EOL > .babelrc
{
  "presets": ["@babel/preset-env", "@babel/preset-typescript"]
}
EOL

# Create TypeScript config
cat <<EOL > tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "rootDir": "./src",
    "outDir": "./dist",
    "strict": true,
    "esModuleInterop": true
  }
}
EOL

# Create router.ts file
cat <<EOL > src/router.ts
import express from 'express';
import { fetchPokemonController } from './controller/pokemonController';

const app = express();
const port = 3000;

app.get('/pokemon/:name', fetchPokemonController);

app.listen(port, () => {
  console.log(\`Server is running on http://localhost:\${port}\`);
});
EOL

# Create pokemonController.ts file
cat <<EOL > src/controller/pokemonController.ts
import { Request, Response, NextFunction } from 'express';
import { fetchPokemonFromAPI } from '../service/pokemonService';

// Controller to fetch Pokémon details
export function fetchPokemonController(req: Request, res: Response, next: NextFunction) {
    const pokemonName = req.params.name;

    fetchPokemonFromAPI(pokemonName)
        .then((response) => {
            res.set({
                'Content-Type': 'application/json',
                'Custom-Header': 'Pokémon-API',
            });

            res.status(200).json({
                data: response.data,
                status: response.status
            });
        })
        .catch((error) => {
            if (error.response) {
                res.status(error.response.status).json({
                    message: error.message,
                    data: error.response.data
                });
            } else {
                next(error);
            }
        });
}
EOL

# Create pokemonService.ts file
cat <<EOL > src/service/pokemonService.ts
import axios from 'axios';

// Service to fetch Pokémon data from the Pokémon API
export function fetchPokemonFromAPI(pokemonName: string) {
    const apiUrl = \`https://pokeapi.co/api/v2/pokemon/\${pokemonName}\`;

    return axios.get(apiUrl)
        .then((response) => {
            return response;
        })
        .catch((error) => {
            throw error;
        });
}
EOL

# Step 7: Build the project using Webpack
echo "Building the project..."
npm run build

# Step 8: Start the server
echo "Starting the server on http://localhost:3000"
npm start