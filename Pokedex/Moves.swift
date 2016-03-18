//
//  Moves.swift
//  Pokedex
//
//  Created by Caleb Stultz on 3/17/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation
import UIKit

class Moves {

private var _attackName: String!
private var _attackDamage: String!
private var _attackAccuracy: String!
private var _ppPoints: String!
private var _attackDescription: String!

var attackName: String {
    return _attackName
}

var attackDamage: String {
    return _attackDamage
}

var attackAccuracy: String {
    return _attackAccuracy
}
    
var ppPoints: String {
    return _ppPoints
}
    
var attackDescription: String {
    return _attackDescription
}
    
init(attackName: String, attackDamage: String, ppPoints: String, attackAccuracy: String, attackDescription: String) {
    self._attackName = attackName
    self._attackDamage = attackDamage
    self._ppPoints = ppPoints
    self._attackAccuracy = attackAccuracy
    self._attackDescription = attackDescription
    }
}