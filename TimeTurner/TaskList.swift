//
//  TaskList.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI
import CoreData

struct TaskList: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dateAdded, ascending: false)],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false))
    ) var notCompletedTasks: FetchedResults<Task>
    @State var selection : Task? = nil
    @State private var taskName: String = ""
    
    var body: some View {
        VStack {
            HStack{
                TextField("Task Name", text: $taskName){
                    if(self.taskName != "") {
                        self.addTask()
                    }
                }
                    .textFieldStyle(PlainTextFieldStyle())
                Button(action: {
                    self.addTask()
                }){
                    Text("Add Task")
                }
            }.padding(.all)
            ForEach(notCompletedTasks){ task in
                TaskRow(selection: self.$selection, task: task)
            }
        }
    }

    func addTask() {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = taskName
        newTask.dateAdded = Date()
        taskName = ""
        try? context.save()
    }
    
    func updateTask(_ task: Task){
        task.isComplete = true
        try? context.save()
    }
}

#if DEBUG
struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList().environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
