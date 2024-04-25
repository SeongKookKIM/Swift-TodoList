
import SwiftUI
import SwiftData



struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var todoList: [Task]
    
    
    @State var showSheet = false
    @State var searchText = ""
    


    // 검색
    var searchTodoListResults: [Task] {
        if searchText.isEmpty {
            return todoList
        } else {
            return todoList.filter { $0.taskDescription.lowercased().contains(searchText.lowercased()) }
        }
    }
            
     
 
    
    var body: some View {
        
        List {
            if todoList.count == 0 {
                Text("List가 존재하지 않습니다")
                    .font(.system(size:20))
            }
            
            ForEach(searchTodoListResults) { list in
                
                HStack(spacing:20) {
                    Button {
                        onClickList(list)
                        
                    } label: {
                        Circle()
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 20, height: 20)
                    }
                    .overlay(
                        list.completed ?
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 10, height: 10):
                            nil
                    )
                    
                    
                    Text(list.taskDescription)
                    
                    Spacer()
                    
                    Text(list.priority.description)
                        .foregroundStyle(list.priority.color)
                    
                   
                    
                }
                .contextMenu {
                    Button {
                        modelContext.delete(list)
                    } label: {
                        Image(systemName: "trash")
                        Text("삭제")
                    }
                }
            }
            
        }
        .navigationTitle("TodoList")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("추가") {
                    showSheet = true
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            AddTodoListView(showSheet: $showSheet)
        }
        .searchable(text: $searchText, prompt: "Search a list")
        // 클릭시 나눠서 검색..ㅠㅠ
//        .searchScopes( activation: .onSearchPresentation) {
//                        Text("All").tag()
//                        Text("높음").tag()
//                        Text("중간").tag()
//                        Text("낮음").tag()
//                    }
     
        
    }
    // 클릭시 completed 변경
    private func onClickList(_ list: Task) {
        list.completed = !list.completed
    }
    
    // 해당 리스트 삭제 (contextMenu)
    private func removeList(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(todoList[index])
        }
    }
}





#Preview {
    NavigationStack{
        ContentView()
            .modelContainer(for: Task.self, inMemory: true)
    }
}
