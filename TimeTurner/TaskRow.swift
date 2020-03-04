//
//  Task.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI

struct TaskRow : View {
    @Environment(\.managedObjectContext) var context
    //var detail: Bool
    //@State var showDetail = false
    @Binding var selection : Task?
    var task: Task
//    var index : Int
//    @State private var taskName = ""
    @State private var memo = ""
    @Binding var isOn: Bool
    @State private var textFieldDisabled = false
    
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
                            self.isOn = false
                            self.selection = nil
                            self.textFieldDisabled = true
                        }.disabled(textFieldDisabled)
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
//                    withAnimation {
                        self.selection = self.task
//                    }
                    self.textFieldDisabled = false
                    self.isOn = true
                    //print("case 1")
                }
                else if self.selection == self.task && self.isOn{ //toggle off
//                    withAnimation {
                        self.selection = nil
//                    }
                    self.textFieldDisabled = true
                    self.isOn = false
                    //print("case 2")
                }
                else if self.selection != self.task && self.isOn { //reset
                    //print("case 3")
                    self.isOn = false
                    self.selection = nil
                    self.textFieldDisabled = true
                    //resetShowDetail()
                }
            }
        )
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    @State static var isOn = false
    @State static var selection: Task? = nil
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
        return TaskRow(selection: $selection, task: newTask, isOn: $isOn)
//            .environment(\.managedObjectContext, (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
#endif
