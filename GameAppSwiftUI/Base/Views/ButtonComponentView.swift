//
//  ButtonComponentView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 03/04/2023.
//

import SwiftUI

struct ButtonComponentView: View {
    typealias ActionHandler = () -> Void
    let title: String
    let background: Color
    let forefround: Color
    let border: Color
    let handler: ActionHandler
    private let texFieldLeading: CGFloat = 30
    internal init(title: String, background: Color = .defaultButtonComponentColor, forefround: Color = .black, border: Color = .black, handler: @escaping ActionHandler) {
        self.title = title
        self.background = background
        self.forefround = forefround
        self.border = border
        self.handler = handler
    }
    var body: some View {
        Button(action: handler, label: {
            Text(title)
                .frame(maxWidth: 220, maxHeight: 44)
        })
        .background(background)
        .foregroundColor(forefround)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(10)
    }
}
extension Color {
    static let defaultButtonComponentColor = MyAppAssets.Assets.appColor.swiftUIColor
}

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponentView(title: L10n.login) {}
            .preview(with: L10n.login)
    }
}
