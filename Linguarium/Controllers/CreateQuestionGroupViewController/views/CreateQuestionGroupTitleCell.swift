//
//  CreateQuestionGroupTitleCell.swift
//  Linguarium
//
//  Created by Raiden Yamato on 24.04.2023.
//

import UIKit

// MARK: - CreateQuestionCellDelegate
public protocol CreateQuestionGroupTitleCellDelegate {
    func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell, titleTextDidChange text: String)
}

// MARK: - CreateQuestionGroupTitleCell
public class CreateQuestionGroupTitleCell: UITableViewCell {
    public var delegate: CreateQuestionGroupTitleCellDelegate?
    
    public var titleTextField: UITextField!
}

// MARK: - Actions
extension CreateQuestionGroupTitleCell {
    public func titleTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionGroupTitleCell(self, titleTextDidChange: textField.text!)
    }
}



