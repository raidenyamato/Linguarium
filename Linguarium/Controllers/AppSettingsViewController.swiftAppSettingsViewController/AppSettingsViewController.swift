//
//  AppSettingsViewController.swift
//  Linguarium
//
//  Created by Raiden Yamato on 12.03.2023.
//

import UIKit

public class AppSettingsViewController: UITableViewController {
    // MARK: - Properties
    public let appSettings = AppSettings.shared
    let cellIdentifier = "basicCell"
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "App Settings"
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
}
