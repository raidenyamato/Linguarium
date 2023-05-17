//
//  CQCollectionView.swift
//  Linguarium
//
//  Created by Raiden Yamato on 28.04.2023.
//

import UIKit

public class CQCollectionView: UICollectionView {
    
    fileprivate struct CellIdentifiers {
        fileprivate static let add = "AddQuestionCell"
        fileprivate static let title = "CreateQuestionGroupTitleCell"
        fileprivate static let question = "CreateQuestionCell"
    }
    
    enum Section {
        case main
    }
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    convenience init() {
        
        //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //        layout.itemSize = CGSize(width: 60, height: 60)
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 17, bottom: 17, trailing: 17)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        
        configureDiffableDatasource()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        configureCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCollection() {
        backgroundColor = UIColor(red: 48 / 255,
                                  green: 179 / 255,
                                  blue: 199 / 255,
                                  alpha: 0.3)
        
        register(CreateQuestionGroupTitleCell.self, forCellWithReuseIdentifier: CellIdentifiers.title)
        register(CreateQuesitonCell.self, forCellWithReuseIdentifier: CellIdentifiers.question)
        
        alwaysBounceVertical = true
        self.delegate = self
        
        
    }
    
    
    func configureDiffableDatasource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self, cellProvider: { [self] collectionView, indexPath, itemIdentifier in
            
            var cell: UICollectionViewCell!
            let row = indexPath.row
            if row == 0 {
                cell = titleCell(from: self, for: indexPath)
            } else if row == 1 {
                cell = questionCell(from: self, for: indexPath)
            }
            cell.backgroundColor = UIColor(red: 220 / 255,
                                           green: 248 / 255,
                                           blue: 255 / 255,
                                           alpha: 0.9)
            cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.7)
            cell.layer.shadowOffset = CGSizeMake(0, 5)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 10
            cell.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            
            cell.layer.borderColor = UIColor(red: 48 / 255, green: 179 / 255, blue: 199 / 255, alpha: 0.3).cgColor
            cell.layer.borderWidth = 3
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section,Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<2))
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func titleCell(from collectionView: UICollectionView, for indexaPath: IndexPath) -> CreateQuestionGroupTitleCell {
        guard  let cell = dequeueReusableCell(withReuseIdentifier: CellIdentifiers.title, for: indexaPath) as? CreateQuestionGroupTitleCell else { fatalError("Cannot create new title cell")}
        cell.delegate = self
        return cell
    }
    
    
    
    private func questionCell(from collectionView: UICollectionView,
                              for indexPath: IndexPath) -> CreateQuesitonCell {
        guard  let cell = dequeueReusableCell(withReuseIdentifier: CellIdentifiers.question, for: indexPath) as? CreateQuesitonCell else { fatalError("Cannot create new cell")}
        return cell
    }
    
    
}
    
// MARK: - UICollectionViewDelegate
extension CQCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deselectItem(at: indexPath, animated: true)
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

// MARK: - CreateQuestionGroupTitleCellDelegate

extension CQCollectionView: CreateQuestionGroupTitleCellDelegate {
    public func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell, titlTextDidChange text: String) {
        // TODO: Write this
    }
}


// MARK: - CreateQuestionCellDelegate
extension CQCollectionView: CreateQuesitonCellDelegate {
    public func createQuesitonCell(_ cell: CreateQuesitonCell, answerTextDidChange text: String) {
        // TODO: - Write this
    }
    
    public func createQuesitonCell(_ cell: CreateQuesitonCell, hintTextDidChange text: String) {
        // TODO: - Write this
    }
    
    public func createQuesitonCell(_ cell: CreateQuesitonCell, promptTextDidChange text: String) {
        // TODO: - Write this
    }
    
    
}
