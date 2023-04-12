//
//  AddQuestionViewModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 23/03/2023.
//
import Foundation
import Firebase
import FirebaseFirestore

class AddQuestionViewModel: ObservableObject {
    @Published var questionText = ""
    @Published var answers: [String] = Array(repeating: "", count: 4)
    private var db = Firestore.firestore()

    func addQuestion() {
        let questionRef = db.collection(L10n.quizQuestions).document()
        let answers = [QuizAnswer(id: L10n._1, answer: answers[0], isCorrect: true),
                       QuizAnswer(id: L10n._2, answer: answers[1], isCorrect: false),
                       QuizAnswer(id: L10n._3, answer: answers[2], isCorrect: false),
                       QuizAnswer(id: L10n._4, answer: answers[3], isCorrect: false)]
        let question = QuizQuestion(id: questionRef.documentID,
                                    question: questionText,
                                    answers: answers)
        questionRef.setData([
            L10n.id: question.id,
            L10n.question: question.question,
            L10n.ans: question.answers.map { answer in
                return [L10n.id: answer.id, L10n.ans: answer.answer, L10n.isCorrect: answer.isCorrect]
            }
        ])
    }
}
