//
//  Craft_SiliconApp.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import SwiftUI

@main
struct Craft_SiliconApp: App {
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                RootView()
                    .environmentObject(weatherViewModel)
            }
        }
    }
}
