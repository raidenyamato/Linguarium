//
//  CreateQuestionGroupViewControllerDelegate.swift
//  Linguarium
//
//  Created by Raiden Yamato on 02.03.2023.
//

import UIKit



public class CreateQuestionGroupViewController: UITableViewController {

    public override func loadView() {
        super.loadView()
        
        
        setUpNavigation()
       
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
    }

    
}



