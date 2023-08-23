//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Adarsh Singh on 17/04/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @State private var datacontroller = DataController()
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
