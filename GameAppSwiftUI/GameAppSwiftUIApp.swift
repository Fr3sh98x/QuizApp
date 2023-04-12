//
//  GameAppSwiftUIApp.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 21/02/2023.
//
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct GameAppSwiftUIApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var sessionService = SessionServiceImplement()

  var body: some Scene {
    WindowGroup {
      NavigationView {
              switch sessionService.state {
              case .loggedIn:
                ContentView()
                      .environmentObject(sessionService)
              case .loggedOut:
                LoginView()
          }
      }
    }
  }
}
