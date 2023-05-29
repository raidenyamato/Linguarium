//
//  TextFieldWithPadding.swift
//  Linguarium
//
//  Created by Raiden Yamato on 11.05.2023.
//

import UIKit

class TextFieldWithPadding: UITextField {
    
    

    var textPadding = UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5
        )

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    convenience init(delegate: UITextFieldDelegate, placeHolder: String, frame: CGRect = .zero) {
        self.init(frame: .zero)
        self.delegate = delegate
        self.placeholder = placeHolder
        self.frame = frame
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor(red: 48 / 255, green: 179 / 255, blue: 199 / 255, alpha: 0.3).cgColor
        font = .systemFont(ofSize: 22)
        layer.borderWidth = 3
        textAlignment = .left
        contentVerticalAlignment = .center
        contentMode = .scaleToFill
       
    }
    
    
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
    
    
    
    
    
    
}
