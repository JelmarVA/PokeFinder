//
//  PokeCollectionViewCell.swift
//  PokeFinder
//
//  Created by Jelmar Van Aert on 21/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pokeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(name: String){
        
        var id: Int!

        id = pokemon.index(of: name)
      
        self.pokeName.text = name.capitalized
        
        let image = UIImage(named: "\(id + 1)")
        self.imageView.image = image
        
        
    }
}
