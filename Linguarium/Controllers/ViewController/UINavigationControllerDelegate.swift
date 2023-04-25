//
//  File.swift
//  Linguarium
//
//  Created by Raiden Yamato on 16.02.2023.
//

import UIKit


// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
    
   
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        

        
        if toVC is QuestionViewController {
            switch operation {
            case .push:
                return FlipPresentAnimationController(originFrame: cellFrame!)
            case .pop:
                return nil
            default:
                return nil
            }
        }
        return nil
    }
    
    
    
}

