//
//  Pokemon.swift
//  pokedex
//
//  Created by aloha kids on 11/12/15.
//  Copyright © 2015 Richard. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeDexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokeDexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokeDexId = pokedexId
    }
}