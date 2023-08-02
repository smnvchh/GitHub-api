//
//  RepositoryCell.swift
//  GitHub project
//
//  Created by Yury Semenovich on 1.08.23.
//

import UIKit

final class RepositoryCell: UICollectionViewCell {
    
    private var label = UILabel()
    private var url = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(url)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(repository: Repository) {
        label.text = repository.name
        url.text = repository.owner.url
    }
    
    func layout() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        url.translatesAutoresizingMaskIntoConstraints = false
        url.topAnchor.constraint(equalTo: label.topAnchor, constant: 0.5).isActive = true
        url.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        url.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        url.heightAnchor.constraint(equalToConstant: 18).isActive = true

        
    }
}
