//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by aloha kids on 11/19/15.
//  Copyright © 2015 Richard. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var mainLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var pokedexIdLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var baseAttackLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    @IBOutlet var evoLbl: UILabel!
    @IBOutlet weak var typeFieldLbl: UILabel!
    @IBOutlet weak var defenseFieldLbl: UILabel!
    
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails { () -> () in
            // () -> () is the only way to call a function when download or an action is completed
            
            // this will be called after download is done
            
            self.mainLbl.text = self.pokemon.pokeDescription
            self.typeLbl.text = self.pokemon.pokeType
            self.defenseLbl.text = self.pokemon.pokeDefense
            self.heightLbl.text = self.pokemon.pokeHeight
            self.weightLbl.text = self.pokemon.pokeWeight
            self.baseAttackLbl.text = self.pokemon.pokeAttack
            
            if self.pokemon.pokeNextEvoId == "" {
                self.evoLbl.text = "No Evolution"
                self.nextEvoImg.hidden = true
            } else {
                self.nextEvoImg.hidden = false
                self.nextEvoImg.image = UIImage(named: "\(self.pokemon.pokeNextEvoId)")
                var str = "Next Evolution: \(self.pokemon.pokeNextEvoTxt)"
                if self.pokemon.pokeNextEvoLvl != "" {
                    str += " - LVL \(self.pokemon.pokeNextEvoLvl)"
                }
                self.evoLbl.text = str
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedChanged(sender: UISegmentedControl) {
        
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            // when bio is selected
            print("bio is selected")
            typeFieldLbl.text = "Type"
            defenseFieldLbl.text = "Defense"
            typeLbl.text = pokemon.pokeType
            defenseLbl.text = pokemon.pokeDefense
            
        case 1:
            print("moves is selected")
            typeFieldLbl.text = "First Move"
            defenseFieldLbl.text = "Second Move"
            
            typeLbl.text = pokemon.pokeMove1
            	defenseLbl.text = pokemon.pokeMove2
            
        default:
            break
        }
    }
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        
    }

    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    //override func didReceiveMemoryWarning() {
    //    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
