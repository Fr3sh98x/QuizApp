//
//  InputPasswordView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 03/04/2023.
//

import SwiftUI

struct InputPasswordView: View {
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String?
    private let texFieldLeading: CGFloat = 30
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(maxWidth: 180, maxHeight: 44)
            .padding(.leading, sfSymbol == nil ? texFieldLeading / 2: texFieldLeading)
            .background(
                ZStack(alignment: .leading) {
                    if let systemImage = sfSymbol {
                        Image(systemName: systemImage)    .font(.system(size: 16))
                            .padding(.leading, 5)
                            .foregroundColor(.defaultButtonComponentColor)
                    }
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.defaultButtonComponentColor)
                }
            )}
}

struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordView(password: .constant(""), placeholder: L10n.password, sfSymbol: L10n.sfLock)
            .preview(with: L10n.password)
    }
}
