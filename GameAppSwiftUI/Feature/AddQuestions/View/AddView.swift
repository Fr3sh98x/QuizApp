//
//  AddView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 16/03/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddQuestionViewModel()

    var body: some View {
        VStack {
            // formularz do wprowadzenia pytania i odpowiedzi
            InputTextFieldView(text: $viewModel.questionText, placeholder: L10n.addQuestion, keyboardType: .emailAddress, sfSymbol: L10n.questionmark)
            ForEach(0..<4, id: \.self) { index in
                InputTextFieldView(text: $viewModel.answers[index], placeholder: index == 0 ? L10n.correctAnswer : L10n.wrongAnswer, keyboardType: .emailAddress, sfSymbol: L10n.questionmarkSquare)
               }
               ButtonComponentView(title: L10n.addQuestion) {
                   viewModel.addQuestion()
                   presentationMode.wrappedValue.dismiss()
               }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView()
    }
}
