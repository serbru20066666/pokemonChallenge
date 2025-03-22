//
//  SearchBar.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField(String(localized: "pokemon_search_bar_placeholder"), text: $text)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
