//
//  GameInProgressModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 16/03/2023.
//

import Foundation

struct QuizQuestion: Identifiable, Codable {
    var id: String
    var question: String
    var answers: [QuizAnswer]
}

struct QuizAnswer: Identifiable, Codable {
    var id: String
    var answer: String
    var isCorrect: Bool
}

struct QuizResult: Identifiable,Codable {
    var id: String
    var score: Int
    var totalQuestions: Int
    var timestamp: Date
}
