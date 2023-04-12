//
//  ResetPasswordViewModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 14/03/2023.
//

import Foundation
import Combine
import Firebase

protocol ResetPasswordViewModel {
    func sendResetPassword()
    var service: ResetPasswordService { get }
    var email: String { get }
    init(service: ResetPasswordService)
}

final class ResetPasswordViewModelImplement: ObservableObject, ResetPasswordViewModel {
    @Published var email: String = ""
    let service: ResetPasswordService
    private var subscriptions = Set<AnyCancellable>()
    init(service: ResetPasswordService) {
        self.service = service
    }
    func sendResetPassword() {
        service
            .sendPasswordReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("\(L10n.filed) \(err)")
                default: break
                }
            } receiveValue: {
                print(L10n.sendResetPass)
            }
            .store(in: &subscriptions)
    }
}
