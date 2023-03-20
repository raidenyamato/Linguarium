//
//  QuestionView.swift
//  Linguarium
//
//  Created by Raiden Yamato on 20.12.2022.
//

import UIKit

public class QuestionView: UIView {
    public var answerlabel: UILabel!
    public var correctCountLabel: UILabel!
    public var incorrectCountLabel: UILabel!
    public var promptlabel: UILabel!
    public var hintLabel: UILabel!
    var redButton: UIButton!
    var greenButton: UIButton!
    
    weak var viewController: QuestionViewController?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createSubViews() {
        promptlabel = UILabel()
        hintLabel = UILabel()
        answerlabel = UILabel()
        
        redButton = UIButton()
        greenButton = UIButton()
        correctCountLabel = UILabel()
        incorrectCountLabel = UILabel()
        
        
        promptlabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        answerlabel.translatesAutoresizingMaskIntoConstraints = false
        redButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        incorrectCountLabel.translatesAutoresizingMaskIntoConstraints = false
        correctCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        promptlabel.text = "PROMPT"
        promptlabel.numberOfLines = 0
        promptlabel.backgroundColor = .green
        promptlabel.font = UIFont.systemFont(ofSize: 50)
        promptlabel.textAlignment = .center
        addSubview(promptlabel)
        
        hintLabel.text = "Hint"
        hintLabel.numberOfLines = 0
        hintLabel.backgroundColor = .green
        hintLabel.font = UIFont.systemFont(ofSize: 24)
        promptlabel.textAlignment = .center
        addSubview(hintLabel)
        
        answerlabel.text = "Answer"
        answerlabel.numberOfLines = 0
        answerlabel.backgroundColor = .green
        answerlabel.font = UIFont.systemFont(ofSize: 48)
        answerlabel.textAlignment = .center
        addSubview(answerlabel)
        
        //need to continue
        //greenButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        let scaledRedCircleImage = ImageRenderer.render(image: UIImage(named: "ic_circle_x")!)
        redButton.setImage(scaledRedCircleImage, for: .normal)
        redButton.addTarget(self, action:#selector(handleAnswer), for: .touchUpInside)
        addSubview(redButton)
        
        
        let scaleGreenCircleImage = ImageRenderer.render(image: UIImage(named: "ic_circle_check")!)
        greenButton.setImage(scaleGreenCircleImage, for: .normal)
        greenButton.addTarget(self, action:#selector(handleAnswer), for: .touchUpInside)
        addSubview(greenButton)
        
        incorrectCountLabel.text = "0"
        incorrectCountLabel.textColor = .red
        incorrectCountLabel.font = UIFont.systemFont(ofSize: 32)
        incorrectCountLabel.textAlignment = .center
        addSubview(incorrectCountLabel)
        
        correctCountLabel.text = "0"
        correctCountLabel.textColor = .green
        correctCountLabel.font = UIFont.systemFont(ofSize: 32)
        correctCountLabel.textAlignment = .center
        addSubview(correctCountLabel)
        
        NSLayoutConstraint.activate([
            promptlabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            promptlabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            promptlabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor),
            promptlabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor),
       
            hintLabel.topAnchor.constraint(equalTo: promptlabel.bottomAnchor, constant: 8),
            hintLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            hintLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor),
            hintLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor),

            answerlabel.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 50),
            answerlabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            answerlabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor),
            answerlabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor),
            
           // greenButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            redButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            redButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -160),
            
            greenButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            greenButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -160),
        
            incorrectCountLabel.centerXAnchor.constraint(equalTo: redButton.centerXAnchor),
            incorrectCountLabel.bottomAnchor.constraint(equalTo: redButton.topAnchor, constant: -8),
            
            correctCountLabel.centerXAnchor.constraint(equalTo: greenButton.centerXAnchor),
            correctCountLabel.bottomAnchor.constraint(equalTo: greenButton.topAnchor, constant: -8)
        ])
    }
    
    @objc func handleAnswer(_ button: UIButton){
        switch button{
        case greenButton:
            viewController!.handleCorrect()
        case redButton:
            viewController!.handleIncorrect()
        default:
            return
        }
    }
    
    
    
}
