//
//  ContentView.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)

                if viewModel.isLoading {
                    ProgressView(String(localized: "loading_message"))
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(viewModel.filteredPokemon) { pokemon in
                        HStack {
                            AsyncImage(url: URL(string: pokemon.imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }

                            Text(pokemon.name.capitalized)
                                .font(.headline)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle(String(localized: "pokemon_list_title"))
        }
    }
}

#Preview {
    PokemonListView()
}
