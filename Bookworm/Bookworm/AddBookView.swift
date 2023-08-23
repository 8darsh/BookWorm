//
//  AddBookView.swift
//  Bookworm
//
//  Created by Adarsh Singh on 21/04/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var review = ""
    @State private var genre = ""
    @State private var author = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Comedy", "Drama", "Sci-Fi"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name Of Book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }header: {
                    Text("Write a review")
                }
                Section{
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()

                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}