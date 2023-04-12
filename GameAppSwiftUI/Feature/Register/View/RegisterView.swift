//
//  RegisterView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 08/03/2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = RegisterViewModelImplement(service: RegisterServiceImplemet())
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                InputTextFieldView(text: $viewModel.userDetails.email, placeholder: L10n.emailAdress, keyboardType: .emailAddress, sfSymbol: L10n.sfenvelope)
                InputTextFieldView(text: $viewModel.userDetails.nick, placeholder: L10n.nick, keyboardType: .emailAddress, sfSymbol: L10n.sfBubble)
                InputPasswordView(password: $viewModel.userDetails.password, placeholder: L10n.password, sfSymbol: L10n.sfLock)
                ButtonComponentView(title: L10n.singUp) {
                    viewModel.register()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(15)
            .navigationTitle(L10n.register)
            .applyExit()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
