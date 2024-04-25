//
//  TodoListApp.swift
//  TodoList
//
//  Created by mac on 4/25/24.
//

import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
