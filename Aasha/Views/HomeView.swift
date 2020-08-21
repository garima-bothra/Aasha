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
        NavigationView {
            List(books, id: \.self) { book in
                Text(book.name ?? "Unknown")
            }
        .navigationTitle("Your Documents")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                 self.showPicker = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showPicker) {
            AddFileView().environment(\.managedObjectContext, sceneDelegate.persistentContainer.viewContext)
        }
    }

    func delete(at offsets: IndexSet) {
        }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
