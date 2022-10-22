//
//  CollectionViewCell.swift
//  BodyDetection
//
//  Created by Lucas Yim on 10/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var image:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        contentView.backgroundColor = .red
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        
        
        ])
    }
    
    
    func configure(imageString: String){
        self.image.image = UIImage(named: ( imageString) )
        print(imageString)
    }
    
    
    
    
    
}
