//
//  CollectionViewCell2.swift
//  APPa
//
//  Created by Carolina Medina on 14/05/21.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet private weak var infoLbl: UILabel!
    
    func configure(with information: String){
        infoLbl.text = information
    }
    
}
