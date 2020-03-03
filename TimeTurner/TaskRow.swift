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
    @Binding var selection : Int?
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
                    if self.selection == index {
                        TextField("text", text: $taskName)
                        Text(task.name!)
                    }
                    else{
                        Text(task.name!)
                        .font(.headline)
                        //TextField("Add Memo", text: $memo)
                    }
                    Spacer()
                    DueDate(isSelected: (self.selection == index))
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
                if self.selection == nil && !self.isOn{//toggle on
                    withAnimation {
                        self.selection = self.index
                    }
                    self.isOn = true
                    //print("case 1")
                }
                else if self.selection == self.index && self.isOn{ //toggle off
                    withAnimation {
                        self.selection = nil
                    }
                    self.isOn = false
                    //print("case 2")
                }
                else if self.selection != self.index && self.isOn { //reset
                    //print("case 3")
                    self.isOn = false
                    self.selection = nil
                    //resetShowDetail()
                }
            }
        )
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    @State static var isOn = false
    @State static var selection:Int? = nil
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
        return TaskRow(selection: $selection, task: newTask, index: 0, isOn: $isOn)
//            .environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
