//
//  DateSelector.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/24.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct DateSelector: View {
    @State private var selectedDate = Date()
    var body: some View {
        Form{
            DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: [.date]){
                Text("Due")
                
            }.padding(5)
                .datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DateSelector()
    }
}
