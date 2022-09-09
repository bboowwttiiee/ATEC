//
//  PeopleListView.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI

struct PeopleListView: View {
    // MARK: - PROPERTIES
    @State private var isShowingAddPersonPage: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Person.ownFetchRequest)
    var allPersons: FetchedResults<Person>
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(allPersons) { person in
                            let personAvatar = UIImage(data: person.avatar! as Data)
                            NavigationLink {
                                PersonPageView(photo: personAvatar!, name: person.name ?? "", isFemale: person.gender, age: "\(calculateAge(fromDate: person.birthdate ?? Date()))", person: person)
                            } label: {
                                PersonRowView(photo: personAvatar!, name: person.name ?? "", age: "\(calculateAge(fromDate: person.birthdate ?? Date()))")
                                    .padding(.horizontal)
                            }
                        } //: LOOP
                    } //: VSTACK
                    .padding(.bottom, getSafeArea().bottom + 60)
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
                        }
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
