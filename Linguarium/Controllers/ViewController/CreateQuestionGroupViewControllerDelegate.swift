//
//  CreateQuestionGroupViewControllerDelegate.swift
//  Linguarium
//
//  Created by Raiden Yamato on 30.04.2023.
//

import UIKit


extension ViewController: CreateQuestionGroupViewControllerDelegate {
    public func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController,
                                             created questionGroup: QuestionGroup) {
        
        questionGroupCaretaker.questionGroups.append(questionGroup)
        try? questionGroupCaretaker.save()
        
        dismiss(animated: true)
        tableView.reloadData()
    }
    
    
}
