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
    
    // MARK: BLUR EFFECT
    var visualEffectView = UIVisualEffectView() {
        didSet {
            visualEffectView.effect = nil
        }
    }
    
    
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
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
   // MARK: need to continue
    @objc private func rightBarButtonMethod() {
        let addGroupView = UIView(frame: view.bounds)
        //view.addSubview(addGroupView)
       //addGroupView.backgroundColor = UIColor.black
        view.addSubview(visualEffectView)
        UIView.animate(withDuration: 5) {
            self.visualEffectView.effect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        }
    }
}



// MARK: - UIViewControllerTransitioningDelegate     there is now need becose we work via navigation delegate
//extension ViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return FlipPresentAnimationController(originFrame: tableView.frame)
//    }
//}

