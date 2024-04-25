//
//  AddTodoListView.swift
//  TodoList
//
//  Created by mac on 4/25/24.
//

import SwiftUI
import SwiftData

struct AddTodoListView: View {
    @Binding var showSheet: Bool
    @Environment(\.modelContext) var modelContext

    
    @State var todoText:String = ""
    @State private var selectedPriority: Priority = .low
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $todoText)
                    .border(.black, width: 2)
                    .frame(height: 300)
                
                Picker("우선순위", selection: $selectedPriority) {
                    Text("높음").tag(Priority.high)
                    Text("중간").tag(Priority.medium)
                    Text("낮음").tag(Priority.low)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                Button {
                    AddTodoList()
                } label: {
                    Text("추가하기")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("할 일 추가하기")
            
            
            Spacer()
        }
    }
    
    // 리스트 추가
    private func AddTodoList() {
        let newTodo = Task(completed: false, taskDescription: todoText, priority: selectedPriority)
        modelContext.insert(newTodo)
        showSheet = false
    }
}

#Preview {
    AddTodoListView(showSheet: .constant(true))
        .modelContainer(for: Task.self, inMemory: true)
}
