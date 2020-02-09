//
//  ContentView.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/02/09.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TaskList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
