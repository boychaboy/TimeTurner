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
//    var task: Task
    @State private var dueDate:Date? = nil
    @State private var showDateSelector = false
    @Binding var isSelected: Bool
    var body: some View {
        VStack{
            if isSelected {
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
                        .buttonStyle(BorderedButtonStyle())
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
                    .buttonStyle(BorderedButtonStyle())
                }
            }
            else{
                if(dueDate != nil){
                    Text("􀋊 \(dueDate!, formatter: dateFormatter)")
                }
            }
        }
    }
    func clearDueDate(){
        self.dueDate = nil
    }
}

struct DueDate_Previews: PreviewProvider {
    @State static var isSelected = true
    static var previews: some View {
        DueDate(isSelected: $isSelected)
    }
}
