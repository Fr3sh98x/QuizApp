//
//  AuthService.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 06/03/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI

struct AuthService: UIViewControllerRepresentable {
    typealias UIViewControllerType = FUIAuthPickerViewController
    func makeUIViewController(context: Context) -> FUIAuthPickerViewController {
        // Konfiguruj FUIAuth.defaultAuthUI() do użycia Firebase Email/Password Provider
        let authUI = FUIAuth.defaultAuthUI()!
        authUI.delegate = context.coordinator
        authUI.providers = [FUIEmailAuth()]
        // Utwórz FUIAuthPickerViewController i umieść go w UINavigationController
        let authViewController = authUI.authViewController()
        let navController = UINavigationController(rootViewController: authViewController)
        // Sprawdź, czy authViewController jest typu FUIAuthPickerViewController, a następnie zwróć go
        guard let authPickerViewController = authViewController as? FUIAuthPickerViewController else {
            fatalError("Expected UIViewController to be a FUIAuthPickerViewController")
        }
        return authPickerViewController
    }

    func updateUIViewController(_ uiViewController: FUIAuthPickerViewController, context: Context) {
        // Nic tu nie robimy
    }
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject, FUIAuthDelegate {
        func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
            // Obsługa logowania
        }
        func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
            let loginViewController = FUIAuthPickerViewController(authUI: authUI)
            loginViewController.view.backgroundColor = .white
            return loginViewController
        }
    }
}
