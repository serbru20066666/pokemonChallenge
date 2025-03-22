//
//  PokemonService.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import Foundation
import Combine
import PokeNetworkingCore

protocol PokemonServiceProtocol {
    func fetchPokemonList() -> AnyPublisher<[Pokemon], Error>
}

private let url = "https://pokeapi.co/api/v2/pokemon?limit=50"

class PokemonService: PokemonServiceProtocol {
    private let networker: NetworkerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }

    func fetchPokemonList() -> AnyPublisher<[Pokemon], Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return networker.get(type: PokemonListResponse.self, url: url, headers: [:])
            .flatMap { response in
                Publishers.MergeMany(response.results.map { self.fetchPokemonDetail(url: $0.url) })
                    .collect()
            }
            .eraseToAnyPublisher()
    }

    private func fetchPokemonDetail(url: String) -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return networker.get(type: Pokemon.self, url: url, headers: [:])
            .eraseToAnyPublisher()
    }

}
