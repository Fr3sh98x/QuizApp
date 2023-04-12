//
//  RegisterViewModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 10/03/2023.
//

import Foundation
import Combine

enum RegisterStatus {
    case succesfull
    case failed(error: Error)
    case na
}

protocol RegisterViewModel {
    func register()
    var service: RegisterService {get}
    var state: RegisterStatus {get}
    var userDetails: RegisterModel {get}
    init(service: RegisterService)
}

final class RegisterViewModelImplement: ObservableObject, RegisterViewModel {
    let service: RegisterService
    @Published var state: RegisterStatus = .na
    @Published var userDetails: RegisterModel = RegisterModel.new
    private var subscriptions = Set<AnyCancellable>()
    init(service: RegisterService) {
        self.service = service
    }
    func register() {
        service
            .register(with: userDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .succesfull
            }
            .store(in: &subscriptions)
    }
}
