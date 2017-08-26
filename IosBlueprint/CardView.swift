//
//  CardView.swift
//
//  Created by ibrahim on 1/24/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    func setupCard(){
        // setup content
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.masksToBounds = true
    }
}


class CardView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    func setupCard(){
        // setup content
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.masksToBounds = true
    }
}



class TextCardView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    func setupCard(){
        // setup content
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}

class ButtonCardView: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    func setupCard(){
        // setup content
        self.layer.cornerRadius = 2.5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}

class ImageCardView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    func setupCard(){
        // setup content
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}


