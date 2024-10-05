import axios, { AxiosResponse, AxiosError } from 'axios';

// Service to fetch Pokémon data from the Pokémon API
export function fetchPokemonFromAPI(pokemonName: string): Promise<AxiosResponse<any>> {
    const apiUrl = `https://pokeapi.co/api/v2/pokemon/${pokemonName}`;

    return axios.get(apiUrl)
        .then((response: AxiosResponse<any>) => {
            return response;
        })
        .catch((error: AxiosError) => {
            throw error;
        });
}
