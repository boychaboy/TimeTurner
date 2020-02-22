//
//  Task.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct TaskRow : View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    var task: Task
    @State private var showDetail = false
    @State private var taskName = ""
    @State private var dueDate:Date? = nil
    @State private var showDatePicker = false
    @State private var memo = ""
    
    var body: some View {
        HStack {
            Checkbox(task: task)
            VStack(alignment: .leading) {
                if showDetail {
                    TextField("text", text: $taskName)
                    if(dueDate != nil){
                        HStack{
                            Text("Due: \(dueDate!, formatter: dateFormatter)")
                            Button(action: {
                                self.clearDueDate();
                                self.showDatePicker.toggle()
                            }
                            ){
                                Text("X")
                            }
                        }
                    }
                    else{
                        Button(action: {self.showDatePicker.toggle()}){
                            Text("(Due)")
                        }.popover(isPresented: $showDatePicker) {
                            VStack {
                                DateSelector(selectedDate: Binding<Date>(get: {self.dueDate ?? Date()}, set: {self.dueDate = $0})).transition(.opacity)
                            }
                        }
                    }
                    
                }
                else {
                    VStack(alignment : .leading) {
                        HStack {
                            Text(task.name!)
                                .font(.headline)
                            if(dueDate != nil){
                                Text("Due: \(dueDate!, formatter: dateFormatter)")
                            }
                        }
                    TextField("Add Memo", text: $memo)
                    }
                }
            }   
            .padding(.leading, 10)
            .frame(width: 300, alignment: .topLeading)
            .onTapGesture {
                withAnimation {
                    self.showDetail.toggle()
                }
            }
        }
    }
    func clearDueDate(){
        self.dueDate = nil
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = "Preview"
        newTask.dateAdded = Date()
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
        
        return TaskRow(task: newTask)
//            .environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
