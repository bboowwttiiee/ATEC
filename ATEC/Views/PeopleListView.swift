//
//  PeopleListView.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI

struct PeopleListView: View {
    // MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var isShowingAddPersonPage: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allPersons: FetchedResults<Person>
    
    private func deletePerson(at offset: IndexSet) {
        offset.forEach { index in
            let person = allPersons[index]
            viewContext.delete(person)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(allPersons) { person in
                            let personAvatar = UIImage(data: person.avatar! as Data)
                            NavigationLink {
                                PersonPageView(photo: personAvatar!, name: person.name ?? "", age: "\(calculateAge(fromDate: person.birthdate ?? Date()))")
                            } label: {
                                PersonRowView(photo: personAvatar!, name: person.name ?? "", age: "\(calculateAge(fromDate: person.birthdate ?? Date()))")
                                    .padding(.horizontal)
                            }
                        } //: LOOP
                        //                        .onDelete(perform: deletePerson)
                    } //: VSTACK
                } //: SCROLL
                .navigationTitle("People List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingAddPersonPage = true
                        }) {
                            Image(systemName: "plus.circle")
                        } //: BUTTON
                        .sheet(isPresented: $isShowingAddPersonPage) {
                            AddPersonPageView()
                                .preferredColorScheme(isDarkMode ? .dark : .light)
                            
                        }
                        .tint(isDarkMode ? .white : .black)
                    }
                } //: TOOLBAR
                
                if allPersons.isEmpty {
                    VStack {
                        Text("Add new person")
                        
                        HStack {
                            Text("by clicking")
                            Image(systemName: "plus.circle")
                            Text("button.")
                        }
                    }
                    .font(.body.italic())
                    .opacity(0.25)
                    .offset(y: -30)
                }
            } //: ZSTACK
        } //: NAVIGATION
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: - PREVIEW
struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        PeopleListView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
