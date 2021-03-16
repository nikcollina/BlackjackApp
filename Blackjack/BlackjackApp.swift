//
//  BlackjackApp.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/9/20.
//

import SwiftUI

@main
struct BlackjackApp: App {
    @StateObject var playingModel = PlayingModel()
    @StateObject var practiceModel = PracticeModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environmentObject(playingModel)
                .environmentObject(practiceModel)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                practiceModel.saveData()
                playingModel.saveData()
            default:
                break
            }
        }
    }
}
