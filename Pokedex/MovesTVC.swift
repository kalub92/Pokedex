//
//  MovesTVC.swift
//  Pokedex
//
//  Created by Caleb Stultz on 3/17/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class MovesTVC: UITableViewCell {
    
    @IBOutlet weak var attackName: UILabel!
    @IBOutlet weak var attackDamage: UILabel!
    @IBOutlet weak var attackAccuracy: UILabel!
    @IBOutlet weak var ppPoints: UILabel!
    @IBOutlet weak var attackDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(move: Pokemon) {
        attackName.text = move.attackName
        attackDamage.text = move.attackPwr
        attackAccuracy.text = move.attackAccuracy
        ppPoints.text = move.ppPoints
        attackDescription.text = move.attackDescription
    }
    
}
