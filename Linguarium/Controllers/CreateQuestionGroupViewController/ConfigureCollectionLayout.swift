//
//  ConfigureCollectionLayout.swift
//  Linguarium
//
//  Created by Raiden Yamato on 20.05.2023.
//

import UIKit


public enum Section: Int, CaseIterable {
    case title
    case questions
    case create
    
    var itemHeight: NSCollectionLayoutDimension {
        switch self {
        case .title:
            return .fractionalHeight(1.0)
        case .questions:
            return .fractionalHeight(0.2)
        default:
            return .fractionalHeight(1.0)
        }
    }
    
    var groupHeight: NSCollectionLayoutDimension {
        switch self {
        case .title:
            return .fractionalHeight(0.1)
        case .questions:
            return .fractionalHeight(1.0)
        default:
            return .fractionalHeight(0.1)
        }
    }
    
    

    
}

extension CreateQuestionGroupViewController {
    
    func configureCollectionLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layout: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let  itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: sectionKind.itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: sectionKind.groupHeight)
            
          
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 2
            section.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 17, bottom: 17, trailing: 17)
            
            return section
            }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
          
        }

    
}



