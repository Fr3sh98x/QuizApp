//
//  ContentView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 21/02/2023.
//

import SwiftUI
struct ContentView: View {
@EnvironmentObject var sessionService: SessionServiceImplement
    @State private var showAdd = false
    @State private var showGame = false
    @State var textInput = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                            Spacer()
                            OptionsButton()
                                .padding(10)
                                .offset(x: -10, y: -10)
                        }
                Spacer()
                ButtonComponentView(title: L10n.addQuestion) {
                    showAdd.toggle()
                }.sheet(isPresented: $showAdd, content: {
                    AddQuestionView()
                })
                ButtonComponentView(title: L10n.start) {
                    showGame.toggle()
                }.sheet(isPresented: $showGame, content: {
                    QuizView()
                })
                Spacer()
                ButtonComponentView(title: L10n.logOut) {
                    sessionService.logout()
                }
            }
            .padding(1)
        }
        .navigationTitle(L10n.quizGame)
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
