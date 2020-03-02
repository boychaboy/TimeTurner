//
//  Task.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct TaskRow : View {

    //var detail: Bool
    //@State var showDetail = false
    @Binding var selected : Int
    var task: Task
    var index : Int
    @State private var taskName = ""
    @State private var memo = ""
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Checkbox(task: task)
            VStack(alignment: .leading) {
                HStack {
                    if self.selected == index {
                        //TextField("text", text: $taskName)
                        Text(task.name!)
                    }
                    else{
                        Text(task.name!)
                        .font(.headline)
                        //TextField("Add Memo", text: $memo)
                    }
                    Spacer()
                    DueDate(isSelected: (self.selected == index))
                }
            }
            /*
            .gesture(TapGesture()
                .onEnded {
                    withAnimation {
                        self.showDetail.toggle()
                    }
                }
            )*/
            .padding(.leading, 10)
//            .frame(width: 300, alignment: .topLeading)
        }
        .gesture(TapGesture()
            .onEnded {
                if self.selected == -1 && !self.isOn{//toggle on
                    withAnimation {
                        self.selected = self.index
                    }
                    self.isOn = true
                    //print("case 1")
                }
                else if self.selected == self.index && self.isOn{ //toggle off
                    withAnimation {
                        self.selected = -1
                    }
                    self.isOn = false
                    //print("case 2")
                }
                else if self.selected != self.index && self.isOn { //reset
                    //print("case 3")
                    self.isOn = false
                    self.selected = -1
                    //resetShowDetail()
                }
            }
        )
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    @State static var isOn = false
    @State static var selected = -1
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
        return TaskRow(selected: $selected, task: newTask, index: 0, isOn: $isOn)
//            .environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
