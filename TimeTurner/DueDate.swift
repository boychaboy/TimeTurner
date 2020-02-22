//
//  DueDate.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/02/22.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct DueDate: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    @State private var dueDate:Date? = nil
    @State private var showDateSelector = false
    var body: some View {
        VStack{
            if(dueDate != nil){
                HStack{
                    Text("Due: \(dueDate!, formatter: dateFormatter)")
                    Button(action: {
                        self.clearDueDate();
                        self.showDateSelector.toggle()
                    }
                    ){
                        Text("􀆄")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            else{
                Button(action: {self.showDateSelector.toggle()}){
                    Text("􀋊")
                }.popover(isPresented: $showDateSelector) {
                    VStack {
                        DateSelector(selectedDate: Binding<Date>(get: {self.dueDate ?? Date()}, set: {self.dueDate = $0}))
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    func clearDueDate(){
        self.dueDate = nil
    }
}

struct DueDate_Previews: PreviewProvider {
    static var previews: some View {
        DueDate()
    }
}
