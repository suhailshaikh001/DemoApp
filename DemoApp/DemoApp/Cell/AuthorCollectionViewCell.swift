//
//  authorCollectionViewCell.swift
//  DemoApp
//
//  Created by Suhail Shaikh on 02/03/20.
//  Copyright © 2020 Demo.com. All rights reserved.
//

import UIKit

class AuthorCollectionViewCell: UICollectionViewCell {

    let authorImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = UIImageView.ContentMode.scaleAspectFit
        return imgView
    }()
    
    let authorNameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.heavy)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
        
    }
    
    fileprivate func setupCell(){
        
        self.contentView.addSubview(authorImageView)
        self.contentView.addSubview(authorNameLabel)
        
        //For author Img view
        self.authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        self.authorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.authorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        self.authorImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        
        //For author label
        self.authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        self.authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        self.authorNameLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 7).isActive = true
    }

}
