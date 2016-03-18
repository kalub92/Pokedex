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
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonURL: String!
    private var _movesURL: String!
    private var _attackName: String!
    private var _movesID: String!
    private var _attackDescription: String!
    private var _attackAccuracy: String!
    private var _attackPwr: String!
    private var _ppPoints: String!
    
    var ppPoints: String {
        if _ppPoints == nil {
            _ppPoints = ""
        }
        return _ppPoints
    }

    var attackPwr: String {
        if _attackPwr == nil {
            _attackPwr = ""
        }
        return _attackPwr
    }
    
    var attackAccuracy: String {
        if _attackAccuracy == nil {
            _attackAccuracy = ""
        }
        return _attackAccuracy
    }
    
    var attackDescription: String {
        if _attackDescription == nil {
            _attackDescription = ""
        }
        return _attackDescription
    }

    var movesURL: String {
        if _movesURL == nil {
            _movesURL = ""
        }
        return _movesURL
    }

    var movesID: String {
        if _movesID == nil {
            _movesID = ""
        }
        return _movesID
    }
    
    var attackName: String {
        if _attackName == nil {
            _attackName = ""
        }
        return _attackName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
                _nextEvolutionLvl = ""
            }
            return _nextEvolutionLvl
        }
    
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
        _movesURL = "\(URL_BASE)\(URL_MOVES)\(self._movesID)/"
        
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
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                        
                        if let url = descArr[0]["resource_uri"] {
                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                           
                            Alamofire.request(.GET, nsurl).responseJSON { response in
                                
                                let descResult =  response.result
                                if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                    
                                    if let description = descDict["description"] as? String {
                                        let newStr = description.stringByReplacingOccurrencesOfString("POKMON", withString: "Pokémon")
                                        self._description = newStr
                                    }
                                }
                                completed()
                            }
                        }
                        
                    } else {
                        self._description = ""
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                        
                        if let to = evolutions[0]["to"] as? String {
                            
                            //Can't support Mega Pokémon right now, but API still has Mega data
                            if to.rangeOfString("mega") == nil {
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvolutionID = num
                                    self._nextEvolutionText = to
                                    
                                    if let lvl = evolutions[0]["level"] as? Int {
                                        self._nextEvolutionLvl = "\(lvl)"
                                    }
                                }
                            }
                        }
                    }
                    
                    if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                                                
                            if let nameofAttack = moves[0]["name"] as? String {
                                
                                self._attackName = nameofAttack
                                print("Attack Name: \(self._attackName)")
                                
                                if let url = moves[0]["resource_uri"] as? String {
                                    let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                                    
                                    Alamofire.request(.GET, nsurl).responseJSON { response in
                                        
                                    let attackDetails =  response.result
                                        
                                    if let dict = attackDetails.value as? Dictionary<String, AnyObject> {
                                            
                                        if let desc = dict["description"] as? String {
                                            self._attackDescription = desc
                                            print("Description: \(self._attackDescription)")
                                        }
                                        
                                        if let accuracy = dict["accuracy"] as? Int {
                                            self._attackAccuracy = "\(accuracy)"
                                            print("Accuracy: \(self._attackAccuracy)")
                                        }
                                            
                                        if let power = dict["power"] as? Int {
                                            self._attackPwr = "\(power)"
                                            print("Power: \(self._attackPwr)")
                                        }
                                            
                                        if let pp = dict["pp"] as? Int {
                                            self._ppPoints = "\(pp)"
                                            print("PP: \(self._ppPoints)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}