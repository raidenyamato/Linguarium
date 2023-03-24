//
//  UITableViewDataSource.swift
//  Linguarium
//
//  Created by Raiden Yamato on 12.03.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension AppSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.selectionStyle = .none
        cell.textLabel?.text = questionStrategyType.title()
        if appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}



// MARK: - UITableViewDelegate
extension AppSettingsViewController {
    
    public override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
    
}
