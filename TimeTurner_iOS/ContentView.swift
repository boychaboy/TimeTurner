//
//  ContentView.swift
//  TimeTurner_iOS
//
//  Created by Kun Jeong on 2020/03/07.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Tab1()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Books")
                    }
                }
                .tag(0)
            Tab2()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
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
