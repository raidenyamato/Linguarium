//
//  ViewController+QuestionViewControllerDelegate.swift
//  Linguarium
//
//  Created by Raiden Yamato on 07.03.2023.
//

import Foundation

extension ViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: QuestionViewController,
                                       didCancel questionStrategy: QuestionStrategy,
                                       at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ viewController: QuestionViewController,
                                       didComplete questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
   
}
