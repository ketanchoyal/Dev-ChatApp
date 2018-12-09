//
//  AttributedTextColor.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 09/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

@IBDesignable
class AttributedTextColor: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    @IBInspectable var placeholderColor : UIColor = smackPurplePlaceholder {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var placeholderText : String = " " {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    func setupView() {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
    }

}
