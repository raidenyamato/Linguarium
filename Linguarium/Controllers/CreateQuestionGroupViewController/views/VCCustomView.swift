//
//  VCCustomView.swift
//  Linguarium
//
//  Created by Raiden Yamato on 26.04.2023.
//

import UIKit

final class VCCustomView: UIView {
   // let square: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    convenience init() {
        self.init(frame: .zero)
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createSubViews() {
        backgroundColor = UIColor(red: 1 / 255,
                                  green: 1 / 255,
                                  blue: 1 / 255,
                                  alpha: 0.8)
        
        
       
    }
    
}
