//
//  LabelCell.swift
//  Memory Game
//
//  Created by AndriiPp on 2/26/19.
//  Copyright © 2019 AndriiPp. All rights reserved.
//
import UIKit

class LabelCell: UICollectionViewCell {
    @IBOutlet var cardImageView: UIImageView!
    
    func setImage(_ name: String) {
        let image : String = name.characters.count > 0 ? "Card-\(name)" :  "Card-Bg";
        self.cardImageView.image = UIImage(named:image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        
    }
}
