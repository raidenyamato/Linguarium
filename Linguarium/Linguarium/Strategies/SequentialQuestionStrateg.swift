//
//  SequentialQuestionStrateg.swift
//  Linguarium
//
//  Created by Raiden Yamato on 11.03.2023.
//

import Foundation
public class SequentialQuestionStrategy: BaseQuestionStrategy {
  
  public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
    let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
    let questions = questionGroup.questions
    self.init(questionGroupCaretaker: questionGroupCaretaker,
              questions: questions)
  }
}

