//
//  PokemonService.swift
//  Pokedex
//
//  Created by Dimas Putro on 25/05/22.
//

import Combine
import Foundation

struct PokemonService {
  static let shared = PokemonService()

  var pokemonListSubject = PassthroughSubject<Pokemon, Never>()
  var pokemonDetailSubject = PassthroughSubject<PokemonDetail, Never>()

  func getPokemons() {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }

    let task = URLSession.shared.dataTask(with: url) { (data, _ ,error) in
      if let error = error {
        print("DEBUG: Failed fetch data with error \(error.localizedDescription)")
      }

      if let data = data {
        do {
          let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

          self.pokemonListSubject.send(pokemon)
        } catch {
          print("DEBUG: Failed decode data with error \(error.localizedDescription)")
        }
      }
    }
    task.resume()
  }

  func getDetail(url: String) {
    guard let url = URL(string: url) else { return }

    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error {
        print("DEBUG: Failed fetch data with error \(error.localizedDescription)")
      }

      if let data = data {
        do {
          let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)

          pokemonDetailSubject.send(detail)
        } catch {
          print("DEBUG: Failed decode data with error \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }
}
