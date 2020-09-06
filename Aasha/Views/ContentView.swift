//
//  ContentView.swift
//  Aasha
//
//  Created by Garima Bothra on 20/08/20.
//

import SwiftUI

struct ContentView: View {

    let sceneDelegate = UIApplication.shared.connectedScenes
        .first!.delegate as! SceneDelegate
    
    var body: some View {
        TabView {
            HomeView().environment(\.managedObjectContext, sceneDelegate.persistentContainer.viewContext)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Library")
                }
            TranslateView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Translate")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
