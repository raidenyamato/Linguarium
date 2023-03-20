//
//  RandomQuestionStrategy.swift
//  Linguarium
//
//  Created by Raiden Yamato on 11.03.2023.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {
  
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKMersenneTwisterRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
    
}
