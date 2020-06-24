//
//  PhotosCollectionViewCell.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
  private let titleLabel: UILabel
  private let imageView: UIImageView
  
  override init(frame: CGRect) {
    titleLabel = UILabel(frame: .zero)
    imageView = UIImageView(frame: .zero)
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    imageView.image = UIImage(named: "placeholder")
  }

  func setCellImage(image: UIImage) {
    imageView.image = image
  }

  func setCellTitle(title: String) {
    titleLabel.text = title
  }
  
  private func setupCell() {
    titleLabel.numberOfLines = 1
    titleLabel.lineBreakMode = .byTruncatingTail
    titleLabel.font = UIFont(name: "HelveticaNeue", size: 11)
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    
    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(imageView)
    
    self.contentView.bringSubviewToFront(titleLabel)
    titleLabel.isUserInteractionEnabled = true

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2),

      imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
    ])
  }
}
