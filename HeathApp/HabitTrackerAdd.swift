//
//  HabitTrackerAdd.swift
//  HeathApp
//
//  Created by Nitin Bhilkar on 6/15/23.
//

import SwiftUI
import Foundation


struct HabitTrackerAdd: View {
    @Environment(\.managedObjectContext) var context
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }

    @FetchRequest(
            entity: Habit.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Habit.id, ascending: false) ])
        
    var toDoItems: FetchedResults<HabitX>
@State private var showNewHabit = false
    var body: some View {
        VStack {
            
            HStack {
                Text("Healthy Habits!")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .padding(.leading)
                Button(action: {
                    self.showNewHabit = true
                }) {
                    Text("+")
                    
                }
            
               
                List {
                        ForEach (toDoItems)
                    {Habit in
                        Text(Habit.title ?? "No title")
                            }
                }
                .onDelete(perform: deleteTask)
            }
            
            

        }
        if showNewHabit {
            NewHabitView(showNewHabit: $showNewHabit, title: "", isCompleted: false)
                }
    }
}

struct HabitTrackerAdd_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackerAdd()
    }
}
