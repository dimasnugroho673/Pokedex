//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Dimas Putro on 25/05/22.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {
  @Published var isLoading: Bool = true
  @Published var pokemons: Pokemon?
  @Published var pokemonDetail: PokemonDetail?

  private var observer = Set<AnyCancellable>()

  func fetchPokemons() {
    PokemonService.shared.getPokemons()

    PokemonService.shared.pokemonListSubject
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] data in
        guard let self = self else { return }

        self.isLoading = false
        self.pokemons = data
      })
      .store(in: &observer)
  }

  func fetchDetail(url: String) {
    PokemonService.shared.getDetail(url: url)

    PokemonService.shared.pokemonDetailSubject
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] data in
        guard let self = self else { return }

        self.pokemonDetail = data
      })
      .store(in: &observer)
  }
}
