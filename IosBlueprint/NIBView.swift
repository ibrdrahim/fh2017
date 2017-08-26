//
//  NIBView.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import UIKit

protocol NIBViewProtocol:NSObjectProtocol {
    func xibSetup()
    func loadViewFromNib() -> UIView!
}

class NIBView: UIView,NIBViewProtocol {
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        // additional option
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
