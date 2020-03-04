//
//  TaskRow.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct TaskRow : View {
    @Environment(\.managedObjectContext) var context
    @Binding var selection : Task?
    var task: Task
    @State private var memo = ""
    
    func setName(name: String){
        self.task.name = name
        try? context.save()
    }
    
    var body: some View {
        HStack {
            Checkbox(task: task)
            VStack(alignment: .leading) {
                HStack {
                    if self.selection == self.task {
                        TextField("text", text: Binding<String>(get: {self.task.wrappedName}, set: {self.setName(name: $0)})
                            , onEditingChanged: { changed in
                                if changed {
                                    try? self.context.save()
                                }
                                else {
                                    try? self.context.save()
                                }
                        }){
                            self.selection = nil
                        }.disabled(selection != task)
                        TextField("Add Memo", text: $memo)
                    }
                    else{
                        Text(task.wrappedName)
                        .font(.headline)
                        
                    }
                    Spacer()
                    DueDate(task: task, isSelected: (self.selection == self.task))
                }
            }
            .padding(.leading, 10)
        }
        .gesture(TapGesture()
            .onEnded {
                if self.selection == nil{//toggle on
                    self.selection = self.task
                }
                else if self.selection == self.task{ //toggle off
                    self.selection = nil
                }
                else if self.selection != self.task { //reset
                    self.selection = nil
                }
            }
        )
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    @State static var selection: Task? = nil
    static var previews: some View {
        let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = "Preview"
        newTask.dateAdded = Date()
        return TaskRow(selection: $selection, task: newTask)
    }
}
#endif
