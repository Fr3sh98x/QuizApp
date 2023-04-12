//
//  GameInProgressViewModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 16/03/2023.
//

import Combine
import Foundation
import Firebase

class QuizViewModel: ObservableObject {
    @Published var quizQuestions = [QuizQuestion]()
    private var db = Firestore.firestore()
    func fetchQuizQuestions() {
        db.collection(L10n.quizQuestions).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("\(L10n.errorGettingDoc) \(error)")
            } else {
                var questions = [QuizQuestion]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = document.documentID
                    let question = data[L10n.question] as? String ?? ""
                    let answersData = data[L10n.ans] as? [[String: Any]] ?? [ ]
                    var answers = [QuizAnswer]()
                    for answerData in answersData {
                        let answerId = answerData[L10n.id] as? String ?? ""
                        let answerText = answerData[L10n.answer] as? String ?? ""
                        let isCorrect = answerData[L10n.isCorrect] as? Bool ?? false
                        let answer = QuizAnswer(id: answerId, answer: answerText, isCorrect: isCorrect)
                        answers.append(answer)
                    }
                    // randomly move the first answer to a random position
                    if answers.count > 1 {
                        let randomIndex = Int.random(in: 1..<answers.count)
                        answers.swapAt(0, randomIndex)
                    }
                    let quizQuestion = QuizQuestion(id: id, question: question, answers: answers)
                    questions.append(quizQuestion)
                }
                self.quizQuestions = questions
            }
        }
    }
}
