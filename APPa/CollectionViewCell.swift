//
//  CollectionViewCell.swift
//  APPa
//
//  Created on 14/05/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var infoLbl: UILabel!
    
    func configure(with information: String){
        infoLbl.text = information
    }
    
}
