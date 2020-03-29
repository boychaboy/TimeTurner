//
//  ContentView.swift
//  TimeTurner_iOS
//
//  Created by Kun Jeong on 2020/03/07.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    var body: some View {
        TabView(selection: $selection){
            Tab1()
                .tabItem {
                    VStack {
                        Text("Koon")
                    }
                }
                .tag(0)
            Tab2()
                .tabItem {
                    VStack {
                        Text("boychaboy")
                    }
                }
                .tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
