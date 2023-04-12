//
//  ExitModifier.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 03/04/2023.
//

import SwiftUI

struct ExitModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: L10n.xmark)
                })
            }
    }
}
    extension View {
        func applyExit() -> some View {
            modifier(ExitModifier())
    }
}
