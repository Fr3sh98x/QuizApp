//
//  LoginViewModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 13/03/2023.
//

import Foundation
import Combine
import Firebase

protocol LoginViewModel {
    func login()
    var service: LoginService { get }
    var status: LoginStatus { get }
    var model: LoginModel { get }
    var hasError: Bool { get }
    init(service: LoginService)
}
enum LoginStatus {
    case succesfull
    case failed(error: Error)
    case na
}

final class LoginViewModelImplenent: ObservableObject, LoginViewModel {
    @Published var hasError: Bool = false
    @Published var status: LoginStatus = .na
    @Published var model: LoginModel = LoginModel.new
    private var subscriptions = Set<AnyCancellable>()
    let service: LoginService
    init(service: LoginService) {
        self.service = service
        setupError()
    }
    func login() {
        service
            .login(with: model)
            .sink { res in
                switch res {
                case.failure(let err):
                    self.status = .failed(error: err)
                default: break
                }
            }receiveValue: { [weak self] in
                self?.status = .succesfull
            }
            .store(in: &subscriptions)
    }
}

private extension LoginViewModelImplenent {
    func setupError() {
        $status
            .map {status -> Bool in
                switch status {
                case.succesfull,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }.assign(to: &$hasError)
    }
}
