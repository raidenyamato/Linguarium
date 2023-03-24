//
//  QuestionGroupCaretaker.swift
//  Linguarium
//
//  Created by Raiden Yamato on 09.11.2022.
//

import Foundation

public final class QuestionGroupCaretaker {
    
    // MARK: - Properties
    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    // MARK: - Object Lifecycle
    public init() {
        loadQuestionGroups()
    }
    
    private func loadQuestionGroups()  {
        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: fileName) {
            self.questionGroups = questionGroups
        } else {
                let bundle = Bundle.main
                let url = bundle.url(forResource: fileName, withExtension: "json")!
                self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
            try! save()
        }
    }
    
    // MARK: Instance Methods
    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
