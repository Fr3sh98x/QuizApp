//
//  InputTextFieldView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 03/04/2023.
//

import SwiftUI

struct InputTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    private let texFieldLeading: CGFloat = 30
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .frame(maxWidth: 180, maxHeight: 44)
                .padding(.leading, sfSymbol == nil ? texFieldLeading / 2: texFieldLeading)
                .keyboardType(keyboardType)
                .background(
                    ZStack(alignment: .leading) {
                        if let systemImage = sfSymbol {
                            Image(systemName: systemImage)
                                .font(.system(size: 16))
                                .padding(.leading, 5)
                                .foregroundColor(.defaultButtonComponentColor)
                        }
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.defaultButtonComponentColor)
                    }
                )
        }
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputTextFieldView(text: .constant(""), placeholder: L10n.emailAdress, keyboardType: .emailAddress, sfSymbol: L10n.sfenvelope)
                .preview(with: L10n.emailAdress)
        }
    }
}
