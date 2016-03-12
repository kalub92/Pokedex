//
//  Pokemon.swift
//  Pokedex
//
//  Created by Caleb Stultz on 3/13/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexid: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexid: Int {
        return _pokedexid
    }
    
    init(name: String, pokedexid: Int) {
        self._name = name
        self._pokedexid = pokedexid
    }
    
}