//
//  PokeChallengeTests.swift
//  PokeChallengeTests
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import XCTest
import Combine
@testable import PokeChallenge
import PokeNetworkingCore

@MainActor
final class PokeChallengeTests: XCTestCase {
    var viewModel: PokemonViewModel!
    var service: PokemonService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        service = PokemonService()
        viewModel = PokemonViewModel(service: service)
    }

    override func tearDown() {
        viewModel = nil
        service = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchPokemonSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch Pokémon successfully")

        viewModel.$pokemonList
            .dropFirst()
            .sink { pokemon in
                if !pokemon.isEmpty {
                    XCTAssertGreaterThan(pokemon.count, 0, "Expected Pokémon in the list")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchPokemon()
        await fulfillment(of: [expectation], timeout: 5.0)
    }

    func testFetchPokemonFailure() async {
        let expectation = XCTestExpectation(description: "Fetch Pokémon fails gracefully")

        // Simula un error en la red forzando una URL inválida
        service = PokemonService(networker: NetworkerMockFailure())
        viewModel = PokemonViewModel(service: service)

        viewModel.fetchPokemon()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.viewModel.pokemonList.isEmpty, "Expected Pokémon list to be empty on failure")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5.0)
    }
}


