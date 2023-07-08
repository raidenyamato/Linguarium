//
//  ImageRenderer.swift
//  Linguarium
//
//  Created by Raiden Yamato on 08.03.2023.
//

import UIKit

public class ImageRenderer {
    
    public static func render(image: UIImage) -> UIImage {
        let image = image
        var scaledImageSize: CGSize
        
        if image == UIImage(named: "ic_menu") {
            scaledImageSize = CGSize(width: 26, height: 18)
        } else if image == UIImage(named: "ic_settings") {
            scaledImageSize = CGSize(width: 26, height: 26)
        }
        else {
            scaledImageSize = CGSize(width: 140, height: 140)
        }
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        return scaledImage
    }
}


