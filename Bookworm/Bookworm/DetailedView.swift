//
//  DetailedView.swift
//  Bookworm
//
//  Created by Adarsh Singh on 21/04/23.
//

import SwiftUI
import CoreData
struct DetailedView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy" )
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5,y: -5)
                
            }
            Text(book.author ?? "Unknown")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(book.review ?? "No review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            
        }.alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
    }
    func deleteBook() {
        moc.delete(book)

        // uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }

}

struct DetailedView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
                book.title = "Test book"
                book.author = "Test author"
                book.genre = "Fantasy"
                book.rating = 4
                book.review = "This was a great book; I really enjoyed it."

                return NavigationView {
                    DetailedView(book: book)
        }
    }
}
