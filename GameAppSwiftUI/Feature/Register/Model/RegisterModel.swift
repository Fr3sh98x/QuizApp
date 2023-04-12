//
//  RegisterModel.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 09/03/2023.
//

import Foundation

struct RegisterModel {
    var email: String
    var nick: String
    var password: String
}

extension RegisterModel {
    static var new: RegisterModel {
        RegisterModel(email: "", nick: "", password: "")
    }
}
