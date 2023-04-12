//
//  LoginService.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 13/03/2023.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

protocol LoginService {
    func login(with model: LoginModel) -> AnyPublisher<Void, Error>
}

final class LoginServiceImplement: LoginService {
    func login(with model: LoginModel) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .signIn(withEmail: model.email, password: model.password) { res, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
