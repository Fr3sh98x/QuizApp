//
//  GameInProgressView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 16/03/2023.
//

import SwiftUI
import Lottie

struct QuizView: View {
    @ObservedObject var quizVM = QuizViewModel()
    @State var currentQuestionIndex = 0
    @State var score = 0
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    var body: some View {
        VStack {
            if quizVM.quizQuestions.isEmpty {
                //Text(L10n.loading)
                LottieView(lottieFile: "Aniki Hamster")
                                    .frame(width: 200, height: 200)
            } else if currentQuestionIndex >= quizVM.quizQuestions.count {
                Text("\(L10n.finishedQuizPart1) \(score) \(L10n.finishedQuizPart2) \(quizVM.quizQuestions.count).")
            } else {
                VStack(alignment: .leading) {
                    Text( "\(L10n.questionOf) \(currentQuestionIndex + 1) \(L10n.of) \(quizVM.quizQuestions.count)")
                        .font(.caption)
                    Text(quizVM.quizQuestions[currentQuestionIndex].question)
                        .font(.title)
                        .padding()
                    Spacer()
                    ForEach(quizVM.quizQuestions[currentQuestionIndex].answers) { answer in
                        Button(action: {
                            handleAnswer(answer)
                        }, label: {
                            Text(answer.answer)
                                .foregroundColor(.white)
                                .padding()
                        })
                        .buttonStyle(AnswerButtonStyle())
                        .padding()
                    }
                    Spacer()
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(L10n.ok), action: {
                        goToNextQuestion()
                    }))
                })
            }
        }
        .onAppear(perform: {
            quizVM.fetchQuizQuestions()
        })
    }
    private func handleAnswer(_ selectedAnswer: QuizAnswer) {
        if selectedAnswer.isCorrect {
            score += 1
            alertTitle = L10n.correct
            alertMessage = L10n.congratulations
        } else {
            alertTitle = L10n.incorrect
            alertMessage = L10n.sorryWrongAnswer
        }
        showAlert = true
    }
    private func goToNextQuestion() {
        currentQuestionIndex += 1
    }
}

struct AnswerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: 220, maxHeight: 44)
            .background(Color.defaultButtonComponentColor)
            .foregroundColor(.black)
            .font(.system(size: 16, weight: .bold))
            .cornerRadius(10)
            .padding()
    }
}
