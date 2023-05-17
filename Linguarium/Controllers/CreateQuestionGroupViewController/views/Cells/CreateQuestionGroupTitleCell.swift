//
//  CreateQuestionGroupTitleCell.swift
//  Linguarium
//
//  Created by Raiden Yamato on 30.04.2023.
//

import UIKit

public protocol CreateQuestionGroupTitleCellDelegate {
    func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell, titlTextDidChange text: String)
}


public class CreateQuestionGroupTitleCell: UICollectionViewCell {
    public var delegate: CreateQuestionGroupTitleCellDelegate?
    
    private var titleTextField: TextFieldWithPadding!
    
    
    
    public let titleLabel: UILabel  = {
        let titleLabel = UILabel(frame: CGRect(x: 3, y: 2, width: 200, height: 20))
        titleLabel.text = "New group title"
        return titleLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        titleTextField = TextFieldWithPadding(delegate: self,
                                              placeHolder: "Title",
                                              frame: CGRect(x: 10, y: 25, width: contentView.bounds.width - 20, height: contentView.bounds.height - 35))
        contentView.addSubview(titleTextField)
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        contentView.addSubview(titleLabel)
    }
    
    
    
}


// MARK: - Actions
extension CreateQuestionGroupTitleCell {
   @objc public func titleTextFieldDidChange(_ textfield: UITextField) {
       print("titleTextFieldDidChange \(textfield.text!)")
        delegate?.createQuestionGroupTitleCell(self, titlTextDidChange: textfield.text!)
    }
}


// MARK: - UITextFieldDelegate
extension CreateQuestionGroupTitleCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("textFieldShouldReturn false")
        return false
    }
}
