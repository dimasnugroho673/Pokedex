//
//  ContentView.swift
//  Pokedex
//
//  Created by Dimas Putro on 25/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {

  @ObservedObject var vm = PokemonViewModel()

  var body: some View {
    NavigationView {
      List(vm.pokemons?.results ?? [], id: \.url) { pokemon in
        HStack {
          WebImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"))
            .resizable()
            .frame(width: 60, height: 60)
            .scaledToFill()
            .onAppear {
              vm.fetchDetail(url: pokemon.url)
            }

          Text(pokemon.name.capitalized)
        }
      }
      .navigationTitle("Pokedex")
      .onAppear {
        vm.fetchPokemons()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
