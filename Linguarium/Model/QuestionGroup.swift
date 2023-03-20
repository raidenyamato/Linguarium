//
//  QuestionGroup.swift
//  Linguarium
//
//  Created by Raiden Yamato on 09.11.2022.
//

import Foundation

public class QuestionGroup: Codable {
    
    
    public class Score: Codable {
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
        
        public init() {}
        
        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }
        
        public required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<QuestionGroup.Score.CodingKeys> = try decoder.container(keyedBy: QuestionGroup.Score.CodingKeys.self)
            correctCount = try container.decode(Int.self, forKey: QuestionGroup.Score.CodingKeys.correctCount)
            incorrectCount = try container.decode(Int.self, forKey: QuestionGroup.Score.CodingKeys.incorrectCount)
        }
    }
    
    
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    public init(questions: [Question],
                score: Score = Score(),
                title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}

