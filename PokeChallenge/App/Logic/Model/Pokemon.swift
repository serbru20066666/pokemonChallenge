//
//  Pokemon.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import Foundation

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
    }

    enum SpritesKeys: String, CodingKey {
        case other
    }

    enum OtherKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }

    enum OfficialArtworkKeys: String, CodingKey {
        case frontDefault = "front_default"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        let spritesContainer = try container.nestedContainer(keyedBy: SpritesKeys.self, forKey: .sprites)
        let otherContainer = try spritesContainer.nestedContainer(keyedBy: OtherKeys.self, forKey: .other)
        let officialArtworkContainer = try otherContainer.nestedContainer(keyedBy: OfficialArtworkKeys.self, forKey: .officialArtwork)

        imageUrl = try officialArtworkContainer.decode(String.self, forKey: .frontDefault)
    }
}


struct PokemonListResponse: Decodable {
    let results: [PokemonResult]
}

struct PokemonResult: Decodable {
    let name: String
    let url: String
}

