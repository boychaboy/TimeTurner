//
//  DueDate.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/02/22.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct DueDate: View {
    @Environment(\.managedObjectContext) var context
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    var task: Task
    @State private var showDateSelector = false
    var isSelected: Bool
    var body: some View {
        VStack{
            if isSelected {
                if(task.dueDate != nil){
                    HStack{
                        Text("Due: \(task.dueDate!, formatter: dateFormatter)")
                        Button(action: {
                            self.showDateSelector = true
                            self.clearDueDate();
                        }
                        ){
                            Text("X")
                        }
                    }
                }
                else{
                    Button(action: {self.showDateSelector = true}){
                        Text("🚩")
                    }.popover(isPresented: $showDateSelector) {
                        VStack {
                            DateSelector(selectedDate: Binding<Date>(get: {self.task.dueDate ?? Date()}, set: {self.setDueDate(dueDate: $0)}
                                )
                            )
                        }
                    }
                    //.buttonStyle(BorderedButtonStyle())
                }
            }
            else{
                if(self.task.dueDate != nil){
                    Text("🚩 \(self.task.dueDate!, formatter: dateFormatter)")
                }
            }
        }
    }
    func clearDueDate(){
        self.task.dueDate = nil
        try? context.save()
    }
    
    func setDueDate(dueDate: Date){
        self.task.dueDate = dueDate
        try? context.save()
    }
}

struct DueDate_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = "Preview"
        newTask.dateAdded = Date()
        return DueDate(task: newTask, isSelected: true)
    }
}
