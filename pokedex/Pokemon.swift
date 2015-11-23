//
//  Pokemon.swift
//  pokedex
//
//  Created by aloha kids on 11/12/15.
//  Copyright © 2015 Richard. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    // define internal attributes
    private var _name: String!
    private var _pokeDexId: Int!
    private var _pokeDescription: String!
    private var _pokeType: String!
    private var _pokeDefense: String!
    private var _pokeHeight: String!
    private var _pokeWeight: String!
    private var _pokeAttack: String!
    private var _pokeNextEvoTxt: String!
    private var _pokeNextEvoId: String!
    private var _pokeNextEvoLvl: String!
    private var _pokemonUrl: String!
    private var _pokeMove1: String!
    private var _pokeMove2: String!
    
    // define external variables that connect with internal attributes. 
    // this is how we hide the attributes from outside so it is harder to 
    // make internal changes unless handler is called.
    // these are similar to "GET" request
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var pokedexId: Int {
        return _pokeDexId
    }
    var pokeDescription: String {
        if _pokeDescription == nil {
            _pokeDescription = ""
        }
        return _pokeDescription
    }
    var pokeType: String {
        if _pokeType == nil {
            _pokeType = ""
        }
        return _pokeType
    }
    var pokeDefense: String {
        if _pokeDefense == nil {
            _pokeDefense = ""
        }
        return _pokeDefense
    }
    var pokeHeight: String {
        if _pokeHeight == nil {
            _pokeHeight = ""
        }
        return _pokeHeight
    }
    var pokeWeight: String {
        if _pokeWeight == nil {
            _pokeWeight = ""
        }
        return _pokeWeight
    }
    var pokeAttack: String {
        if _pokeAttack == nil {
            _pokeAttack = ""
        }
        return _pokeAttack
    }
    var pokeNextEvoTxt: String {
        if _pokeNextEvoTxt == nil {
            _pokeNextEvoTxt = ""
        }
        return _pokeNextEvoTxt
    }
    var pokeNextEvoId: String {
        if _pokeNextEvoId == nil {
            _pokeNextEvoId = ""
        }
        return _pokeNextEvoId
    }
    var pokeNextEvoLvl: String {
        if _pokeNextEvoLvl == nil {
            _pokeNextEvoLvl = ""
        }
        return _pokeNextEvoLvl
    }
    var pokeMove1: String {
        if _pokeMove1 == nil {
            _pokeMove1 = ""
        }
        return _pokeMove1
    }
    var pokeMove2: String {
        if _pokeMove2 == nil {
            _pokeMove2 = ""
        }
        return _pokeMove2
    }
    
    // initializer: preparing the object
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokeDexId = pokedexId
        
        self._pokemonUrl = "\(URL_Base)\(URL_Pokemon)\(self._pokeDexId)/"
        
    }
    
    func downloadPokemonDetails(completed: downloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            //print(result.value.debugDescription)
            
            // always us "if let" when assigning a variable with parsing information
            // because if by any chance parsing failed, it won't cause the entire 
            // program to crush
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._pokeWeight = weight
                }
                if let height = dict["height"] as? String {
                    self._pokeHeight = height
                }
                if let attack = dict["attack"] as? Int {
                    self._pokeAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._pokeDefense = "\(defense)"
                }
                
                // print(self._pokeWeight)
                // print(self._pokeHeight)
                // print(self._pokeAttack)
                // print(self._pokeDefense)
                
                // to parse a data object, we want to use the combination of "if let" and "where"
                // because it is to make sure we can get something from the object.
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        self._pokeType = type.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let type = types[x]["name"] {
                                
                                // attach the next type to the string
                                
                                self._pokeType! += "/\(type.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._pokeType = ""
                }
                
                // print(self._pokeType)
                
                if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                    
                    
                    //self._pokeMove1 = moves[0]["name"]
                    
                    if let move1 = moves[0]["name"] as? String{
                        self._pokeMove1 = move1
                        print(move1)
                    }
                    if moves.count > 1 {
                        if let move2 = moves[1]["name"] as? String{
                            self._pokeMove2 = move2
                        }
                    }
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let descUrl = descArr[0]["resource_uri"] {
                        let deUrl = NSURL(string: "\(URL_Base)\(descUrl)")!
                        
                        // the Alamofire http request is async func, so while waiting for the data,
                        // the program will continue to execute the code after this entire section
                        Alamofire.request(.GET, deUrl).responseJSON { response in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._pokeDescription = description
                                    // print(self._pokeDescription)
                                }
                            }
                            
                            completed()
                        }
                    }
                } else {
                    self._pokeDescription = ""
                }
                // keep in mind that while waiting for the Alamofire http request to complete, 
                // the program will continue to execute the code after here.
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let evoTo = evolutions[0]["to"] as? String {
                        
                        // can't support mega pokemon right now but api still has mega data
                        // this is to make sure the name don't have "mega" string
                        if evoTo.rangeOfString("mega") == nil {
                            if let evoToUri = evolutions[0]["resource_uri"] as? String {
                                
                                // the sample uri looks like "/api/v1/pokemon/123/"
                                // the following func is to remove the string other than the ID
                                // we need to replace the part before and after the ID with empty string
                                let tempStr = evoToUri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let tempNum = tempStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._pokeNextEvoId = tempNum
                                self._pokeNextEvoTxt = evoTo
                                
                                if let tempLvl = evolutions[0]["level"] as? Int {
                                    self._pokeNextEvoLvl = "\(tempLvl)"
                                }
                            }
                        }
                    }
                }
                
            }
            //completed()
        }
    }
}