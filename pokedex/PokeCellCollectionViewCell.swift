//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by aloha kids on 11/18/15.
//  Copyright © 2015 Richard. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var _pokemon: Pokemon!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self._pokemon = pokemon
        
        
        nameLbl.text = self._pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self._pokemon.pokedexId)")
        
    }
    
    
}
