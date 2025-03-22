//
//  PokemonViewModel.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import Combine
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private let service: PokemonServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
        fetchPokemon()
    }

    func fetchPokemon() {
        isLoading = true
        service.fetchPokemonList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error fetching Pokémon: \(error.localizedDescription)")
                }
                self.isLoading = false
            } receiveValue: { [weak self] pokemon in
                self?.pokemonList = pokemon
            }
            .store(in: &cancellables)
    }

    var filteredPokemon: [Pokemon] {
        if searchText.isEmpty {
            return pokemonList
        } else {
            return pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
