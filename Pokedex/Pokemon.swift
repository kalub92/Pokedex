//
//  Pokemon.swift
//  Pokedex
//
//  Created by Caleb Stultz on 3/13/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexid: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexid: Int {
        return _pokedexid
    }
    
    init(name: String, pokedexid: Int) {
        self._name = name
        self._pokedexid = pokedexid
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexid)/"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {

                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                            
                        }
                        
                    } else {
                        self._type = ""
                    }
                    print(self._type)
                }
                
                print(self._height)
                print(self._weight)
                print(self._defense)
                print(self._attack)
                
            }
        }
    }
}