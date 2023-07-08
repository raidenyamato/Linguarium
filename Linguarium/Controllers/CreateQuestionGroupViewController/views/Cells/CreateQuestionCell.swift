//
//  CreateQuestionCell.swift
//  Linguarium
//
//  Created by Raiden Yamato on 30.04.2023.
//

import UIKit

// MARK: - CreateQuestionCellDelegate
public protocol CreateQuesitonCellDelegate {
    func createQuesitonCell(_ cell: CreateQuesitonCell, answerTextDidChange text: String)
    func createQuesitonCell(_ cell: CreateQuesitonCell, hintTextDidChange text: String)
    func createQuesitonCell(_ cell: CreateQuesitonCell, promptTextDidChange text: String)
}

// MARK: - CreateQuestionCell
public class CreateQuesitonCell: UICollectionViewCell {
    
    public var delegate: CreateQuesitonCellDelegate?
    
    public var indexLabel: UILabel!
    public var promptTextField: UITextField!
    public var hintTextField: UITextField!
    public var answerTextField: UITextField!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
      //  contentView.addSubview(indexLabel)
        
        // stack view
         let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 25, leading: 5, bottom: 10, trailing: 5)
        
        // text fields
        indexLabel = {
            let label = UILabel(frame: CGRect(x: 5, y: 2, width: 200, height: 20))
            return label
        }()
        
        promptTextField = TextFieldWithPadding(delegate: self, placeHolder: "Prompt")
        hintTextField = TextFieldWithPadding(delegate: self, placeHolder: "Hint (optional)")
        answerTextField = TextFieldWithPadding(delegate: self, placeHolder: "Answer")
        
       
        
       
        stackView.addArrangedSubview(promptTextField)
        stackView.addArrangedSubview(hintTextField)
        stackView.addArrangedSubview(answerTextField)
        
        contentView.addSubview(stackView)
        contentView.addSubview(indexLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // add target-actions to text fields
        promptTextField.addTarget(self, action: #selector(promptTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        hintTextField.addTarget(self, action: #selector(hintTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        answerTextField.addTarget(self, action: #selector(answerTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
}

// MARK: - Actions
extension CreateQuesitonCell {
    @objc public func answerTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuesitonCell(self, answerTextDidChange: textField.text!)
    }
    @objc public func hintTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuesitonCell(self, hintTextDidChange: textField.text!)
    }
    @objc public func promptTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuesitonCell(self, promptTextDidChange: textField.text!)
    }
}


// MARK: - UITextFieldDelegate
extension CreateQuesitonCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
