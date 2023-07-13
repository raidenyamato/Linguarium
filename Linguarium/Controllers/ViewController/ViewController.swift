//
//  ViewController.swift
//  Linguarium
//
//  Created by Raiden Yamato on 28.10.2022.
//

import UIKit

public class ViewController: UIViewController {
    
    var selectedCell: QuestionGroupCell?
    var cellFrame: CGRect?
    
    
    //  MARK: - Outlets
    internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: QuestionGroupCell.identifier)
        }
    }
    
    // MARK: - Properties
    let appSettings = AppSettings.shared
    
     let questionGroupCaretaker = QuestionGroupCaretaker()
    var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }
    var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupCaretaker.selectedQuestionGroup }
        set { questionGroupCaretaker.selectedQuestionGroup = newValue }
    }
    
    // MARK - View Lifecycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPatch = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPatch, animated: animated)
        }
    }
    
    public override func loadView() {
        super.loadView()
        setupTableView()
        view.backgroundColor =  UIColor.white
        setUpNavigation()
        navigationController?.delegate = self
        setupSettingsButton()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        questionGroups.forEach {
            print("\($0.title): " +
              "correctCount \($0.score.correctCount), " +
              "incorrectCount \($0.score.incorrectCount)"
            )
        }
        // Do any additional setup after loading the view.
    }
    
    public override func viewWillLayoutSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK:  Settings Button
    private func setupSettingsButton() {
        let action = #selector(handleSettingsButton(sender:))
        let image = UIImage(named: "ic_settings")!
        let scalledImage = ImageRenderer.render(image: image)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: scalledImage, landscapeImagePhone: nil, style: .plain, target: self, action: action)
    }
    @objc private func handleSettingsButton(sender: UIBarButtonItem) {
        let appSettingsViewController = AppSettingsViewController(style: .plain)
        show(appSettingsViewController, sender: self)
    }
    
    private func setUpNavigation() {
        title = "Words Lists"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 48 / 255,
                                             green: 179 / 255,
                                             blue: 199 / 255,
                                             alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonMethod))
    }
    
    private func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
   // MARK: need to continue
    @objc private func rightBarButtonMethod() {
        let createQuestionGroupVC = CreateQuestionGroupViewController()
        createQuestionGroupVC.delegate = self
        createQuestionGroupVC.modalPresentationStyle = .pageSheet
        createQuestionGroupVC.modalTransitionStyle = .coverVertical
        let toViewController = UINavigationController(rootViewController: createQuestionGroupVC)
        
        present(toViewController, animated: true)
        
    }
}


// MARK: - UIViewControllerTransitioningDelegate     there is now need becose we work via navigation delegate
//extension ViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return FlipPresentAnimationController(originFrame: tableView.frame)
//    }
//}

