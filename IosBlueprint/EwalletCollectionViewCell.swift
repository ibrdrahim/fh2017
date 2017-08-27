//
//  EwalletCollectionViewCell.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class EwalletCollectionViewCell: UICollectionViewCell {

    @IBOutlet var radioBtn: UIImageView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var selectBtn: UIButton!
    
    var isActive = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
