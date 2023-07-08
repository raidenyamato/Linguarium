//
//  QuestionGroupCell.swift
//  Linguarium
//
//  Created by Raiden Yamato on 24.11.2022.
//

import UIKit
import Combine


class GroupItem {
    
    
    public let questionGroup: QuestionGroup
    var percentage: String = "0 %"
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
}

public class QuestionGroupCell: UITableViewCell {
    
    public var percentageSubscriber: AnyCancellable?
    
    static let cellCornerRadius: CGFloat = 10
    
    static let identifier = "QuestionGroupCell"
    
    var groupItem: GroupItem?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure(questionGroup: QuestionGroup) {
        
        groupItem = GroupItem(questionGroup: questionGroup)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        let contentConfig = MyContentConfiguration()
        contentConfiguration = contentConfig
    }
    
    //MARK: - updateConfiguration
    public override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var contentConfig = MyContentConfiguration().updated(for: state)
        
        contentConfig.title = groupItem!.questionGroup.title

        percentageSubscriber =
        groupItem?.questionGroup.score.$runningPercentage
            .receive(on: DispatchQueue.main)
            .map() {
              return String(format: "%.0f %%", round(100 * $0))
            }.assign(to: \.!.percentage, on: groupItem)
        
        contentConfig.percentage = groupItem!.percentage
        
        
        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .white
        
        backgroundConfig?.cornerRadius = QuestionGroupCell.cellCornerRadius
        if state.isHighlighted || state.isSelected {
            backgroundConfig?.backgroundColor = .black
        }
        
        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
    
}


//MARK: - UIContentConfiguration
class MyContentView: UIView, UIContentView {
    
    let titleLabel = UILabel()
    let percentageLabel = UILabel()
    
    private var currentConfiguration: MyContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? MyContentConfiguration else { return }
            apply(configuration: newConfiguration)
        }
        
    }
    
    // MARK: init
    init(configuration: MyContentConfiguration) {
        super.init(frame: .zero)
        setupAllViews()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupAllViews() {
        addSubview(titleLabel)
        addSubview(percentageLabel)
        titleLabel.textAlignment = .left
        percentageLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.widthAnchor.constraint(equalToConstant: 50),
            percentageLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            percentageLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0),
            percentageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: percentageLabel.leadingAnchor, constant: -10)
        ])
    }
    
    private func apply(configuration: MyContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        currentConfiguration = configuration
        
        titleLabel.text = configuration.title
        percentageLabel.text = configuration.percentage
        titleLabel.textColor = configuration.textlColor
        percentageLabel.textColor = configuration.textlColor
        if let fontWeight = configuration.fontWeight {
            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: fontWeight)
            percentageLabel.font = UIFont.systemFont(ofSize: 17, weight: fontWeight)
        }
    }
}

struct MyContentConfiguration: UIContentConfiguration, Hashable {
    var title = ""
    var percentage = "0 %"
    var textlColor: UIColor?
    var fontWeight: UIFont.Weight?
    
    
    func makeContentView() -> UIView & UIContentView {
        return MyContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> MyContentConfiguration {
        guard let state = state as? UICellConfigurationState else {
            return self
        }
        var updateConfiguration = self
        if state.isSelected || state.isHighlighted {
            updateConfiguration.textlColor = .white
            updateConfiguration.fontWeight = .heavy
        } else {
            updateConfiguration.textlColor = .black
            updateConfiguration.fontWeight = .regular
        }
        return updateConfiguration
    }
    
}

