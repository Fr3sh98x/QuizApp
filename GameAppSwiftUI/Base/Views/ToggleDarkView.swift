//
//  TogleDarkView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 06/04/2023.
//

import SwiftUI

struct ToggleDarkView: View {
    @AppStorage(L10n.isDarkMode) private var isDarkMode = false
    var body: some View  {
        Toggle(L10n.darkMode, isOn: $isDarkMode)
    }
}

struct ToggleDarkView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleDarkView()
    }
}
