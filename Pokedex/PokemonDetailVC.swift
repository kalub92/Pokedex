//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Caleb Stultz on 3/13/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Bio Info
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var movesView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    var pokemonMoves = [Pokemon]()
    var move = MovesTVC()
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexid)")
        mainImg.image = img
        currentEvoImg.image = img
        movesView.hidden = true
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexLbl.text = "\(pokemon.pokedexid)"
        baseAttackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionID == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionID)
            
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            
            evoLbl.text = str
            
        }
        
        if pokemon.type == "" {
            typeLbl.text = "No Defined Type"
        }
        
        tableView.reloadData()

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovesTVC") as? MovesTVC {
            let move = pokemonMoves[indexPath.row]
            cell.configureCell(move)
            return cell
        } else {
            return MovesTVC()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Figure out how to display TVC's based on number of attacks found in PokéAPI
        return pokemonMoves.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func segmentedControllerAction(sender: AnyObject) {
        if(segmentedControl.selectedSegmentIndex == 0) {
            movesView.hidden = true
        } else {
            movesView.hidden = false
        }
    }
    
}
