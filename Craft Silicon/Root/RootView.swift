//
//  RootView.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        ZStack{
            Group {
               HomeView()
            }
        }
    }
}

#Preview {
    RootView()
}

