//
//  QuestionViewController.swift
//  Linguarium
//
//  Created by Raiden Yamato on 20.12.2022.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionStrategy: QuestionStrategy,
                                at questionIndex: Int)
    func questionViewController(
        _ viewController: QuestionViewController,
        didComplete questionStrategy: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?
    
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
    
    
    
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    public var questionIndex = 0
    
    //TODO: mb need it's two propetries too
    public var correctCount = 0
    public var incorrectCount = 0
    
    //    public var questionView: QuestionView!
    
    public var questionView: QuestionView! {
        didSet {
            questionView.viewController = self
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        addQuestionView()
        showQuestion()
        istallTapQuestionViewGestureRecognizer()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        let scaledImage = ImageRenderer.render(image: image!)
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: scaledImage, landscapeImagePhone: nil, style: .plain, target: self, action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem)
    {
        delegate?.questionViewController(self, didCancel: questionStrategy, at: questionIndex)
    }
    private func addQuestionView() {
        questionView = QuestionView()
        questionView.backgroundColor = .cyan
        view.addSubview(questionView)
        questionView.frame = view.bounds
        istallTapQuestionViewGestureRecognizer()
    }
    
    private func istallTapQuestionViewGestureRecognizer(){
        let tapQuestionViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleAnswerLabels))
        questionView.isUserInteractionEnabled = true
        questionView.addGestureRecognizer(tapQuestionViewGestureRecognizer)
    }
    
    @objc func toggleAnswerLabels(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            questionView.answerlabel.isHidden = !questionView.answerlabel.isHidden
            questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
        }
    }
    
    private func showQuestion() {
        let question = questionStrategy.currentQuestion()
        
        questionView.answerlabel.text = question.answer
        questionView.promptlabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerlabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()    }
    
    
    func handleCorrect() {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    func handleIncorrect() {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self,
                                             didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
}


