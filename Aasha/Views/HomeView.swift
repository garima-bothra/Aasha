//
//  HomeView.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI
import CoreData
struct HomeView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Book.entity(), sortDescriptors:[]) var books: FetchedResults<Book>

    let sceneDelegate = UIApplication.shared.connectedScenes
        .first!.delegate as! SceneDelegate


    @State var showPicker = false
    
    var body: some View {
        
        GeometryReader { geometry in
            let columns = [
                GridItem(.adaptive(minimum: geometry.size.width / 2 - 10) )
            ]
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(books, id: \.self) { book in
                            BookGridView(book: book).environment(\.managedObjectContext, sceneDelegate.persistentContainer.viewContext) .frame(maxWidth: geometry.size.width / 2 - 10, minHeight: geometry.size.width / 2 - 10, maxHeight: geometry.size.width / 2 - 10)
                                .cornerRadius(10)
                        }
                    }
                }
                .navigationTitle("Your Library")
                .navigationBarItems(trailing: Button(action: {
                    self.showPicker = true
                }){
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showPicker) {
                AddFileView(languages: Languages()).environment(\.managedObjectContext, sceneDelegate.persistentContainer.viewContext)
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            managedObjectContext.delete(book)
        }
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
