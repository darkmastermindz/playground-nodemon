import axios from 'axios';

// Service to fetch Pokémon data from the Pokémon API
export function fetchPokemonFromAPI(pokemonName: string) {
    const apiUrl = `https://pokeapi.co/api/v2/pokemon/${pokemonName}`;

    return axios.get(apiUrl)
        .then((response) => {
            return response;
        })
        .catch((error) => {
            throw error;
        });
}
