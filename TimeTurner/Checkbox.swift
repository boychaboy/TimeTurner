//
//  Checkbox.swift
//  TimeTurner
//
//  Created by Kun Jeong on 2020/01/23.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import SwiftUI
import Dispatch

struct CheckBoxStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
//            .foregroundColor(.white)
//            .cornerRadius(40)
    }
}

struct Checkbox : View {
    @Environment(\.managedObjectContext) var context
    var task: Task
    @State var isComplete = false
    var body: some View {

         Button(action:
            {
                self.completeTask(self.task)
        }) {
            HStack(alignment: .top, spacing: 10) {

                        //2. Will update according to state
                   Rectangle()
                    .fill(self.isComplete ? Color.green : Color.red)
                            .frame(width:20, height:20, alignment: .center)
                    .border(Color.green, width: 3)
                    .cornerRadius(3)
            }
        }.buttonStyle(CheckBoxStyle())

    }
    func completeTask(_ task: Task){
        self.isComplete.toggle()
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            self.updateTask(task)
        })
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

//struct Checkbox_Previews: PreviewProvider {
//    static var previews: some View {
//        Checkbox()
//    }
//}
