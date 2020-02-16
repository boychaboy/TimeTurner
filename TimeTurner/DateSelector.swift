//
//  DateSelector.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/24.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct DateSelector: View {
    @Binding var selectedDate: Date
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
    @State static var dueDate: Date? = nil
    static var previews: some View {
        DateSelector(selectedDate: Binding<Date>(get: {self.dueDate ?? Date()}, set: {self.dueDate = $0}))
    }
}
