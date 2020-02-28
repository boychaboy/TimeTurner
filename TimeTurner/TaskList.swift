//
//  ContentView.swift
//  TimeTurner
//
//  Created by Maegan Wilson on 12/17/19.
//  Copyright © 2019 Maegan Wilson. All rights reserved.
//

import SwiftUI
import CoreData

//struct TaskRow: View {
//    var task: Task
//
//    var body: some View {
//        Text(task.name ?? "No name given")
//    }
//}

struct TaskList: View {
    @Environment(\.managedObjectContext) var context
    // this is the variable we added
    @State private var taskName: String = ""
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dateAdded, ascending: false)],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false))
    ) var notCompletedTasks: FetchedResults<Task>
//
//    @FetchRequest(fetchRequest: Task.getIncompleteTasks()) var notCompletedTasks: FetchedResults<Task>

    @State var isOn = false //[boychaboy] global variable to show list one at a time
    @State var selected = -1
    var body: some View {
        VStack {
            HStack{
                TextField("Task Name", text: $taskName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.addTask()
                }){
                    Text("Add Task")
                }
            }.padding(.all)
            /*
            List {
                ForEach(notCompletedTasks){ task in
//                    Button(action: {
//                        self.updateTask(task)
//                    }){
                    TaskRow(task: task, isOn: self.$isOn)
//                    }
                }
            }*/
            List {
                ForEach(0..<notCompletedTasks.count){ i in
                    TaskRow(selected: self.$selected, task: self.notCompletedTasks[i], index: i, isOn: self.$isOn)
                }
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
        } catch {
            print(error)
        }
    }
    
    func updateTask(_ task: Task){
        task.isComplete = true
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

#if DEBUG
struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList().environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
