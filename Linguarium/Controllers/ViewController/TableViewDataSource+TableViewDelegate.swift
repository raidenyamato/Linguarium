//
//  ViewController+TableView.swift
//  Linguarium
//
//  Created by Raiden Yamato on 15.02.2023.
//

import UIKit


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionGroupCell.identifier, for: indexPath) as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.configure(questionGroup: questionGroup)
        
        cell.groupItem?.percentage = String(format: "%.0f %%", round(100 * questionGroup.score.runningPercentage))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
 
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        let questionViewController = QuestionViewController()
        questionViewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
        questionViewController.delegate = self
      //  questionViewController.transitioningDelegate = self  // maybe not here
        selectedCell = tableView.cellForRow(at: indexPath) as? QuestionGroupCell
        cellFrame = tableView.rectForRow(at: indexPath)
        navigationController?.pushViewController(questionViewController, animated: true)
        return indexPath
    }

    
}
