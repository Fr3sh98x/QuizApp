//
//  RegisterService.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 09/03/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase

enum RegisterKeys: String {
    case nick
}

protocol RegisterService {
    func register(with details: RegisterModel) -> AnyPublisher<Void, Error>
}

final class RegisterServiceImplemet: RegisterService {
    func register(with details: RegisterModel) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth()
                    .createUser(withEmail: details.email, password: details.password) { authResult, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            if let uid = authResult?.user.uid {
                                let values = [RegisterKeys.nick.rawValue: details.nick] as [String: Any]
                                Database.database()
                                    .reference()
                                    .child(L10n.users)
                                    .child(uid)
                                    .updateChildValues(values) { error, authResult in
                                        if let err = error {
                                            promise(.failure(err))
                                        } else {
                                            promise(.success(()))
                                        }
                                    }
                            } else {
                                promise(.failure(NSError(domain: L10n.invalidUserID, code: 0, userInfo: nil)))
                            }
                        }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
