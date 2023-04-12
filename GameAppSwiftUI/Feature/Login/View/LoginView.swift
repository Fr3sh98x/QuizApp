//
//  LoginView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 08/03/2023.
//

import SwiftUI

struct LoginView: View {
    @AppStorage(L10n.isDarkMode) private var isDarkMode = false
    @State private var showRegister = false
    @State private var showResetPassword = false
    @StateObject private var viewModel = LoginViewModelImplenent(service: LoginServiceImplement())
    var body: some View {
        NavigationView{
            VStack(spacing: 10) {
                HStack(alignment: .top) {
                    Spacer()
                    OptionsButton()
                        .padding(10)
                        .offset(x: -40, y: -20)
                }
                InputTextFieldView(text: $viewModel.model.email, placeholder: L10n.emailAdress, keyboardType: .emailAddress, sfSymbol: L10n.sfenvelope)
                InputPasswordView(password: $viewModel.model.password, placeholder: L10n.password, sfSymbol: L10n.sfLock)
                HStack {
                    Spacer()
                    Button(action: {
                        showResetPassword.toggle()
                    }, label: {
                        Text(L10n.forgotPassword)
                    }).font(.system(size: 16, weight: .bold))
                        .foregroundColor(.defaultButtonComponentColor)
                        .sheet(isPresented: $showResetPassword, content: {
                            ResetPasswordView()
                        })
                }
                VStack {
                    ButtonComponentView(title: L10n.login) {
                        viewModel.login()
                    }
                    ButtonComponentView(title: L10n.register, background: .clear, forefround: .defaultButtonComponentColor, border: .black) {
                        showRegister.toggle()
                    }
                    .sheet(isPresented: $showRegister, content: {
                        RegisterView()
                    })
                    ToggleDarkView()
                    
                }
                .padding(10)
                
                .alert(isPresented: $viewModel.hasError, content: {
                    if case .failed(let error) = viewModel.status {
                        return Alert(title: Text(L10n.errorTitle), message: Text(error.localizedDescription))
                    } else {
                        return Alert(title: Text(L10n.errorTitle), message: Text(L10n.errorInvalidLogin))
                    }
                })
            }
        }
        .navigationTitle(L10n.login)
        .preferredColorScheme(isDarkMode ? .dark : .light)
}
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                LoginView()
            }
        }
    }
}
