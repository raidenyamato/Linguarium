//
//  QuestionGroup.swift
//  Linguarium
//
//  Created by Raiden Yamato on 09.11.2022.
//

import Combine
import Foundation

public class QuestionGroup: Codable {
    
    public let questions: [Question]
    public private(set) var score: Score
    public let title: String
    
    public init(questions: [Question],
                score: Score = Score(),
                title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
    
    public class Score: Codable {
        public var correctCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }
        public var incorrectCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }
        
        @Published public var runningPercentage: Double = 0
        
        public init() {}
        
        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }
        
        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            correctCount = try container.decode(Int.self, forKey: CodingKeys.correctCount)
            incorrectCount = try container.decode(Int.self, forKey: CodingKeys.incorrectCount)
            updateRunningPercentage()
        }
        
        private func updateRunningPercentage() {
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                runningPercentage = 0
                return
            }
            runningPercentage = Double(correctCount) / Double(totalCount)
        }
        
        public func reset() {
            correctCount = 0
            incorrectCount = 0
        }
    }
    
    
   
}

