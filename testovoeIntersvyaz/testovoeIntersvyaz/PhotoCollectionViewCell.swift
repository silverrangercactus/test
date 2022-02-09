//
//  PhotoCollectionViewCell.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 08.02.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    var photoMy: LazyLoadView = {
        let photoMy = LazyLoadView()
        photoMy.layer.cornerRadius = 6
        return photoMy
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(photoMy)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        photoMy.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            photoMy.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoMy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoMy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoMy.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoMy.heightAnchor.constraint(equalTo: photoMy.widthAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
