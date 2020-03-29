//
//  TaskRow.swift
//  TimeTurner
//
//  Created by Boychaboy Mac on 2020/01/23.
//  Copyright © 2020 Younghoon Jeong. All rights reserved.
//

import SwiftUI
import UIKit

struct TaskRow : View {
    @Environment(\.managedObjectContext) var context
    @Binding var selection : Task?
    var task: Task
    @State private var memo = ""
    
    func setName(name: String){
        self.task.name = name
        try? context.save()
    }
    
    func deSelectSelf(){
        withAnimation{
            self.selection = nil
        }
    }
    
    func selectSelf(){
        withAnimation{
            self.selection = self.task
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Checkbox(task: task)
            if self.selection == self.task {
                VStack(alignment: .leading) {
                    TextField("text", text: Binding<String>(get: {self.task.wrappedName}, set: {self.setName(name: $0)}), onEditingChanged: { changed in
                            if changed {
                                self.selectSelf()
                            }
                            else {
                                try? self.context.save()
                            }
                    }){
                        self.deSelectSelf()
                    }.disabled(selection != task)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.headline)
                    
                    TextField("Add Memo", text: $memo, onEditingChanged: { changed in
                        if changed {
                            self.selectSelf()
                        }
                    }){
                        self.deSelectSelf()
                    }
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    HStack{
                        Spacer()
                        DueDate(task: task, isSelected: (self.selection == self.task))
                    }
                }.padding(.all, 10)
            }
            else{
                HStack{
                    Text(task.wrappedName)
                        .font(.headline).padding(.all, 10)
                    Spacer()
                    DueDate(task: task, isSelected: (self.selection == self.task))
                }
            }
                        
                    
                
            
    }
//        .padding(.top, 10)
        .gesture(TapGesture()
            .onEnded {
                if self.selection == nil{//toggle on
                    withAnimation{
                        self.selection = self.task
                    }
                }
                else if self.selection == self.task{ //toggle off
                    withAnimation{
                        self.selection = nil
                    }
                }
                else if self.selection != self.task { //reset
                    withAnimation{
                        self.selection = nil
                    }
                }
            }
        )
        .frame(height: self.selection == self.task ? 100 : 40)
            .background(self.selection == self.task ?  Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
    @State static var selection: Task? = nil
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = "Preview"
        newTask.dateAdded = Date()
        return TaskRow(selection: $selection, task: newTask)
    }
}
#endif

