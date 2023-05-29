//
//  CQCollectionView.swift
//  Linguarium
//
//  Created by Raiden Yamato on 28.04.2023.
//

import UIKit


public struct MockStruct: Hashable, Equatable {
    let integer: Int
    let identifier = UUID().uuidString
    
    static var mock: [MockStruct] {
        var array: [MockStruct] = []
        for i in 1..<2 {
            array.append(MockStruct(integer: i))
        }
        return array
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    public static func == (lhs: MockStruct, rhs: MockStruct) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}

public struct MockStruct2: Hashable, Equatable {
    let integer: Int
    let identifier = UUID().uuidString
    
    static var mock: [MockStruct] {
        var array: [MockStruct] = []
        for i in 1..<6 {
            array.append(MockStruct(integer: i))
        }
        return array
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    public static func == (lhs: MockStruct2, rhs: MockStruct2) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}

public class CQCollectionView: UICollectionView {
    
    fileprivate struct CellIdentifiers {
        fileprivate static let add = "AddQuestionCell"
        fileprivate static let title = "CreateQuestionGroupTitleCell"
        fileprivate static let question = "CreateQuestionCell"
    }
    
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, MockStruct>! = nil
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        configureDiffableDatasource()
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
        register(AddQuestionCell.self, forCellWithReuseIdentifier: CellIdentifiers.add)
        alwaysBounceVertical = true
        self.delegate = self
        
        
    }
    
    
    func configureDiffableDatasource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, MockStruct>(collectionView: self, cellProvider: { [self] collectionView, indexPath, item in
            
            print("\(indexPath.section)")
            if indexPath.section == 0 {
               let cell = titleCell(from: self, for: indexPath)
                return configureCell(cell: cell)
            } else if indexPath.section == 1 {
              let cell = questionCell(from: self, for: indexPath)
                cell.indexLabel.text = String(item.integer)
                return configureCell(cell: cell)
            } else {
                let cell = addQuestionGroupCell(from: self, for: indexPath)
                return configureCell(cell: cell)
            }
           
            
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section,MockStruct>()
        snapshot.appendSections([ .title, .questions, .create])
       snapshot.appendItems(MockStruct.mock, toSection: .title)
        snapshot.appendItems(MockStruct2.mock, toSection: .questions)
        snapshot.appendItems(MockStruct.mock, toSection: .create)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    private func configureCell(cell: UICollectionViewCell) -> UICollectionViewCell {
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
    
    private func addQuestionGroupCell(from collecitonVew: UICollectionView, for indexPath: IndexPath) -> AddQuestionCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellIdentifiers.add, for: indexPath) as? AddQuestionCell else { fatalError("Cannot create new add cell")}
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


