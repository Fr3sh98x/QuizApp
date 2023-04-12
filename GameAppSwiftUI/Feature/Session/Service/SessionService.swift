//
//  SessionService.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 11/03/2023.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

enum SessionStatus {
    case loggedIn
    case loggedOut
}

protocol SessionService {
    var state: SessionStatus { get }
    var userDetails: SessionModel? { get }
    init()
    func logout()
}

final class SessionServiceImplement: ObservableObject, SessionService {
    @Published var state: SessionStatus = .loggedOut
    @Published var userDetails: SessionModel?
    private var handler: AuthStateDidChangeListenerHandle?
    init() {
        setupFirebaseAuthHandler()
    }
    deinit {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
        print(L10n.deinitSession)
    }
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImplement {
    func setupFirebaseAuthHandler() {
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] res, user in
                guard let self = self else { return }
                self.state = user == nil ? .loggedOut : .loggedIn
                if let uid = user?.uid {
                    self.handlerRefresh(with: uid)
                }
            }
    }
    func handlerRefresh(with uid: String) {
        Database
            .database()
            .reference()
            .child(L10n.users)
            .observe(.value) { [weak self] snapshot in
                guard let self = self,
                      let value = snapshot.value as? NSDictionary,
                      let nick = value[RegisterKeys.nick.rawValue] as? String else {
                    return
                }
                DispatchQueue.main.async {
                    self.userDetails = SessionModel(nick: nick)
            }
        }
    }
}
