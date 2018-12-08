//
//  AvatarCell.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 09/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(index : Int, type : AvatarType) {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
