//
//  CollectionViewCell.swift
//  D&D
//
//  Created by Carolina Medina on 21/04/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var infoLbl: UILabel!
    
    func configure(with information: String){
        infoLbl.text = information
    }
    
}
