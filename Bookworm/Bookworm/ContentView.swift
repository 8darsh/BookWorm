//
//  ContentView.swift
//  Bookworm
//
//  Created by Adarsh Singh on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    @State private var showAddbook = false
    var body: some View {
        NavigationView{
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailedView(book: book)
                    } label: {
                        HStack {
                            EmojiView(rating: book.rating)
                                .font(.subheadline)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating < 3 ? .red : .white)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            
                .navigationTitle("Bookworm")
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showAddbook.toggle()
                            
                        }label: {
                            Label("Add Book", systemImage: "plus")
                        }
                        
                    }
                }
                .sheet(isPresented: $showAddbook){
                    AddBookView()
                }
            
        }
        
        
        
    }
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
