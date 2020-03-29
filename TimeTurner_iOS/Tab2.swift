//
//  Tab2.swift
//  TimeTurner_iOS
//
//  Created by Kun Jeong on 2020/03/07.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI
import CoreData

struct Tab2: View {
    @State private var taskName: String = ""
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dateAdded, ascending: false)],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false))
    ) var notCompletedTasks: FetchedResults<Task>
    
    @State var selection : Task? = nil
    
    var body: some View {
        VStack(spacing: 0) {
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
            }
            .padding()
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
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    func updateTask(_ task: Task){
        task.isComplete = true
        try? context.save()
    }
}

struct Tab2_Previews: PreviewProvider {
    static var previews: some View {
        Tab2()
    }
}
