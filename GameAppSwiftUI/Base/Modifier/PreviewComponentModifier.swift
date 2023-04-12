//
//  PreviewComponentModifier.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 03/04/2023.
//

import SwiftUI

struct PreviewComponentModifier: ViewModifier {
    let name: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
            .padding()
    }
}

extension View {
    func preview(with name: String) -> some View {
        self.modifier(PreviewComponentModifier(name: name))
    }
}
