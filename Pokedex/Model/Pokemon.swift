//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dimas Putro on 25/05/22.
//

import Foundation

struct Pokemon: Codable {
  let count: Int
  var results: [PokemonResult]
}

struct PokemonResult: Codable {
  let name: String
  let url: String
}

struct PokemonDetail: Codable {
  let name: String
  var sprites: PokemonSprites
}

struct PokemonSprites: Codable {
  var image: String

  enum CodingKeys: String, CodingKey {
    case image = "back_default"
  }
}
