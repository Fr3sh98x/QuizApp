//
//  OptionsButton.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 05/04/2023.
//

import SwiftUI

struct OptionsButton: View {
    var body: some View {
        Button(action: {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }) {
            Image(systemName: L10n.gear)
                .foregroundColor(.defaultButtonComponentColor)
        }
    }
}

struct OptionsButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionsButton()
    }
}
