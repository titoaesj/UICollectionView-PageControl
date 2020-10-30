//
//  ItemCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by titoaesj on 29/10/20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(index: Int) {
        self.backgroundColor = UIColor.random
    }

}
