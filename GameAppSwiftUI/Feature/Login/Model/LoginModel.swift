//
//  File.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 09/03/2023.
//

import Foundation

struct LoginModel {
    var email: String
    var password: String
}

extension LoginModel {
    static var new: LoginModel {
        LoginModel(email: "", password: "")
    }
}
