import { Request, Response, NextFunction } from 'express';
import { AxiosResponse, AxiosError } from 'axios';
import { fetchPokemonFromAPI } from '../service/pokemonService';

// Controller to fetch Pokémon details
export function fetchPokemonController(req: Request, res: Response, next: NextFunction) {
    const pokemonName = req.params.name;

    fetchPokemonFromAPI(pokemonName)
        .then((response: AxiosResponse<any>) => {
            res.set({
                'Content-Type': 'application/json',
                'Custom-Header': 'Pokémon-API',
            });

            res.status(response.status).json({
                data: response.data,
                status: response.status
            });
        })
        .catch((error: AxiosError) => {
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
