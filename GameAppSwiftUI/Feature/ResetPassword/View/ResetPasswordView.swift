//
//  ResetPasswordView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 09/03/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ResetPasswordViewModelImplement(service: ResetPasswordServiceImplement())
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                InputTextFieldView(text: $viewModel.email, placeholder: L10n.emailAdress, keyboardType: .emailAddress, sfSymbol: L10n.sfenvelope)
                ButtonComponentView(title: L10n.submit) {
                    viewModel.sendResetPassword()
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding(15)
                .navigationTitle(L10n.resetPass)
                .applyExit()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
