//
//  ContentView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        PeopleListView()
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        ContentView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
