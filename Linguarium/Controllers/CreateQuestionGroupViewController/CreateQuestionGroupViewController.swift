//
//  CreateQuestionGroupViewControllerDelegate.swift
//  Linguarium
//
//  Created by Raiden Yamato on 02.03.2023.
//

import UIKit

public protocol CreateQuestionGroupViewControllerDelegate: AnyObject {
    func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController)
    func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup)
}

public class CreateQuestionGroupViewController: UITableViewController {

    
    var collectionView: CQCollectionView! 
    public weak var delegate: CreateQuestionGroupViewControllerDelegate!
    public let questionGroupBuilder = QuestionGroupBuilder()
    
    
    public override func loadView() {
        self.view = VCCustomView()
        
        print(view!) // CustomView
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setupCollectionView()
        
    }
    
    override public func viewWillLayoutSubviews() {
        collectionView.frame = UIScreen.main.bounds
    }
    
    private func setupCollectionView() {
        collectionView = CQCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: configureCollectionLayout(), questionGroupBuilder: questionGroupBuilder)
        view.addSubview(collectionView)
    }
    
            
    private func setUpNavigation() {
        title = "Words Lists"
        self.navigationController?.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 48 / 255,
                                             green: 179 / 255,
                                             blue: 199 / 255,
                                             alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        let cancelAction = #selector(cancelPressed(sender:))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: cancelAction)
        
        let saveAction = #selector(savePressed(sender:))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: saveAction)
    }

   
    @objc private func cancelPressed(sender: Any) {
        delegate?.createQuestionGroupViewControllerDidCancel(self)
    }
    
    @objc private func savePressed(sender: Any) {
        do { let questionGroup = try questionGroupBuilder.build()
            delegate?.createQuestionGroupViewController(self, created: questionGroup)
        } catch {
            displayMissingInputsAlert()
        }
    }
    
    public func displayMissingInputsAlert() {
        let alert = UIAlertController(title: "Missing Inputs",
                                      message: "Please provide all non-optional values",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}



