//
//  Task.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct TaskRow : View {
    var task: Task
    @State private var showDetail = false
    @State private var taskName = ""
    
    var body: some View {
        HStack {
            Checkbox(task: task)
            VStack(alignment: .leading) {
                if showDetail {
                    TextField("text", text: $taskName)
                    DateSelector().transition(.opacity)
                }
                else {
                    Text(task.name!)
                        .font(.headline)
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
