//
//  ResetPasswordService.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 14/03/2023.
//

import Foundation
import Firebase
import Combine

protocol ResetPasswordService {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>
}

final class ResetPasswordServiceImplement: ResetPasswordService {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .sendPasswordReset(withEmail: email) { error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                }
            }
        }.eraseToAnyPublisher()
    }
}
