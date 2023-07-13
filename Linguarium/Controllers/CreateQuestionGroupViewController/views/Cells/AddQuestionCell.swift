//
//  AddQuestionCell.swift
//  Linguarium
//
//  Created by Raiden Yamato on 28.05.2023.
//

import UIKit





import UIKit




public class AddQuestionCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "ic_circle_plus"))
        return imageView
    }()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubview(imageView)
        imageView.center = contentView.center
        
    }
    
    
    
}
